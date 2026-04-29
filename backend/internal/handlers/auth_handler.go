package handlers

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v5"
	"github.com/zetxc/tush-backend/internal/middleware"
	"github.com/zetxc/tush-backend/internal/models"
	"github.com/zetxc/tush-backend/internal/services"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type AuthHandler struct {
	db           *gorm.DB
	jwtSecret    string
	emailService *services.EmailService
}

func NewAuthHandler(db *gorm.DB, jwtSecret string, emailService *services.EmailService) *AuthHandler {
	return &AuthHandler{db: db, jwtSecret: jwtSecret, emailService: emailService}
}

func (h *AuthHandler) Register(c *fiber.Ctx) error {
	var body struct {
		Email    string  `json:"email"`
		Password string  `json:"password"`
		Name     *string `json:"name"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}
	if body.Email == "" || body.Password == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "email and password are required"})
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(body.Password), bcrypt.DefaultCost)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "failed to hash password"})
	}

	code := generateCode()
	expires := time.Now().Add(15 * time.Minute)

	user := &models.User{
		Email:                 body.Email,
		PasswordHash:          string(hash),
		Name:                  body.Name,
		IsActive:              false,
		ConfirmationCode:      &code,
		ConfirmationExpiresAt: &expires,
	}

	if err := h.db.Create(user).Error; err != nil {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "email already registered"})
	}

	_ = h.emailService.SendConfirmationCode(body.Email, code)

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"message": "Registration successful. Please check your email for the confirmation code.",
	})
}

func (h *AuthHandler) ConfirmAccount(c *fiber.Ctx) error {
	var body struct {
		Email string `json:"email"`
		Code  string `json:"code"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	var user models.User
	if err := h.db.Where("email = ?", body.Email).First(&user).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found"})
	}

	if user.IsActive {
		return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Account already confirmed"})
	}

	if user.ConfirmationCode == nil || *user.ConfirmationCode != body.Code {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid confirmation code"})
	}

	if user.ConfirmationExpiresAt != nil && time.Now().After(*user.ConfirmationExpiresAt) {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "confirmation code expired"})
	}

	h.db.Model(&user).Updates(map[string]any{
		"is_active":               true,
		"confirmation_code":       nil,
		"confirmation_expires_at": nil,
	})

	return c.JSON(fiber.Map{"message": "Account confirmed. You can now sign in."})
}

func (h *AuthHandler) Login(c *fiber.Ctx) error {
	var body struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	var user models.User
	if err := h.db.Where("email = ?", body.Email).First(&user).Error; err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Incorrect username or password"})
	}

	if !user.IsActive {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "user_not_confirmed"})
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(body.Password)); err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Incorrect username or password"})
	}

	token, err := h.generateToken(user)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "failed to generate token"})
	}

	return c.JSON(fiber.Map{
		"token": token,
		"user": fiber.Map{
			"id":    user.ID,
			"email": user.Email,
			"name":  user.Name,
		},
	})
}

func (h *AuthHandler) Me(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	var user models.User
	if err := h.db.First(&user, "id = ?", userID).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found"})
	}

	return c.JSON(fiber.Map{
		"id":    user.ID,
		"email": user.Email,
		"name":  user.Name,
	})
}

func (h *AuthHandler) ChangePassword(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	var body struct {
		OldPassword string `json:"old_password"`
		NewPassword string `json:"new_password"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	var user models.User
	if err := h.db.First(&user, "id = ?", userID).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "user not found"})
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(body.OldPassword)); err != nil {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "incorrect current password"})
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(body.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "failed to hash password"})
	}

	h.db.Model(&user).Update("password_hash", string(hash))
	return c.JSON(fiber.Map{"message": "Password changed successfully"})
}

func (h *AuthHandler) ForgotPassword(c *fiber.Ctx) error {
	var body struct {
		Email string `json:"email"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	var user models.User
	if err := h.db.Where("email = ?", body.Email).First(&user).Error; err != nil {
		// Don't reveal whether user exists
		return c.JSON(fiber.Map{"message": "If this email exists, a reset code has been sent."})
	}

	code := generateCode()
	expires := time.Now().Add(15 * time.Minute)
	h.db.Model(&user).Updates(map[string]any{
		"reset_code":      code,
		"reset_expires_at": expires,
	})

	_ = h.emailService.SendResetCode(body.Email, code)

	return c.JSON(fiber.Map{"message": "If this email exists, a reset code has been sent."})
}

func (h *AuthHandler) ResetPassword(c *fiber.Ctx) error {
	var body struct {
		Email       string `json:"email"`
		Code        string `json:"code"`
		NewPassword string `json:"new_password"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	var user models.User
	if err := h.db.Where("email = ?", body.Email).First(&user).Error; err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid or expired code"})
	}

	if user.ResetCode == nil || *user.ResetCode != body.Code {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid or expired code"})
	}

	if user.ResetExpiresAt != nil && time.Now().After(*user.ResetExpiresAt) {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "code has expired"})
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(body.NewPassword), bcrypt.DefaultCost)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "failed to hash password"})
	}

	h.db.Model(&user).Updates(map[string]any{
		"password_hash":    string(hash),
		"reset_code":       nil,
		"reset_expires_at": nil,
	})

	return c.JSON(fiber.Map{"message": "Password reset successfully"})
}

func (h *AuthHandler) DeleteAccount(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	h.db.Where("user_id = ? OR friend_id = ?", userID, userID).Delete(&models.Friend{})
	h.db.Where("recipient_id = ? OR sender_id = ?", userID, userID).Delete(&models.FriendRequest{})
	h.db.Where("user_id = ?", userID).Delete(&models.Dream{})
	h.db.Delete(&models.User{}, "id = ?", userID)

	return c.JSON(fiber.Map{"message": "Account deleted"})
}

func (h *AuthHandler) generateToken(user models.User) (string, error) {
	claims := middleware.Claims{
		UserID: user.ID,
		Email:  user.Email,
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(30 * 24 * time.Hour)),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString([]byte(h.jwtSecret))
}

func generateCode() string {
	return fmt.Sprintf("%06d", rand.Intn(1000000))
}

package handlers

import (
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
	"github.com/zetxc/tush-backend/internal/middleware"
	"github.com/zetxc/tush-backend/internal/models"
	"gorm.io/gorm"
)

type FriendsHandler struct {
	db *gorm.DB
}

func NewFriendsHandler(db *gorm.DB) *FriendsHandler {
	return &FriendsHandler{db: db}
}

type friendUserResponse struct {
	ID    string  `json:"id"`
	Email string  `json:"email"`
	Name  *string `json:"name"`
}

func userToFriendResponse(u models.User) friendUserResponse {
	return friendUserResponse{
		ID:    u.ID.String(),
		Email: u.Email,
		Name:  u.Name,
	}
}

func (h *FriendsHandler) AddFriend(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	var body struct {
		FriendID string `json:"friendId"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}
	if body.FriendID == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "friendId is required"})
	}

	friendID, err := uuid.Parse(body.FriendID)
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid friendId"})
	}
	if friendID == userID {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "cannot add yourself as a friend"})
	}

	// Check already friends
	var existingFriend models.Friend
	if h.db.Where("user_id = ? AND friend_id = ?", userID, friendID).First(&existingFriend).Error == nil {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "already friends"})
	}

	// Check if request already sent
	var existingReq models.FriendRequest
	if h.db.Where("recipient_id = ? AND sender_id = ?", friendID, userID).First(&existingReq).Error == nil {
		return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "friend request already sent"})
	}

	// Check if reverse request exists (auto-accept)
	var reverseReq models.FriendRequest
	if h.db.Where("recipient_id = ? AND sender_id = ?", userID, friendID).First(&reverseReq).Error == nil {
		now := time.Now()
		h.db.Create(&models.Friend{UserID: userID, FriendID: friendID, CreatedAt: now})
		h.db.Create(&models.Friend{UserID: friendID, FriendID: userID, CreatedAt: now})
		h.db.Delete(&reverseReq)
		return c.Status(fiber.StatusCreated).JSON(fiber.Map{"message": "friend added successfully"})
	}

	// Send friend request
	h.db.Create(&models.FriendRequest{
		RecipientID: friendID,
		SenderID:    userID,
		CreatedAt:   time.Now(),
	})

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{"message": "friend request sent"})
}

func (h *FriendsHandler) ListFriends(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	var friendLinks []models.Friend
	h.db.Where("user_id = ?", userID).Find(&friendLinks)

	if len(friendLinks) == 0 {
		return c.JSON(fiber.Map{"friends": []any{}})
	}

	friendIDs := make([]uuid.UUID, len(friendLinks))
	for i, f := range friendLinks {
		friendIDs[i] = f.FriendID
	}

	var users []models.User
	h.db.Where("id IN ?", friendIDs).Find(&users)

	result := make([]friendUserResponse, len(users))
	for i, u := range users {
		result[i] = userToFriendResponse(u)
	}

	return c.JSON(fiber.Map{"friends": result})
}

func (h *FriendsHandler) DeleteFriend(c *fiber.Ctx) error {
	userID := middleware.UserID(c)
	friendID, err := uuid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid friend id"})
	}

	h.db.Where("user_id = ? AND friend_id = ?", userID, friendID).Delete(&models.Friend{})
	h.db.Where("user_id = ? AND friend_id = ?", friendID, userID).Delete(&models.Friend{})

	return c.JSON(fiber.Map{"message": "friend removed"})
}

func (h *FriendsHandler) ListFriendRequests(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	var requests []models.FriendRequest
	h.db.Where("recipient_id = ?", userID).Find(&requests)

	if len(requests) == 0 {
		return c.JSON(fiber.Map{"requests": []any{}})
	}

	senderIDs := make([]uuid.UUID, len(requests))
	for i, r := range requests {
		senderIDs[i] = r.SenderID
	}

	var users []models.User
	h.db.Where("id IN ?", senderIDs).Find(&users)

	result := make([]friendUserResponse, len(users))
	for i, u := range users {
		result[i] = userToFriendResponse(u)
	}

	return c.JSON(fiber.Map{"requests": result})
}

func (h *FriendsHandler) AcceptFriendRequest(c *fiber.Ctx) error {
	userID := middleware.UserID(c)
	senderID, err := uuid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid sender id"})
	}

	var req models.FriendRequest
	if err := h.db.Where("recipient_id = ? AND sender_id = ?", userID, senderID).First(&req).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "friend request not found"})
	}

	now := time.Now()
	h.db.Create(&models.Friend{UserID: userID, FriendID: senderID, CreatedAt: now})
	h.db.Create(&models.Friend{UserID: senderID, FriendID: userID, CreatedAt: now})
	h.db.Delete(&req)

	return c.JSON(fiber.Map{"message": "friend request accepted"})
}

func (h *FriendsHandler) DeclineFriendRequest(c *fiber.Ctx) error {
	userID := middleware.UserID(c)
	senderID, err := uuid.Parse(c.Params("id"))
	if err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid sender id"})
	}

	h.db.Where("recipient_id = ? AND sender_id = ?", userID, senderID).Delete(&models.FriendRequest{})
	return c.JSON(fiber.Map{"message": "friend request declined"})
}

package handlers

import (
	"github.com/gofiber/fiber/v2"
	"github.com/zetxc/tush-backend/internal/middleware"
	"github.com/zetxc/tush-backend/internal/models"
	"gorm.io/gorm"
)

type UsersHandler struct {
	db *gorm.DB
}

func NewUsersHandler(db *gorm.DB) *UsersHandler {
	return &UsersHandler{db: db}
}

func (h *UsersHandler) SearchUsers(c *fiber.Ctx) error {
	currentUserID := middleware.UserID(c)
	query := c.Query("query", "")

	if len(query) < 2 {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "query must be at least 2 characters"})
	}

	var users []models.User
	h.db.Where("email ILIKE ? AND id != ? AND is_active = true", "%"+query+"%", currentUserID).
		Limit(20).
		Find(&users)

	result := make([]friendUserResponse, len(users))
	for i, u := range users {
		result[i] = userToFriendResponse(u)
	}

	return c.JSON(fiber.Map{"users": result})
}

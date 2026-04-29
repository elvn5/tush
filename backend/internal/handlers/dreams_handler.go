package handlers

import (
	"encoding/base64"
	"fmt"
	"strconv"
	"strings"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/zetxc/tush-backend/internal/middleware"
	"github.com/zetxc/tush-backend/internal/models"
	"github.com/zetxc/tush-backend/internal/services"
	"gorm.io/gorm"
)

type DreamsHandler struct {
	db        *gorm.DB
	aiService *services.AIService
}

func NewDreamsHandler(db *gorm.DB, aiService *services.AIService) *DreamsHandler {
	return &DreamsHandler{db: db, aiService: aiService}
}

type dreamResponse struct {
	DreamID        string `json:"dreamId"`
	Title          string `json:"title"`
	Dream          string `json:"dream"`
	Interpretation string `json:"interpretation"`
	IsReady        bool   `json:"isReady"`
	CreatedAt      int64  `json:"createdAt"`
}

func toDreamResponse(d models.Dream) dreamResponse {
	return dreamResponse{
		DreamID:        d.ID.String(),
		Title:          d.Title,
		Dream:          d.Text,
		Interpretation: d.Interpretation,
		IsReady:        d.IsReady,
		CreatedAt:      d.CreatedAt.UnixMilli(),
	}
}

func (h *DreamsHandler) Create(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	var body struct {
		Title string `json:"title"`
		Dream string `json:"dream"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}
	if body.Dream == "" {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "dream text is required"})
	}

	title := body.Title
	if title == "" {
		if len(body.Dream) > 20 {
			title = body.Dream[:20] + "..."
		} else {
			title = body.Dream
		}
	}

	dream := &models.Dream{
		UserID:  userID,
		Title:   title,
		Text:    body.Dream,
		IsReady: false,
	}
	if err := h.db.Create(dream).Error; err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "could not create dream"})
	}

	h.aiService.InterpretAsync(dream.ID, dream.Text)

	return c.Status(fiber.StatusOK).JSON(toDreamResponse(*dream))
}

func (h *DreamsHandler) List(c *fiber.Ctx) error {
	userID := middleware.UserID(c)

	limit, _ := strconv.Atoi(c.Query("limit", "10"))
	cursor := c.Query("cursor", "")
	search := c.Query("search", "")
	statusStr := c.Query("status", "")
	startDateStr := c.Query("startDate", "")
	endDateStr := c.Query("endDate", "")

	offset := 0
	if cursor != "" {
		if decoded, err := base64.StdEncoding.DecodeString(cursor); err == nil {
			offset, _ = strconv.Atoi(string(decoded))
		}
	}

	query := h.db.Where("user_id = ?", userID)

	if search != "" {
		like := "%" + search + "%"
		query = query.Where("title ILIKE ? OR text ILIKE ?", like, like)
	}
	if statusStr != "" {
		query = query.Where("is_ready = ?", statusStr == "true")
	}
	if startDateStr != "" {
		if ms, err := strconv.ParseInt(startDateStr, 10, 64); err == nil {
			query = query.Where("created_at >= ?", time.UnixMilli(ms))
		}
	}
	if endDateStr != "" {
		if ms, err := strconv.ParseInt(endDateStr, 10, 64); err == nil {
			query = query.Where("created_at <= ?", time.UnixMilli(ms))
		}
	}

	var dreams []models.Dream
	query.Order("created_at DESC").Limit(limit).Offset(offset).Find(&dreams)

	var nextCursor *string
	if len(dreams) == limit {
		next := base64.StdEncoding.EncodeToString([]byte(fmt.Sprintf("%d", offset+limit)))
		nextCursor = &next
	}

	items := make([]dreamResponse, len(dreams))
	for i, d := range dreams {
		items[i] = toDreamResponse(d)
	}

	return c.JSON(fiber.Map{"items": items, "nextCursor": nextCursor})
}

func (h *DreamsHandler) Update(c *fiber.Ctx) error {
	userID := middleware.UserID(c)
	dreamID := c.Params("id")

	var body struct {
		Title string `json:"title"`
		Dream string `json:"dream"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid request body"})
	}

	var dream models.Dream
	if err := h.db.Where("id = ? AND user_id = ?", dreamID, userID).First(&dream).Error; err != nil {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "dream not found"})
	}

	updates := map[string]any{"updated_at": time.Now()}
	if body.Title != "" {
		updates["title"] = body.Title
	}
	if body.Dream != "" {
		updates["text"] = body.Dream
		updates["is_ready"] = false
		updates["interpretation"] = ""
	}

	h.db.Model(&dream).Updates(updates)

	if body.Dream != "" {
		h.aiService.InterpretAsync(dream.ID, body.Dream)
	}

	h.db.First(&dream)
	return c.JSON(toDreamResponse(dream))
}

func (h *DreamsHandler) Delete(c *fiber.Ctx) error {
	userID := middleware.UserID(c)
	dreamID := c.Params("id")

	result := h.db.Where("id = ? AND user_id = ?", dreamID, userID).Delete(&models.Dream{})
	if result.RowsAffected == 0 {
		return c.Status(fiber.StatusNotFound).JSON(fiber.Map{"error": "dream not found"})
	}

	return c.JSON(fiber.Map{"message": "dream deleted"})
}

func (h *DreamsHandler) GetFriendDreams(c *fiber.Ctx) error {
	userID := middleware.UserID(c)
	friendID := c.Params("id")

	// Verify friendship
	var count int64
	h.db.Model(&models.Friend{}).
		Where("user_id = ? AND friend_id = ?", userID, strings.ReplaceAll(friendID, "-", "")).
		Or("user_id = ? AND friend_id = ?", userID, friendID).
		Count(&count)
	if count == 0 {
		return c.Status(fiber.StatusForbidden).JSON(fiber.Map{"error": "not friends with this user"})
	}

	limit, _ := strconv.Atoi(c.Query("limit", "10"))
	cursor := c.Query("cursor", "")
	offset := 0
	if cursor != "" {
		if decoded, err := base64.StdEncoding.DecodeString(cursor); err == nil {
			offset, _ = strconv.Atoi(string(decoded))
		}
	}

	var dreams []models.Dream
	h.db.Where("user_id = ?", friendID).
		Order("created_at DESC").
		Limit(limit).Offset(offset).
		Find(&dreams)

	var nextCursor *string
	if len(dreams) == limit {
		next := base64.StdEncoding.EncodeToString([]byte(fmt.Sprintf("%d", offset+limit)))
		nextCursor = &next
	}

	items := make([]dreamResponse, len(dreams))
	for i, d := range dreams {
		items[i] = toDreamResponse(d)
	}

	return c.JSON(fiber.Map{"items": items, "nextCursor": nextCursor})
}

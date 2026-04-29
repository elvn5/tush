package models

import (
	"time"

	"github.com/google/uuid"
)

type Friend struct {
	UserID    uuid.UUID `gorm:"type:uuid;primaryKey" json:"userId"`
	FriendID  uuid.UUID `gorm:"type:uuid;primaryKey" json:"friendId"`
	CreatedAt time.Time `json:"created_at"`
}

type FriendRequest struct {
	RecipientID uuid.UUID `gorm:"type:uuid;primaryKey" json:"recipientId"`
	SenderID    uuid.UUID `gorm:"type:uuid;primaryKey" json:"senderId"`
	CreatedAt   time.Time `json:"created_at"`
}

package models

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Dream struct {
	ID             uuid.UUID `gorm:"type:uuid;primaryKey" json:"dreamId"`
	UserID         uuid.UUID `gorm:"type:uuid;not null;index" json:"userId"`
	Title          string    `gorm:"not null" json:"title"`
	Text           string    `gorm:"not null" json:"dream"`
	Interpretation string    `json:"interpretation"`
	IsReady        bool      `gorm:"default:false" json:"isReady"`
	CreatedAt      time.Time `json:"createdAt"`
	UpdatedAt      time.Time `json:"updatedAt"`
}

func (d *Dream) BeforeCreate(tx *gorm.DB) error {
	if d.ID == uuid.Nil {
		d.ID = uuid.New()
	}
	return nil
}

func (d *Dream) CreatedAtMs() int64 {
	return d.CreatedAt.UnixMilli()
}

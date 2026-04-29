package services

import (
	"fmt"
	"log"
	"net/smtp"

	"github.com/zetxc/tush-backend/internal/config"
)

type EmailService struct {
	cfg *config.Config
}

func NewEmailService(cfg *config.Config) *EmailService {
	return &EmailService{cfg: cfg}
}

func (s *EmailService) SendConfirmationCode(to, code string) error {
	subject := "Morpheus — подтверждение регистрации"
	body := fmt.Sprintf("Ваш код подтверждения: %s\n\nКод действителен 15 минут.", code)
	return s.send(to, subject, body)
}

func (s *EmailService) SendResetCode(to, code string) error {
	subject := "Morpheus — сброс пароля"
	body := fmt.Sprintf("Ваш код для сброса пароля: %s\n\nКод действителен 15 минут.", code)
	return s.send(to, subject, body)
}

func (s *EmailService) send(to, subject, body string) error {
	if s.cfg.SMTPHost == "" {
		// SMTP not configured — log code to console for development
		log.Printf("[EMAIL] To: %s | Subject: %s | Body: %s", to, subject, body)
		return nil
	}

	auth := smtp.PlainAuth("", s.cfg.SMTPUser, s.cfg.SMTPPassword, s.cfg.SMTPHost)
	msg := fmt.Sprintf("From: %s\r\nTo: %s\r\nSubject: %s\r\nContent-Type: text/plain; charset=UTF-8\r\n\r\n%s",
		s.cfg.SMTPFrom, to, subject, body)

	addr := fmt.Sprintf("%s:%s", s.cfg.SMTPHost, s.cfg.SMTPPort)
	if err := smtp.SendMail(addr, auth, s.cfg.SMTPFrom, []string{to}, []byte(msg)); err != nil {
		log.Printf("[EMAIL] Failed to send to %s: %v", to, err)
		return err
	}
	return nil
}

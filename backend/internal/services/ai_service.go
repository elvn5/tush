package services

import (
	"context"
	"fmt"
	"log"

	"github.com/google/generative-ai-go/genai"
	"github.com/google/uuid"
	"github.com/zetxc/tush-backend/internal/models"
	"google.golang.org/api/option"
	"gorm.io/gorm"
)

const interpretationPrompt = `«Действуй как профессиональный психолог и аналитик сновидений (используя подход Юнга и современные когнитивные методики).
Я опишу тебе свой сон. Твоя задача — помочь мне понять, что мое подсознание пытается сообщить мне о моем текущем состоянии, страхах или желаниях.
Проанализируй сон по следующей структуре:
Ключевые символы: Выдели 3-4 главных образа и объясни их возможные метафорические значения (не как в гадании, а как архетипы или ассоциации).
Эмоциональный фон: Проанализируй чувства во сне. О чем они могут сигнализировать в реальной жизни?
Связь с реальностью: Предположи, как сюжет сна может перекликаться с моими текущими жизненными ситуациями, конфликтами или нерешенными задачами.
Практические вопросы: Задай мне 3 глубоких коучинговых вопроса, которые помогут мне самому найти ответ.
Совет/Действие: Предложи одно небольшое действие или мысль, на которой стоит сфокусироваться сегодня, исходя из этого сна.
Важно: Не предсказывай будущее. Фокусируйся на моем внутреннем мире и эмоциональном состоянии.
Мой сон:`

type AIService struct {
	apiKey string
	db     *gorm.DB
}

func NewAIService(apiKey string, db *gorm.DB) *AIService {
	return &AIService{apiKey: apiKey, db: db}
}

func (s *AIService) InterpretAsync(dreamID uuid.UUID, dreamText string) {
	go func() {
		interpretation, err := s.interpret(dreamText)
		if err != nil {
			log.Printf("[AI] Failed to interpret dream %s: %v", dreamID, err)
			return
		}

		if err := s.db.Model(&models.Dream{}).
			Where("id = ?", dreamID).
			Updates(map[string]any{
				"interpretation": interpretation,
				"is_ready":       true,
			}).Error; err != nil {
			log.Printf("[AI] Failed to save interpretation for dream %s: %v", dreamID, err)
		}
	}()
}

func (s *AIService) interpret(dreamText string) (string, error) {
	if s.apiKey == "" {
		return "AI interpretation is not configured (GEMINI_API_KEY missing).", nil
	}

	ctx := context.Background()
	client, err := genai.NewClient(ctx, option.WithAPIKey(s.apiKey))
	if err != nil {
		return "", fmt.Errorf("create gemini client: %w", err)
	}
	defer client.Close()

	model := client.GenerativeModel("gemini-1.5-flash")
	resp, err := model.GenerateContent(ctx, genai.Text(interpretationPrompt+"\n"+dreamText))
	if err != nil {
		return "", fmt.Errorf("generate content: %w", err)
	}

	if len(resp.Candidates) == 0 || len(resp.Candidates[0].Content.Parts) == 0 {
		return "", fmt.Errorf("empty response from gemini")
	}

	text, ok := resp.Candidates[0].Content.Parts[0].(genai.Text)
	if !ok {
		return "", fmt.Errorf("unexpected response part type")
	}
	return string(text), nil
}

package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/fiber/v2/middleware/recover"
	"github.com/zetxc/tush-backend/internal/config"
	"github.com/zetxc/tush-backend/internal/database"
	"github.com/zetxc/tush-backend/internal/handlers"
	mw "github.com/zetxc/tush-backend/internal/middleware"
	"github.com/zetxc/tush-backend/internal/services"
)

func main() {
	cfg := config.Load()
	db := database.Connect(cfg.DatabaseURL)

	emailSvc := services.NewEmailService(cfg)
	aiSvc := services.NewAIService(cfg.GeminiAPIKey, db)

	authH := handlers.NewAuthHandler(db, cfg.JWTSecret, emailSvc)
	dreamsH := handlers.NewDreamsHandler(db, aiSvc)
	friendsH := handlers.NewFriendsHandler(db)
	usersH := handlers.NewUsersHandler(db)

	app := fiber.New(fiber.Config{
		ErrorHandler: func(c *fiber.Ctx, err error) error {
			code := fiber.StatusInternalServerError
			if e, ok := err.(*fiber.Error); ok {
				code = e.Code
			}
			return c.Status(code).JSON(fiber.Map{"error": err.Error()})
		},
	})

	app.Use(recover.New())
	app.Use(logger.New())
	app.Use(cors.New(cors.Config{
		AllowOrigins: "*",
		AllowHeaders: "Origin, Content-Type, Accept, Authorization",
		AllowMethods: "GET, POST, PUT, DELETE, OPTIONS",
	}))

	// Health check
	app.Get("/health", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{"status": "ok"})
	})

	// Auth routes (public)
	auth := app.Group("/auth")
	auth.Post("/register", authH.Register)
	auth.Post("/confirm", authH.ConfirmAccount)
	auth.Post("/login", authH.Login)
	auth.Post("/forgot-password", authH.ForgotPassword)
	auth.Post("/reset-password", authH.ResetPassword)

	// Auth routes (protected)
	authGuard := mw.Auth(cfg.JWTSecret)
	auth.Get("/me", authGuard, authH.Me)
	auth.Put("/password", authGuard, authH.ChangePassword)
	auth.Delete("/me", authGuard, authH.DeleteAccount)

	// Dreams routes (protected)
	dreams := app.Group("/dreams", authGuard)
	dreams.Post("/", dreamsH.Create)
	dreams.Get("/", dreamsH.List)
	dreams.Put("/:id", dreamsH.Update)
	dreams.Delete("/:id", dreamsH.Delete)

	// Friends routes (protected)
	friends := app.Group("/friends", authGuard)
	friends.Post("/", friendsH.AddFriend)
	friends.Get("/", friendsH.ListFriends)
	friends.Delete("/:id", friendsH.DeleteFriend)
	friends.Get("/:id/dreams", dreamsH.GetFriendDreams)

	// Friend requests routes (protected)
	reqs := app.Group("/friend-requests", authGuard)
	reqs.Get("/", friendsH.ListFriendRequests)
	reqs.Post("/:id/accept", friendsH.AcceptFriendRequest)
	reqs.Post("/:id/decline", friendsH.DeclineFriendRequest)

	// Users routes (protected)
	users := app.Group("/users", authGuard)
	users.Get("/search", usersH.SearchUsers)

	log.Printf("Server starting on port %s", cfg.Port)
	log.Fatal(app.Listen(":" + cfg.Port))
}

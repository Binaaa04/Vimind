package main

import (
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
)

func main() {
	app := fiber.New()

	// Default CORS config (allows everything)
	app.Use(cors.New())

	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Set up root backend.")
	})

	app.Post("/login", func(c *fiber.Ctx) error {
		type LoginRequest struct {
			Email    string `json:"email"`
			Password string `json:"password"`
		}
		var req LoginRequest
		if err := c.BodyParser(&req); err != nil {
			return c.Status(400).JSON(fiber.Map{"message": "Invalid request"})
		}

		if req.Email == "test@vimind.com" && req.Password == "password123" {
			return c.JSON(fiber.Map{"message": "Login successful", "user": req.Email})
		}
		return c.Status(401).JSON(fiber.Map{"message": "Login failed"})
	})

	app.Listen(":8080")
}

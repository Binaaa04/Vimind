package controllers

import (
	"pbl-vimind/backend/internal/models"

	"github.com/gofiber/fiber/v2"
)

// ============================================================
// Feedback (Testimonials & Account Deletion)
// ============================================================

// GET /api/testimonials (Public)
func (h *Handler) GetPublicTestimonials(c *fiber.Ctx) error {
	list, err := h.Repo.GetPublicTestimonials()
	if err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to fetch testimonials"})
	}
	if list == nil {
		list = []models.Testimonial{}
	}
	return c.JSON(list)
}

// POST /api/testimonials
func (h *Handler) SubmitTestimonial(c *fiber.Ctx) error {
	var t models.Testimonial
	if err := c.BodyParser(&t); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid request body"})
	}
	if t.Name == "" || t.Comment == "" || t.Rating < 1 || t.Rating > 5 {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid testimonial data"})
	}
	if err := h.Repo.InsertTestimonial(t); err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to submit testimonial"})
	}
	return c.JSON(fiber.Map{"message": "Testimonial submitted successfully"})
}

// POST /api/account_feedbacks
func (h *Handler) SubmitAccountFeedback(c *fiber.Ctx) error {
	var body struct {
		Email  string `json:"email"`
		Reason string `json:"reason"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid request body"})
	}
	if body.Reason == "" {
		return c.Status(400).JSON(fiber.Map{"error": "Reason is required"})
	}
	// Note: email is optional (can be blank if guest or anonymous)
	if err := h.Repo.InsertAccountFeedback(body.Email, body.Reason); err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to submit account feedback"})
	}
	return c.JSON(fiber.Map{"message": "Feedback submitted successfully"})
}

// GET /api/admin/testimonials
func (h *Handler) GetAllTestimonials(c *fiber.Ctx) error {
	list, err := h.Repo.GetAllTestimonials()
	if err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to fetch testimonials"})
	}
	if list == nil {
		list = []models.Testimonial{}
	}
	return c.JSON(list)
}

// PUT /api/admin/testimonials/:id/display
func (h *Handler) UpdateTestimonialDisplay(c *fiber.Ctx) error {
	id, err := c.ParamsInt("id")
	if err != nil {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid testimonial ID"})
	}
	var body struct {
		IsDisplayed bool `json:"is_displayed"`
	}
	if err := c.BodyParser(&body); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid request body"})
	}
	if err := h.Repo.UpdateTestimonialDisplay(id, body.IsDisplayed); err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to update testimonial"})
	}
	return c.JSON(fiber.Map{"message": "Testimonial updated successfully"})
}

// GET /api/admin/account_feedbacks
func (h *Handler) GetAllAccountFeedbacks(c *fiber.Ctx) error {
	list, err := h.Repo.GetAllAccountFeedbacks()
	if err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to fetch account feedbacks"})
	}
	if list == nil {
		list = []models.AccountFeedback{}
	}
	return c.JSON(list)
}

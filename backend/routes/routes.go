package routes

import (
	"pbl-vimind/backend/internal/controllers"

	"github.com/gofiber/fiber/v2"
)

func RegisterRoutes(app *fiber.App, handler *controllers.Handler) {
	api := app.Group("/api")

	// ===================== PUBLIC =====================
	api.Get("/questions", handler.GetQuestions)
	api.Post("/diagnose", handler.Diagnose)
	api.Get("/profile", handler.GetProfile)
	api.Post("/profile", handler.UpdateProfile)
	api.Delete("/profile", handler.DeleteAccount)
	api.Get("/history", handler.GetHistory)
	api.Get("/news", handler.GetDynamicNews)
	api.Post("/chat", handler.Chatbot)

	// Public FAQ (untuk Home page)
	api.Get("/faq", handler.GetFAQ)

	// Public Banners (untuk Dashboard carousel)
	api.Get("/banners", handler.GetPublicBanners)

	// Feedback & Testimonials (Public)
	api.Get("/testimonials", handler.GetPublicTestimonials)
	api.Post("/testimonials", handler.SubmitTestimonial)
	api.Post("/account_feedbacks", handler.SubmitAccountFeedback)

	// ===================== ADMIN =====================
	admin := api.Group("/admin")

	// Banners
	admin.Get("/banners", handler.GetBanners)
	admin.Post("/banners", handler.UpsertBanner)

	// FAQ
	admin.Get("/faq", handler.GetFAQ)
	admin.Post("/faq", handler.UpsertFAQ)

	// Knowledge Base
	admin.Get("/symptoms", handler.GetAdminSymptoms)
	admin.Put("/symptoms", handler.UpdateAdminSymptom)

	admin.Get("/diseases", handler.GetAdminDiseases)
	admin.Put("/diseases", handler.UpdateAdminDisease)

	admin.Get("/rules", handler.GetAdminRules)
	admin.Put("/rules", handler.UpdateAdminRule)

	// Feedbacks & Testimonials (Admin)
	admin.Get("/testimonials", handler.GetAllTestimonials)
	admin.Put("/testimonials/:id/display", handler.UpdateTestimonialDisplay)
	admin.Get("/account_feedbacks", handler.GetAllAccountFeedbacks)
}

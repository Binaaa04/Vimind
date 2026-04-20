import axios from "axios";

const api = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || "http://localhost:8080",
});

export const getQuestions = (mode = "default", diseaseIDs = [], email = "") => {
  let url = `/api/questions?mode=${mode}`;
  if (diseaseIDs.length > 0) {
    url += `&disease_ids=${diseaseIDs.join(",")}`;
  }
  if (email) {
    url += `&email=${encodeURIComponent(email)}`;
  }
  return api.get(url);
};

export const diagnose = (answers, userEmail = "", refinedDiseaseID = 0) => api.post("/api/diagnose", { answers, user_email: userEmail, refined_disease_id: refinedDiseaseID });
export const getHistory = (email) => api.get(`/api/history?email=${email}`);
export const getProfile = (email) => api.get(`/api/profile?email=${email}`);
export const updateProfile = (email, name, avatarUrl = "") => api.post("/api/profile", { email, name, avatar_url: avatarUrl });
export const deleteAccount = (email) => api.delete(`/api/profile?email=${email}`);
export const sendChatMessage = (email, messages) => api.post("/api/chat", { email, messages });

// Public
export const getPublicFAQ = () => api.get("/api/faq");
export const getPublicBanners = () => api.get("/api/banners");

// Admin - Banners
export const adminGetBanners = () => api.get("/api/admin/banners");
export const adminUpsertBanner = (data) => api.post("/api/admin/banners", data);

// Admin - FAQ
export const adminGetFAQ = () => api.get("/api/admin/faq");
export const adminUpsertFAQ = (data) => api.post("/api/admin/faq", data);

// Admin - Knowledge Base
export const adminGetSymptoms = () => api.get("/api/admin/symptoms");
export const adminUpdateSymptom = (data) => api.put("/api/admin/symptoms", data);
export const adminGetDiseases = () => api.get("/api/admin/diseases");
export const adminUpdateDisease = (data) => api.put("/api/admin/diseases", data);
export const adminGetRules = () => api.get("/api/admin/rules");
export const adminUpdateRule = (data) => api.put("/api/admin/rules", data);

// Feedback (Public)
export const getPublicTestimonials = () => api.get("/api/testimonials");
export const submitTestimonial = (data) => api.post("/api/testimonials", data);
export const submitAccountFeedback = (data) => api.post("/api/account_feedbacks", data);

// Feedback (Admin)
export const adminGetTestimonials = () => api.get("/api/admin/testimonials");
export const adminUpdateTestimonialDisplay = (id, isDisplayed) => api.put(`/api/admin/testimonials/${id}/display`, { is_displayed: isDisplayed });
export const adminGetAccountFeedbacks = () => api.get("/api/admin/account_feedbacks");

export default api;
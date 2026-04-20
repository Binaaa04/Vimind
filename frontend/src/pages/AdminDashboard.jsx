import { useState, useEffect } from "react";
import { Routes, Route } from "react-router-dom";
import AdminSidebar from "../components/AdminSidebar";
import AdminFAQ from "./AdminFAQ";
import AdminTest from "./AdminTest";
import AdminFeedback from "./AdminFeedback";
import { adminGetBanners, adminUpsertBanner } from "../services/api";
import "../css/AdminDashboard.css";

const BannerCard = ({ bannerData, index }) => {
  const [linkUrl, setLinkUrl] = useState(bannerData?.link_url || "");
  const [imageUrl, setImageUrl] = useState(bannerData?.image_url || "");
  const [title, setTitle] = useState(bannerData?.title || "");
  const [isActive, setIsActive] = useState(bannerData?.is_active || false);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  const bannerPayload = () => ({
    id: bannerData?.id || 0,
    title,
    image_url: imageUrl,
    link_url: linkUrl,
    is_active: isActive,
    display_order: bannerData?.display_order || index + 1,
  });

  const handleSubmit = async () => {
    setSaving(true);
    try {
      await adminUpsertBanner(bannerPayload());
      setSaved(true);
      setTimeout(() => setSaved(false), 2000);
    } catch (err) {
      alert("Gagal menyimpan banner.");
    } finally {
      setSaving(false);
    }
  };

  const handleToggle = async (newState) => {
    setIsActive(newState);
    try {
      await adminUpsertBanner({ ...bannerPayload(), is_active: newState });
    } catch (_) {}
  };

  return (
    <div className="banner-card">
      <h3>Banner {index + 1} {isActive && <span className="status">✔ Aktif</span>}</h3>

      <div className="input-row" style={{ flexWrap: "wrap", gap: 8 }}>
        <input
          type="text"
          placeholder="Judul Banner"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          style={{ flex: "1 1 150px" }}
        />
        <input
          type="text"
          placeholder="Link URL (https://...)"
          value={linkUrl}
          onChange={(e) => setLinkUrl(e.target.value)}
          style={{ flex: "2 1 250px" }}
        />
        <input
          type="text"
          placeholder="Image URL (opsional)"
          value={imageUrl}
          onChange={(e) => setImageUrl(e.target.value)}
          style={{ flex: "2 1 250px" }}
        />
        <button className="submit-btn" onClick={handleSubmit} disabled={saving}>
          {saving ? "Menyimpan..." : saved ? "✔ Tersimpan" : "Submit"}
        </button>
      </div>

      <div className="preview-box">
        {linkUrl ? (
          <a href={linkUrl} target="_blank" rel="noreferrer" style={{ color: "#333", fontSize: 13 }}>
            🔗 {linkUrl}
          </a>
        ) : (
          <span>Preview (masukkan link dulu)</span>
        )}

        <div className="action-btns">
          <button className="deactive" onClick={() => handleToggle(false)}>
            Deactivate
          </button>
          <button className="active-btn" onClick={() => handleToggle(true)}>
            Activate
          </button>
        </div>
      </div>
    </div>
  );
};

const AdminDashboard = () => {
  const [banners, setBanners] = useState([]);
  const [loadingBanners, setLoadingBanners] = useState(true);

  useEffect(() => {
    adminGetBanners()
      .then((res) => setBanners(res.data || []))
      .catch(() => {})
      .finally(() => setLoadingBanners(false));
  }, []);

  // Tampilkan minimal 3 slot banner (isi dari DB kalau ada, kosong kalau belum)
  const bannerSlots = Array.from({ length: Math.max(3, banners.length) }, (_, i) => banners[i] || null);

  return (
    <div className="admin-container">
      <AdminSidebar />

      <div className="admin-content">
        <Routes>
          {/* PROMOSI */}
          <Route
            path="/"
            element={
              <>
                <h1>Promosi Dashboard</h1>
                {loadingBanners ? (
                  <p style={{ color: "#aaa" }}>Memuat data banner...</p>
                ) : (
                  bannerSlots.map((b, i) => (
                    <BannerCard key={i} bannerData={b} index={i} />
                  ))
                )}
              </>
            }
          />

          {/* FAQ */}
          <Route path="faq" element={<AdminFAQ />} />

          {/* TEST */}
          <Route path="test" element={<AdminTest />} />

          {/* FEEDBACK */}
          <Route path="feedback" element={<AdminFeedback />} />
        </Routes>
      </div>
    </div>
  );
};

export default AdminDashboard;
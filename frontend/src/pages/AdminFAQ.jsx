import { useState, useEffect } from "react";
import { adminGetFAQ, adminUpsertFAQ } from "../services/api";
import "../css/AdminDashboard.css";

const AdminFAQ = ({ adminEmail }) => {
  const [faq, setFaq] = useState(
    Array.from({ length: 8 }, () => ({
      id: 0,
      question: "",
      answer: "",
    }))
  );
  const [loading, setLoading] = useState(true);
  const [savingIndex, setSavingIndex] = useState(null);

  // Load existing FAQ dari API
  useEffect(() => {
    if (adminEmail) {
      adminGetFAQ(adminEmail)
        .then((res) => {
          const data = res.data || [];
          // Isi faq state dari data DB, sisanya tetap kosong
          setFaq((prev) =>
            prev.map((item, i) => {
              const found = data[i]; // urut by faq_id
              return found ? { id: found.id, question: found.question, answer: found.answer } : item;
            })
          );
        })
        .catch(() => {})
        .finally(() => setLoading(false));
    }
  }, [adminEmail]);

  const handleChange = (index, field, value) => {
    const updated = [...faq];
    updated[index][field] = value;
    setFaq(updated);
  };

  const handleSubmit = async (index) => {
    if (!adminEmail) return;
    const item = faq[index];
    if (!item.question.trim() || !item.answer.trim()) {
      alert("Pertanyaan dan jawaban wajib diisi!");
      return;
    }
    setSavingIndex(index);
    try {
      await adminUpsertFAQ(adminEmail, {
        id: item.id,
        question: item.question,
        answer: item.answer,
      });
      alert(`✔ Pertanyaan ${index + 1} berhasil disimpan!`);
    } catch (err) {
      alert("Gagal menyimpan FAQ. Coba lagi.");
    } finally {
      setSavingIndex(null);
    }
  };

  if (loading) return <p style={{ color: "#aaa", padding: 20 }}>Memuat data FAQ...</p>;

  return (
    <>
      <h1>Custom FAQ</h1>

      {faq.map((item, index) => (
        <div key={index} className="faq-card">
          <h3>Pertanyaan {index + 1}</h3>

          <div className="faq-input-group">
            <input
              type="text"
              placeholder="Masukkan Pertanyaan"
              value={item.question}
              onChange={(e) => handleChange(index, "question", e.target.value)}
            />

            <input
              type="text"
              placeholder="Masukkan Jawaban"
              value={item.answer}
              onChange={(e) => handleChange(index, "answer", e.target.value)}
            />

            <button
              onClick={() => handleSubmit(index)}
              disabled={savingIndex === index}
            >
              {savingIndex === index ? "Menyimpan..." : "Submit"}
            </button>
          </div>
        </div>
      ))}
    </>
  );
};

export default AdminFAQ;
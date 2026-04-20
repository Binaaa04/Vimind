import { useState, useEffect } from "react";
import {
  adminGetRules, adminUpdateRule,
  adminGetSymptoms, adminUpdateSymptom,
  adminGetDiseases, adminUpdateDisease,
} from "../services/api";
import "../css/AdminDashboard.css";

const AdminTest = ({ adminEmail }) => {
  const [rules, setRules] = useState([]);
  const [symptoms, setSymptoms] = useState([]);
  const [diseases, setDiseases] = useState([]);
  const [loading, setLoading] = useState(true);
  const [savingRules, setSavingRules] = useState(false);
  const [savingSymptoms, setSavingSymptoms] = useState(false);
  const [savingDiseases, setSavingDiseases] = useState(false);

  useEffect(() => {
    if (adminEmail) {
      Promise.all([
        adminGetRules(adminEmail).then((r) => setRules(r.data || [])),
        adminGetSymptoms(adminEmail).then((r) => setSymptoms(r.data || [])),
        adminGetDiseases(adminEmail).then((r) => setDiseases(r.data || [])),
      ])
        .catch(() => {})
        .finally(() => setLoading(false));
    }
  }, [adminEmail]);

  // ---- SAVE RULES ----
  const handleSaveRules = async () => {
    if (!adminEmail) return;
    setSavingRules(true);
    try {
      await Promise.all(rules.map((r) => adminUpdateRule(adminEmail, r)));
      alert("✔ Tabel CF berhasil disimpan!");
    } catch {
      alert("Gagal menyimpan rules.");
    } finally {
      setSavingRules(false);
    }
  };

  // ---- SAVE SYMPTOMS ----
  const handleSaveSymptoms = async () => {
    if (!adminEmail) return;
    setSavingSymptoms(true);
    try {
      await Promise.all(symptoms.map((s) => adminUpdateSymptom(adminEmail, s)));
      alert("✔ Tabel Gejala berhasil disimpan!");
    } catch {
      alert("Gagal menyimpan symptoms.");
    } finally {
      setSavingSymptoms(false);
    }
  };

  // ---- SAVE DISEASES ----
  const handleSaveDiseases = async () => {
    if (!adminEmail) return;
    setSavingDiseases(true);
    try {
      await Promise.all(diseases.map((d) => adminUpdateDisease(adminEmail, d)));
      alert("✔ Tabel Disease berhasil disimpan!");
    } catch {
      alert("Gagal menyimpan diseases.");
    } finally {
      setSavingDiseases(false);
    }
  };

  if (loading) return <p style={{ color: "#aaa", padding: 20 }}>Memuat data knowledge base...</p>;

  return (
    <>
      <h1>Knowledge Base Management</h1>

      {/* ================= RULE TABLE ================= */}
      <h3>Tabel CF</h3>
      <div className="table-box">
        <table>
          <thead>
            <tr>
              <th>Rule ID</th>
              <th>Disease ID</th>
              <th>Symptom ID</th>
              <th>CF Value (0–1)</th>
            </tr>
          </thead>
          <tbody>
            {rules.map((item, index) => (
              <tr key={item.rule_id}>
                <td>{item.rule_id}</td>
                <td>{item.disease_id}</td>
                <td>{item.symptom_id}</td>
                <td>
                  <input
                    type="number"
                    value={item.cf_value}
                    step="0.05"
                    min="0"
                    max="1"
                    onChange={(e) => {
                      const updated = [...rules];
                      updated[index] = { ...updated[index], cf_value: parseFloat(e.target.value) || 0 };
                      setRules(updated);
                    }}
                  />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        <button className="submit-btn" onClick={handleSaveRules} disabled={savingRules}>
          {savingRules ? "Menyimpan..." : "Submit"}
        </button>
      </div>

      {/* ================= SYMPTOMS ================= */}
      <h3>Tabel Gejala</h3>
      <div className="table-box">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Kode</th>
              <th>Nama Gejala</th>
            </tr>
          </thead>
          <tbody>
            {symptoms.map((item, index) => (
              <tr key={item.id}>
                <td>{item.id}</td>
                <td>
                  <input
                    value={item.code}
                    onChange={(e) => {
                      const updated = [...symptoms];
                      updated[index] = { ...updated[index], code: e.target.value };
                      setSymptoms(updated);
                    }}
                  />
                </td>
                <td>
                  <input
                    value={item.name}
                    onChange={(e) => {
                      const updated = [...symptoms];
                      updated[index] = { ...updated[index], name: e.target.value };
                      setSymptoms(updated);
                    }}
                  />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        <button className="submit-btn" onClick={handleSaveSymptoms} disabled={savingSymptoms}>
          {savingSymptoms ? "Menyimpan..." : "Submit"}
        </button>
      </div>

      {/* ================= DISEASE ================= */}
      <h3>Tabel Disease</h3>
      <div className="table-box">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nama Penyakit</th>
              <th>Deskripsi</th>
              <th>Solusi</th>
            </tr>
          </thead>
          <tbody>
            {diseases.map((item, index) => (
              <tr key={item.id}>
                <td>{item.id}</td>
                <td>
                  <input
                    value={item.name}
                    onChange={(e) => {
                      const updated = [...diseases];
                      updated[index] = { ...updated[index], name: e.target.value };
                      setDiseases(updated);
                    }}
                  />
                </td>
                <td>
                  <input
                    value={item.description}
                    onChange={(e) => {
                      const updated = [...diseases];
                      updated[index] = { ...updated[index], description: e.target.value };
                      setDiseases(updated);
                    }}
                  />
                </td>
                <td>
                  <input
                    value={item.solutions}
                    onChange={(e) => {
                      const updated = [...diseases];
                      updated[index] = { ...updated[index], solutions: e.target.value };
                      setDiseases(updated);
                    }}
                  />
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        <button className="submit-btn" onClick={handleSaveDiseases} disabled={savingDiseases}>
          {savingDiseases ? "Menyimpan..." : "Submit"}
        </button>
      </div>
    </>
  );
};

export default AdminTest;
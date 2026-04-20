-- ============================================================
-- Migration: Tambah tabel feedback (Testimoni & Account Deletion)
-- Jalankan Query ini di SQL Editor Supabase
-- ============================================================

-- 1. Tabel Testimoni (Selesai Kuesioner)
CREATE TABLE IF NOT EXISTS testimonials (
    testimonial_id SERIAL PRIMARY KEY,
    name           VARCHAR(255) NOT NULL,
    email          VARCHAR(255) NOT NULL,
    rating         INT CHECK (rating BETWEEN 1 AND 5),
    comment        TEXT NOT NULL,
    is_displayed   BOOLEAN DEFAULT true, -- Admin bisa hide testimoni yang jelek/spam
    created_at     TIMESTAMP DEFAULT NOW()
);

-- Seed data awal untuk testimoni agar Landing Page nggak kosong
INSERT INTO testimonials (name, email, rating, comment, is_displayed)
VALUES
    ('Andi Wijaya', 'andi@example.com', 5, 'Vimind membantu saya lebih sadar dengan kondisi perasaan saya setiap hari...', true),
    ('Siti Nurhaliza', 'siti@example.com', 4, 'Sangat mudah dipahami dan hasilnya cukup akurat untuk introspeksi diri.', true),
    ('Budi Santoso', 'budi@example.com', 5, 'Desain UI-nya sangat nyaman dilihat dan fiturnya mudah digunakan.', true),
    ('Rina Kartika', 'rina@example.com', 4, 'Aplikasi yang bagus untuk mulai peduli pada mental health kita sehari-hari.', true)
ON CONFLICT DO NOTHING;

-- 2. Tabel Account Deletion Feedback (Alasan Hapus Akun)
CREATE TABLE IF NOT EXISTS account_feedbacks (
    feedback_id    SERIAL PRIMARY KEY,
    email          VARCHAR(255), -- Tetap disimpan meski auth user-nya udh dihapus, sbg rekapan
    reason         TEXT NOT NULL,
    created_at     TIMESTAMP DEFAULT NOW()
);

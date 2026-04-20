-- ============================================================
-- Migration: Tambah tabel banners dan faq untuk admin panel
-- Jalankan di database PostgreSQL kamu
-- ============================================================

-- TABEL BANNERS (3 slot promo di dashboard)
CREATE TABLE IF NOT EXISTS banners (
    id          SERIAL PRIMARY KEY,
    position    INT UNIQUE NOT NULL CHECK (position BETWEEN 1 AND 3),
    title       TEXT DEFAULT '',
    link        TEXT DEFAULT '',
    is_active   BOOLEAN DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Seed 3 slot (kosong, bisa diisi dari admin panel)
INSERT INTO banners (position, title, link, is_active)
VALUES
    (1, '', '', false),
    (2, '', '', false),
    (3, '', '', false)
ON CONFLICT (position) DO NOTHING;

-- TABEL FAQ (8 slot FAQ dinamis)
CREATE TABLE IF NOT EXISTS faq (
    id          SERIAL PRIMARY KEY,
    position    INT UNIQUE NOT NULL,
    question    TEXT NOT NULL DEFAULT '',
    answer      TEXT NOT NULL DEFAULT '',
    created_at  TIMESTAMP DEFAULT NOW(),
    updated_at  TIMESTAMP DEFAULT NOW()
);

-- Seed 8 posisi FAQ yang bisa di-edit dari admin panel
INSERT INTO faq (position, question, answer)
VALUES
    (1, 'Apa itu Vimind?',                     'Vimind adalah aplikasi yang membantu kamu memahami kondisi kesehatan mental melalui tes psikologi sederhana, daily mood check, serta rangkuman statistik yang menunjukkan perkembangan kondisi emosimu dari waktu ke waktu.'),
    (2, 'Bagaimana cara menggunakan Vimind?',  'Kamu hanya perlu menjawab beberapa pertanyaan pada tes yang tersedia di Vimind. Setelah selesai, kamu akan mendapatkan gambaran kondisi mentalmu beserta insight yang dapat membantu kamu lebih memahami perasaanmu.'),
    (3, 'Apakah hasil tes di Vimind akurat?',  'Tes di Vimind dirancang sebagai alat refleksi diri untuk membantu kamu memahami kondisi emosionalmu. Hasilnya bukan diagnosis medis, namun dapat menjadi gambaran awal sebelum berkonsultasi dengan profesional.'),
    (4, 'Apa itu Daily Mood Test?',             'Daily Mood Test adalah fitur untuk mencatat perasaanmu setiap hari agar kamu bisa memantau pola emosimu.'),
    (5, 'Apakah data saya aman di Vimind?',    'Ya, privasi dan keamanan data pengguna adalah prioritas utama kami.'),
    (6, 'Apakah ada biaya berlangganan?',       'Saat ini fitur dasar Vimind dapat digunakan secara gratis.'),
    (7, 'Apakah saya harus login?',             'Ya, login diperlukan agar kami bisa menyimpan riwayat perkembangan kondisimu dengan aman.'),
    (8, 'Apakah Vimind tersedia di Android dan iOS?', 'Saat ini Vimind dapat diakses melalui web browser di berbagai perangkat.')
ON CONFLICT (position) DO NOTHING;

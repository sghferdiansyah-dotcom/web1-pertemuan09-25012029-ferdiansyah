-- =========================================================
-- PRAKTIKUM PEMROGRAMAN WEB I - PERTEMUAN 9
-- Basis Data Relasional dan SQL CRUD
-- Nama  : [Ferdiansyah saragih]
-- NIM   : [25012029]
-- Kelas : [25mi1]
-- Tanggal: [29]
-- =========================================================

-- ---------------------------------------------------------
-- 1. PERSIAPAN DATABASE
-- ---------------------------------------------------------
CREATE DATABASE IF NOT EXISTS web1_pertemuan09
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE web1_pertemuan09;

-- ---------------------------------------------------------
-- 2. DDL: MEMBUAT TABEL
-- ---------------------------------------------------------
CREATE TABLE kategori (
  id_kategori   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nama_kategori VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE produk (
  id_produk   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_kategori INT UNSIGNED NOT NULL,
  nama_produk VARCHAR(120) NOT NULL,
  harga       DECIMAL(12,2) NOT NULL,
  stok        INT UNSIGNED NOT NULL DEFAULT 0,
  CONSTRAINT fk_produk_kategori
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

SHOW TABLES;
DESCRIBE kategori;
DESCRIBE produk;

-- ---------------------------------------------------------
-- 3. DATA AWAL
-- ---------------------------------------------------------
INSERT INTO kategori (id_kategori, nama_kategori) VALUES
  (1, 'Alat Tulis'),
  (2, 'Aksesori Komputer'),
  (3, 'Perlengkapan Kelas');

INSERT INTO produk (id_produk, id_kategori, nama_produk, harga, stok) VALUES
  (1, 1, 'Buku Catatan',      12000.00, 20),
  (2, 1, 'Pulpen Gel',         6500.00, 35),
  (3, 2, 'Mouse USB',         85000.00,  8),
  (4, 2, 'Flashdisk 32 GB',   78000.00, 12),
  (5, 3, 'Spidol Papan',      15000.00, 10);

SELECT COUNT(*) AS jumlah_kategori FROM kategori;
SELECT COUNT(*) AS jumlah_produk  FROM produk;

-- ---------------------------------------------------------
-- 4. READ
-- ---------------------------------------------------------
SELECT id_produk, nama_produk, harga, stok FROM produk ORDER BY id_produk;

SELECT nama_produk, stok FROM produk WHERE stok < 15 ORDER BY stok ASC;

SELECT p.id_produk, p.nama_produk, k.nama_kategori, p.harga, p.stok
FROM produk AS p
INNER JOIN kategori AS k ON p.id_kategori = k.id_kategori
ORDER BY k.nama_kategori, p.nama_produk;

SELECT k.nama_kategori, COUNT(p.id_produk) AS jumlah_produk
FROM kategori AS k
LEFT JOIN produk AS p ON p.id_kategori = k.id_kategori
GROUP BY k.id_kategori, k.nama_kategori
ORDER BY k.nama_kategori;

-- ---------------------------------------------------------
-- 5. UPDATE
-- ---------------------------------------------------------
SELECT id_produk, nama_produk, harga, stok FROM produk WHERE id_produk = 2;
UPDATE produk SET harga = 7000.00, stok = 30 WHERE id_produk = 2;
SELECT id_produk, nama_produk, harga, stok FROM produk WHERE id_produk = 2;

-- ---------------------------------------------------------
-- 6. DELETE
-- ---------------------------------------------------------
SELECT id_produk, nama_produk FROM produk WHERE id_produk = 5;
DELETE FROM produk WHERE id_produk = 5;
SELECT id_produk, nama_produk FROM produk WHERE id_produk = 5;
SELECT COUNT(*) AS jumlah_produk FROM produk;

-- ---------------------------------------------------------
-- 8. TUGAS MANDIRI 
-- ---------------------------------------------------------

-- Tugas 1: kategori baru + 2 produk
INSERT INTO kategori (nama_kategori) VALUES ('Kebutuhan Lab');
SELECT id_kategori, nama_kategori FROM kategori WHERE nama_kategori = 'Kebutuhan Lab';

INSERT INTO produk (id_kategori, nama_produk, harga, stok) VALUES
  (4, 'Kabel Jumper',  25000.00, 15),
  (4, 'Multimeter',   150000.00,  5);

SELECT p.id_produk, p.nama_produk, k.nama_kategori, p.harga, p.stok
FROM produk AS p
INNER JOIN kategori AS k ON p.id_kategori = k.id_kategori
WHERE k.nama_kategori = 'Kebutuhan Lab';

-- Tugas 2
SELECT id_produk, nama_produk, harga, stok
FROM produk
WHERE harga BETWEEN 10000 AND 100000
ORDER BY harga DESC;

-- Tugas 3
SELECT k.nama_kategori, COUNT(p.id_produk) AS jumlah_produk
FROM kategori AS k
LEFT JOIN produk AS p ON p.id_kategori = k.id_kategori
GROUP BY k.id_kategori, k.nama_kategori
ORDER BY k.nama_kategori;

-- Tugas 4
SELECT id_produk, nama_produk, stok FROM produk
WHERE nama_produk IN ('Kabel Jumper', 'Multimeter');

UPDATE produk SET stok = 20 WHERE nama_produk = 'Kabel Jumper';

SELECT id_produk, nama_produk, stok FROM produk
WHERE nama_produk IN ('Kabel Jumper', 'Multimeter');

DELETE FROM produk WHERE nama_produk = 'Multimeter';

SELECT id_produk, nama_produk, stok FROM produk
WHERE nama_produk IN ('Kabel Jumper', 'Multimeter');

-- ---------------------------------------------------------
-- 7. UJI INTEGRITAS FK (SENGAJA GAGAL) — PALING BAWAH
-- ---------------------------------------------------------
INSERT INTO produk (id_kategori, nama_produk, harga, stok)
VALUES (99, 'Produk Tanpa Kategori', 10000.00, 1);

DELETE FROM kategori WHERE id_kategori = 1;

SELECT COUNT(*) AS jumlah_kategori FROM kategori;
SELECT COUNT(*) AS jumlah_produk  FROM produk;

-- SELESAI
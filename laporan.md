# Laporan Praktikum Pemrograman Web I
## Pertemuan 9 - Basis Data Relasional dan SQL CRUD

---

## 1. Identitas

| Item | Keterangan |
|---|---|
| Nama | [Ferdiansyah saragih] |
| NIM | [25012029] |
| Kelas | [25MI1] |
| Tanggal Praktik | [29] |
| Mata Kuliah | Pemrograman Web I (MKB401213) |
| Dosen | Rico Imanta Ginting, S.Kom., M.Kom. |

---

## 2. Tujuan

Setelah praktikum ini, mahasiswa mampu:
1. Menentukan entitas, atribut, primary key (PK), dan foreign key (FK) dari sebuah kasus.
2. Membuat tabel `kategori` dan `produk` dengan tipe data dan relasi yang tepat.
3. Menambah, membaca, mengubah, dan menghapus data menggunakan SQL.
4. Menguji integritas relasi dan menjelaskan hasil query dengan bukti.

---

## 3. Hasil Pengujian

| No | Skenario | Query / Perintah | Hasil Aktual | Status |
|---|---|---|---|---|
| 1 | SELECT setelah data awal | `SELECT COUNT(*) FROM kategori; SELECT COUNT(*) FROM produk;` | 3 kategori, 5 produk | Sesuai |
| 2 | JOIN produk-kategori | `SELECT ... FROM produk p INNER JOIN kategori k ...` | 5 baris, kategori tiap produk sesuai | Sesuai |
| 3 | UPDATE id_produk = 2 | `UPDATE produk SET harga=7000, stok=30 WHERE id_produk=2;` | Harga 7000, stok 30; produk lain tetap | Sesuai |
| 4 | DELETE id_produk = 5 | `DELETE FROM produk WHERE id_produk=5;` | Produk menjadi 4 baris | Sesuai |
| 5 | INSERT dengan FK 99 | `INSERT INTO produk (id_kategori,...) VALUES (99,...);` | Gagal: `ERROR 1452 Cannot add or update a child row` | Sesuai |
| 6 | DELETE kategori id 1 | `DELETE FROM kategori WHERE id_kategori=1;` | Gagal: `ERROR 1451 Cannot delete or update a parent row` | Sesuai |

---

## 4. Analisis

### 4.1 Relasi 1:N
Skema `kategori (1) → produk (N)` berarti satu kategori dapat memiliki banyak produk, tetapi setiap produk hanya dimiliki oleh satu kategori. Relasi ini diimplementasikan dengan **foreign key** `produk.id_kategori` yang merujuk `kategori.id_kategori`. Dengan demikian, tidak mungkin ada produk tanpa kategori yang valid.

### 4.2 Hasil JOIN
- **INNER JOIN** menampilkan hanya produk yang memiliki kategori valid — pada data awal menghasilkan 5 baris.
- **LEFT JOIN** dipakai saat menghitung jumlah produk per kategori karena tetap menampilkan kategori yang belum memiliki produk (dengan nilai `COUNT = 0`). Jika memakai INNER JOIN, kategori kosong akan hilang dari hasil.

### 4.3 Dua Kegagalan FK
1. **INSERT dengan `id_kategori = 99`** gagal dengan `ERROR 1452 (Cannot add or update a child row)` karena nilai 99 tidak ada di tabel `kategori`. Ini membuktikan FK mencegah data produk "yatim".
2. **DELETE kategori id 1** gagal dengan `ERROR 1451 (Cannot delete or update a parent row)` karena kategori 1 masih dipakai oleh produk "Buku Catatan" dan "Pulpen Gel". Aturan `ON DELETE RESTRICT` mencegah penghapusan data induk yang masih direferensikan.

---

## 5. Kendala dan Solusi

| No | Kendala | Solusi |
|---|---|---|
| 1 | Error `Table already exists` saat menjalankan ulang | Menggunakan `DROP DATABASE IF EXISTS web1_pertemuan09;` sebelum import ulang, atau menjalankan file `.bat` yang otomatis reset. |
| 2 | Error FK muncul di tengah skrip | Dipahami bahwa error tersebut **memang dirancang** untuk menguji integritas relasi, bukan bug. |
| 3 | Path `source` di CMD error karena backslash | Menggunakan garis miring `/` pada path, atau memakai file `.bat` yang sudah menangani path otomatis. |

---

## 6. Simpulan

Dengan SQL CRUD, kita dapat mengelola data pada basis data relasional secara lengkap: **CREATE** untuk membuat tabel dan menambah data, **READ** untuk menampilkan data (termasuk dengan JOIN antar tabel), **UPDATE** untuk mengubah data tertentu, dan **DELETE** untuk menghapus data. Penggunaan **primary key** menjamin keunikan tiap baris, sedangkan **foreign key** beserta aturan `ON DELETE RESTRICT` menjaga integritas relasi agar tidak terjadi data yatim. Pengujian dengan skenario normal dan pelanggaran FK membuktikan bahwa basis data yang dirancang telah bekerja sesuai aturan relasional.

---

## 7. Lampiran Bukti

(Tempel screenshot di bawah ini)

1. Struktur tabel `kategori` dan `produk`
2. Hasil JOIN produk-kategori
3. Hasil UPDATE sebelum & sesudah
4. Hasil DELETE sebelum & sesudah
5. Pesan error FK (INSERT id_kategori=99)
6. Pesan error FK (DELETE kategori id=1)
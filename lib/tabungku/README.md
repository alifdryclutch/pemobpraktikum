# TabungKu Layout (`tabungku_layout`)
Nama: Muhammad Aliff Al Fitroh

NIM: 20240801067

Proyek: Praktikum Flutter Fundamental - Tata Letak Layout

Aplikasi **TabungKu** adalah proyek latihan tata letak (*layout*) layar Ringkasan Tabungan yang dibangun menggunakan framework **Flutter** dan bahasa pemrograman **Dart**. Proyek ini dikembangkan sebagai bagian dari praktikum Flutter Fundamental untuk mempelajari penyusunan antarmuka pengguna (*User Interface*) menggunakan widget dasar tanpa paket pihak ketiga.

---

## 📱 Fitur & Komponen Utama Layout

Halaman **RingkasanPage** terdiri dari beberapa komponen tata letak utama:
1. **AppBar**: Menampilkan judul halaman "Ringkasan Tabungan".
2. **Kartu Ringkasan (Card)**: Menampilkan nama tabungan, total saldo saat ini, serta target tabungan yang dibungkus dengan kombinasi `Column`, `Row`, dan `Container`.
3. **Baris Kategori (Row)**: Menyediakan tiga tombol/ikon ringkas penanda kategori (Menabung, Tarik, dan Riwayat).
4. **Daftar Transaksi Terakhir**: Menampilkan daftar statis (*hard-coded*) minimal tiga item transaksi menggunakan `ListView.builder` dan `Card`/`ListTile`, lengkap dengan indikator status masuk/keluar dana.

---

## 🛠️ Widget Dasar yang Digunakan

Sesuai dengan ketentuan modul praktikum, proyek ini murni menggunakan widget dasar Flutter:
* `MaterialApp` & `Scaffold`
* `AppBar` & `Text`
* `Card` & `Container`
* `Column` & `Row`
* `ListView.builder` & `ListTile`
* `SingleChildScrollView` (untuk mencegah *overflow* pada layar ponsel portret maupun tablet)
* `Padding` & `SizedBox`

---

## 🚀 Cara Menjalankan Proyek

1. **Pastikan Flutter SDK sudah terpasang** di komputer Anda. Anda dapat memeriksanya melalui terminal:
   ```bash
   flutter doctor

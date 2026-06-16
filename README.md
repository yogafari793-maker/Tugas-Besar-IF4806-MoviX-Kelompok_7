# MoviX: Sistem Reservasi Tiket Bioskop Digital

Aplikasi kami, MoviX, adalah aplikasi sistem reservasi tiket bioskop berbasis web yang dirancang dan dibangun menggunakan bahasa pemrograman Java untuk mentransformasi pengelolaan tiket bioskop konvensional yang terkadang tidak efisien menjadi platform digital yang modern. Proyek ini dikembangkan sebagai Tugas Besar mata kuliah Pemrograman Berorientasi Objek.

## Fitur Utama

### 1. Sistem Autentikasi dan Otorisasi
- Registrasi dan Login akun pengguna.
- Pemisahan hak akses secara spesifik antara Pelanggan biasa dan Administrator.

### 2. Katalog Film Interaktif
- Menampilkan daftar film yang sedang tayang lengkap dengan informasi detail (judul, genre, durasi, rating usia, sinopsis, dan poster).
- Fitur pencarian judul film secara langsung (client-side search).
- Fitur penyaringan (filter) film dinamis berdasarkan Genre dan Rating Usia.

### 3. Pemilihan Jadwal dan Studio
- Pemilihan jadwal tayang spesifik berdasarkan film.
- Mendukung klasifikasi dua tipe studio: Kelas Reguler dan Kelas Premier.

### 4. Pemilihan Kursi Dinamis
- Antarmuka visual interaktif untuk memilih kursi bioskop sesuai tata letak layar dan studio.
- Validasi sistem keamanan pemesanan untuk membedakan kursi yang masih kosong dan kursi yang sudah dipesan.
- Perhitungan total harga tiket berjalan secara otomatis seiring dengan penambahan kursi.

### 5. Sistem Checkout dan Kode Promo
- Halaman ringkasan pemesanan tiket (rincian film, jadwal, studio, dan daftar nomor kursi).
- Sistem penerapan kode promo kompleks yang memanfaatkan konsep Polimorfisme (mendukung tipe Diskon Nominal dan tipe Diskon Persentase).
- Perhitungan tagihan akhir yang transparan meliputi subtotal, potongan diskon, dan kalkulasi biaya layanan aplikasi.

### 6. Panel Administrator
- Manajemen Data Film (Tambah, Ubah, Hapus).
- Manajemen Jadwal Tayang untuk menyesuaikan hari, jam tayang, dan harga tiket harian.
- Riwayat Transaksi untuk mengelola seluruh rekaman pembayaran dari pelanggan.

## Teknologi yang Digunakan

- Backend: Java Servlets dan JavaServer Pages (JSP)
- Database: Relational Database menggunakan MySQL
- Frontend: HTML5, CSS3 murni bergaya modern, dan Vanilla JavaScript
- Arsitektur Berorientasi Objek: Mengimplementasikan berbagai prinsip seperti Inheritance dan Polymorphism secara native pada sistem.

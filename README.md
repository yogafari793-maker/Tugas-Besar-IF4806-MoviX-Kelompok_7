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

## Manual Instalasi Sistem

### Kebutuhan Sistem
Sebelum menjalankan aplikasi, pastikan perangkat telah terpasang:
- Java Development Kit (JDK) 17 atau lebih baru
- Apache Tomcat 10
- MySQL Server 8.0
- NetBeans IDE 17 (opsional, untuk pengembangan)
- Git (opsional)

### Instalasi Database
1. Jalankan MySQL.
2. Buat database baru dengan nama `movix`.
3. Import file `movix_db.sql` ke dalam database tersebut.

### Konfigurasi Database
Buka file `Dbconnection.java` dan samakan seperti berikut:
```java
private static final String HOST     = "localhost";
private static final String PORT     = "3306";
private static final String DATABASE = "movix";
private static final String USER     = "root";
private static final String PASSWORD = "";
```

### Menjalankan Aplikasi
1. Buka proyek MoviX pada NetBeans.
2. Pastikan Apache Tomcat telah terhubung ke NetBeans.
3. Klik **Clean and Build Project**.
4. Klik **Run Project**.
5. Buka tautan URL aplikasi Anda di *browser*: `http://localhost:8080/MoviX/`

### Akun Uji Coba

**Admin:**
- Username: `admin`
- Password: `admin123`

**Pelanggan:**
- Username: `pelanggan`
- Password: `pelanggan123`

## Team Members

| Name | Student ID (NIM) | Feature (PIC) |
|---|---|---|
| Sava Arsya Syandana | 103012400043 | Login & Register |
| Aloysius Axel Adriano | 103012400419 | Katalog Film |
| Daffa Dzaki Taufiqul Hakim | 103012400107 | Pemilihan Kursi |
| Ghifari Nurwafi Yoga | 103012400020 | Kategori Tiket Reguler vs Premiere |
| Muhammad Shaquille Shah Alam Murtopo | 103012400225 | Checkout + Struk Digital |

-- Membuat Database
CREATE DATABASE IF NOT EXISTS movix;
USE movix;

-- 1. Tabel Users
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'pelanggan') NOT NULL DEFAULT 'pelanggan',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabel Film
CREATE TABLE IF NOT EXISTS film (
    id INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    durasi INT NOT NULL COMMENT 'Durasi dalam menit',
    rating_usia ENUM('SU', '13+', '17+', '21+') NOT NULL DEFAULT 'SU',
    sinopsis TEXT
);

-- 3. Tabel Studio
CREATE TABLE IF NOT EXISTS studio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_studio VARCHAR(50) NOT NULL,
    tipe_studio ENUM('Reguler', 'Premiere') NOT NULL DEFAULT 'Reguler',
    kapasitas INT NOT NULL DEFAULT 50
);

-- 4. Tabel Jadwal Tayang
CREATE TABLE IF NOT EXISTS jadwal_tayang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT NOT NULL,
    studio_id INT NOT NULL,
    hari VARCHAR(20) NOT NULL,
    jam_tayang VARCHAR(10) NOT NULL,
    harga DOUBLE NOT NULL,
    FOREIGN KEY (film_id) REFERENCES film(id) ON DELETE CASCADE,
    FOREIGN KEY (studio_id) REFERENCES studio(id) ON DELETE CASCADE
);

-- 5. Tabel Transaksi
CREATE TABLE IF NOT EXISTS transaksi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode_booking VARCHAR(20) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    jadwal_id INT NOT NULL,
    jumlah_kursi INT NOT NULL,
    kursi_dipilih VARCHAR(100) NOT NULL COMMENT 'Contoh: A1, A2',
    total_harga DOUBLE NOT NULL,
    kode_promo VARCHAR(50) DEFAULT NULL,
    waktu_transaksi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (jadwal_id) REFERENCES jadwal_tayang(id) ON DELETE CASCADE
);

-- ==========================================
-- INSERT DUMMY DATA
-- ==========================================

-- Data Users
INSERT INTO users (username, password, role) VALUES 
('admin', 'admin123', 'admin'),
('pelanggan1', 'password123', 'pelanggan');

-- Data Studio
INSERT INTO studio (nama_studio, tipe_studio, kapasitas) VALUES 
('Studio 1', 'Reguler', 60),
('Studio 2', 'Premiere', 40),
('Studio 3', 'Reguler', 60);

-- Data Film
INSERT INTO film (judul, genre, durasi, rating_usia, sinopsis) VALUES 
('Avengers: Endgame', 'Action', 181, '13+', 'Setelah peristiwa menghancurkan di Infinity War, alam semesta hancur. Dengan bantuan sekutu yang tersisa, Avengers berkumpul sekali lagi untuk membalikkan tindakan Thanos dan memulihkan keseimbangan alam semesta.'),
('The Conjuring 3', 'Horror', 112, '17+', 'Kisah mengerikan tentang teror, pembunuhan, dan kejahatan tak dikenal yang mengejutkan penyelidik paranormal berpengalaman di kehidupan nyata Ed dan Lorraine Warren.'),
('Dua Garis Biru', 'Drama', 113, '13+', 'Bima dan Dara adalah sepasang kekasih yang masih duduk di bangku SMA. Kehidupan mereka berubah drastis ketika mereka melanggar batas tanpa mengetahui konsekuensinya.'),
('Inception', 'Action', 148, '13+', 'Seorang pencuri yang mencuri rahasia perusahaan melalui penggunaan teknologi berbagi mimpi, diberi tugas sebaliknya: menanamkan sebuah ide ke dalam pikiran seorang CEO.'),
('Parasite', 'Drama', 132, '17+', 'Keserakahan dan diskriminasi kelas mengancam hubungan simbiosis yang baru terbentuk antara keluarga Park yang kaya dan klan Kim yang miskin.'),
('Interstellar', 'Action', 169, '13+', 'Sebuah tim penjelajah melakukan perjalanan melalui lubang cacing di luar angkasa dalam upaya untuk memastikan kelangsungan hidup umat manusia.'),
('The Dark Knight', 'Action', 152, '13+', 'Ketika ancaman yang dikenal sebagai Joker mendatangkan malapetaka pada penduduk Gotham, Batman harus menghadapi tes psikologis terbesarnya.'),
('Spider-Man: No Way Home', 'Action', 148, '13+', 'Dengan identitas Spider-Man terungkap, Peter Parker meminta bantuan Doctor Strange, namun mantranya menjadi sangat salah dan multiverse terbuka.'),
('A Quiet Place', 'Horror', 90, '13+', 'Di dunia pasca-apokaliptik, sebuah keluarga dipaksa untuk hidup dalam keheningan sambil bersembunyi dari monster yang berburu dengan suara.'),
('Joker', 'Drama', 122, '17+', 'Komedian gagal Arthur Fleck mencari koneksi di kota Gotham yang terpecah, membawanya ke jalan kegilaan dan kejahatan.'),
('Pengabdi Setan 2: Communion', 'Horror', 119, '13+', 'Beberapa tahun setelah berhasil selamat, keluarga Rini kembali mendapat teror mematikan di rusun yang mereka tinggali.'),
('Oppenheimer', 'Drama', 180, '13+', 'Kisah fisikawan Amerika J. Robert Oppenheimer, bapak bom atom, dari masa studinya hingga pengembangan senjata pemusnah massal.'),
('Toy Story 4', 'Komedi', 100, 'SU', 'Ketika mainan baru bernama Forky bergabung dengan grup Woody, perjalanan darat bersama teman-teman lama dan baru mengungkap seberapa besar dunia bagi sebuah mainan.'),
('Miracle in Cell No. 7', 'Drama', 145, '13+', 'Seorang ayah dengan keterbelakangan mental dipenjara secara salah atas tuduhan pembunuhan, dan teman-teman selnya berencana menyelundupkan putrinya ke dalam penjara.'),
('Mencuri Raden Saleh', 'Action', 154, '13+', 'Sekelompok pemuda berencana melakukan pencurian terbesar abad ini: mencuri lukisan bernilai tak terhingga karya pahlawan nasional, Raden Saleh.');

-- Data Jadwal Tayang (Sesuai dengan kolom di JadwalDAO: id, film_id, studio_id, hari, jam_tayang, harga)
INSERT INTO jadwal_tayang (film_id, studio_id, hari, jam_tayang, harga) VALUES 
(1, 1, 'Senin', '10:00', 35000),
(1, 1, 'Senin', '13:30', 35000),
(1, 2, 'Senin', '16:00', 75000), -- Premiere
(2, 3, 'Jumat', '19:00', 45000), -- Weekend Reguler
(2, 2, 'Jumat', '21:30', 90000), -- Weekend Premiere
(3, 1, 'Rabu', '11:00', 35000),
(3, 1, 'Rabu', '14:30', 35000),
(4, 2, 'Senin', '19:00', 75000), -- Premiere
(5, 3, 'Selasa', '13:00', 35000),
(6, 1, 'Kamis', '15:00', 35000),
(7, 2, 'Sabtu', '20:00', 90000), -- Weekend Premiere
(8, 3, 'Minggu', '14:00', 45000), -- Weekend Reguler
(9, 1, 'Jumat', '22:00', 45000),
(10, 2, 'Selasa', '21:00', 75000),
(11, 3, 'Kamis', '19:30', 35000),
(12, 1, 'Minggu', '10:00', 45000),
(13, 3, 'Senin', '11:00', 35000),
(14, 2, 'Rabu', '15:30', 75000),
(15, 1, 'Sabtu', '16:00', 45000);

-- Data Transaksi (Opsional, sebagai contoh riwayat pesanan)
INSERT INTO transaksi (kode_booking, user_id, jadwal_id, jumlah_kursi, kursi_dipilih, total_harga, kode_promo) VALUES 
('MVX-00123', 2, 1, 2, 'A4, B5', 70000, NULL);

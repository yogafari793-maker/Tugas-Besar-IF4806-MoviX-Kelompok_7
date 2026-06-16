USE movix;

CREATE TABLE IF NOT EXISTS promo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode_promo VARCHAR(50) NOT NULL UNIQUE,
    tipe_diskon ENUM('nominal', 'persentase') NOT NULL,
    nilai_diskon DOUBLE NOT NULL,
    deskripsi VARCHAR(255)
);

INSERT INTO promo (kode_promo, tipe_diskon, nilai_diskon, deskripsi) VALUES 
('MOVIX50', 'nominal', 50000, 'Diskon Rp 50.000 untuk pengguna baru'),
('WEEKEND10', 'persentase', 10, 'Diskon 10% Spesial Akhir Pekan'),
('MAHASISWA', 'nominal', 15000, 'Potongan Rp 15.000 Khusus Mahasiswa');

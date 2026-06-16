package model;

import java.util.ArrayList;
import java.sql.Timestamp;

public class Transaksi {
    private int id;
    private String kodeBooking;
    private int userId;
    private int jadwalId;
    private int jumlahKursi;
    private String kursiDipilih;
    private double totalHarga;
    private String kodePromo;
    private Timestamp waktuTransaksi;
    
    // Legacy fields
    private Pelanggan pelanggan;
    private ArrayList<Tiket> daftarTiket;
    private Promo promo;
    private String waktuTransaksiStr;

    public Transaksi() {
        this.daftarTiket = new ArrayList<>();
        this.totalHarga = 0.0;
    }

    // Constructor for DB
    public Transaksi(int id, String kodeBooking, int userId, int jadwalId, int jumlahKursi, String kursiDipilih, double totalHarga, String kodePromo, Timestamp waktuTransaksi) {
        this.id = id;
        this.kodeBooking = kodeBooking;
        this.userId = userId;
        this.jadwalId = jadwalId;
        this.jumlahKursi = jumlahKursi;
        this.kursiDipilih = kursiDipilih;
        this.totalHarga = totalHarga;
        this.kodePromo = kodePromo;
        this.waktuTransaksi = waktuTransaksi;
        this.daftarTiket = new ArrayList<>();
    }

    // Legacy Constructor
    public Transaksi(String kodeBooking, Pelanggan pelanggan, String waktuTransaksiStr) {
        this.kodeBooking = kodeBooking;
        this.pelanggan = pelanggan;
        this.waktuTransaksiStr = waktuTransaksiStr;
        this.daftarTiket = new ArrayList<>();
        this.totalHarga = 0.0;
    }

    public void tambahTiket(Tiket tiket) {
        daftarTiket.add(tiket);
    }

    public void terapkanPromo(Promo p) {
        this.promo = p;
    }

    public double hitungTotal() {
        double subtotal = 0.0;
        for (Tiket t : daftarTiket) {
            subtotal += t.hitungHarga();
        }
        if (promo != null) {
            double diskon = promo.hitungDiskon(subtotal);
            subtotal -= diskon;
        }
        this.totalHarga = subtotal;
        return this.totalHarga;
    }

    // Getters and Setters for DB Fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getKodeBooking() { return kodeBooking; }
    public void setKodeBooking(String kodeBooking) { this.kodeBooking = kodeBooking; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getJadwalId() { return jadwalId; }
    public void setJadwalId(int jadwalId) { this.jadwalId = jadwalId; }

    public int getJumlahKursi() { return jumlahKursi; }
    public void setJumlahKursi(int jumlahKursi) { this.jumlahKursi = jumlahKursi; }

    public String getKursiDipilih() { return kursiDipilih; }
    public void setKursiDipilih(String kursiDipilih) { this.kursiDipilih = kursiDipilih; }

    public double getTotalHarga() { return totalHarga; }
    public void setTotalHarga(double totalHarga) { this.totalHarga = totalHarga; }

    public String getKodePromo() { return kodePromo; }
    public void setKodePromo(String kodePromo) { this.kodePromo = kodePromo; }

    public Timestamp getWaktuTransaksi() { return waktuTransaksi; }
    public void setWaktuTransaksi(Timestamp waktuTransaksi) { this.waktuTransaksi = waktuTransaksi; }

    // Display fields for Admin
    private String namaUser;
    private String judulFilm;
    private String hari;
    private String jamTayang;
    private String namaStudio;

    public String getNamaUser() { return namaUser; }
    public void setNamaUser(String namaUser) { this.namaUser = namaUser; }

    public String getJudulFilm() { return judulFilm; }
    public void setJudulFilm(String judulFilm) { this.judulFilm = judulFilm; }

    public String getHari() { return hari; }
    public void setHari(String hari) { this.hari = hari; }

    public String getJamTayang() { return jamTayang; }
    public void setJamTayang(String jamTayang) { this.jamTayang = jamTayang; }

    public String getNamaStudio() { return namaStudio; }
    public void setNamaStudio(String namaStudio) { this.namaStudio = namaStudio; }
}

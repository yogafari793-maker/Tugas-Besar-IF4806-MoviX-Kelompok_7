/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author UPLAND
 */
import java.util.ArrayList;

public class Transaksi {
    private String kodeBooking;
    private Pelanggan pelanggan;
    private ArrayList<Tiket> daftarTiket;
    private Promo promo;
    private double totalHarga;
    private String waktuTransaksi;

    public Transaksi(String kodeBooking, Pelanggan pelanggan, String waktuTransaksi) {
        this.kodeBooking = kodeBooking;
        this.pelanggan = pelanggan;
        this.waktuTransaksi = waktuTransaksi;
        this.daftarTiket = new ArrayList<>();
        this.totalHarga = 0.0;
    }

    public void tambahTiket(Tiket tiket) {
        daftarTiket.add(tiket);
    }

    // Menerima objek Promo langsung
    public void terapkanPromo(Promo p) {
        this.promo = p;
    }

    public double hitungTotal() {
        double subtotal = 0.0;
        
        // Menjumlahkan harga semua tiket
        for (Tiket t : daftarTiket) {
            subtotal += t.hitungHarga();
        }

        // Mengurangi dengan diskon jika ada promo
        if (promo != null) {
            double diskon = promo.hitungDiskon(subtotal);
            subtotal -= diskon;
        }
        
        this.totalHarga = subtotal;
        return this.totalHarga;
    }

    public String getKodeBooking() {
        return kodeBooking;
    }

    public void cetakStruk() {
        System.out.println("\n========== STRUK TRANSAKSI ==========");
        System.out.println("Kode Booking : " + kodeBooking);
        System.out.println("Pelanggan    : " + pelanggan.getNama());
        System.out.println("Waktu        : " + waktuTransaksi);
        System.out.println("-------------------------------------");
        for (Tiket t : daftarTiket) {
            System.out.println("- Tiket " + t.getIdTiket() + " | Harga: Rp" + t.hitungHarga());
        }
        System.out.println("-------------------------------------");
        
        if (promo != null) {
            System.out.println(promo.getDeskripsiPromo());
        }
        
        System.out.println("TOTAL BAYAR  : Rp" + hitungTotal());
        System.out.println("=====================================\n");
    }
}


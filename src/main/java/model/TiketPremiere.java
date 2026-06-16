/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAFFA
 */
public class TiketPremiere extends Tiket {
    private final double HARGA_WEEKDAY = 60000.0;
    private final double HARGA_WEEKEND = 75000.0;

    public TiketPremiere(String idTiket, int baris, int kolom, JadwalTayang jadwal) {
        super(idTiket, baris, kolom, jadwal);
    }

    @Override
    public double hitungHarga() {
        // Menggunakan harga dasar dari Jadwal Tayang Database
        return super.getJadwal().getHarga();
    }
}

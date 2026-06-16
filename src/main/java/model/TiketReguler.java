/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAFFA
 */
public class TiketReguler extends Tiket {
    private final double HARGA_WEEKDAY = 35000.0;
    private final double HARGA_WEEKEND = 45000.0;

    // Constructor
    public TiketReguler(String idTiket, int baris, int kolom, JadwalTayang jadwal) {
        super(idTiket, baris, kolom, jadwal);
    }

    @Override
    public double hitungHarga() {
        // Asumsi kelas JadwalTayang memiliki method getHari()
        String hari = super.getJadwal().getHari().toLowerCase();
        
        // Cek jika hari adalah Sabtu atau Minggu (Weekend)
        if (hari.equals("sabtu") || hari.equals("minggu")) {
            return HARGA_WEEKEND;
        } else {
            return HARGA_WEEKDAY;
        }
    }
}

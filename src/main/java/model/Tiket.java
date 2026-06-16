/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAFFA
 */
public abstract class Tiket {
    private String idTiket;
    private int baris;
    private int kolom;
    private JadwalTayang jadwal;

    // Constructor
    public Tiket(String idTiket, int baris, int kolom, JadwalTayang jadwal) {
        this.idTiket = idTiket;
        this.baris = baris;
        this.kolom = kolom;
        this.jadwal = jadwal;
    }

    // Getters
    public String getIdTiket() {
        return idTiket;
    }

    public int getBaris() {
        return baris;
    }

    public int getKolom() {
        return kolom;
    }

    public JadwalTayang getJadwal() {
        return jadwal;
    }


    public abstract double hitungHarga();

    @Override
    public String toString() {
        return "Tiket [ID=" + idTiket + ", Baris=" + baris + ", Kolom=" + kolom + "]";
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ghifa
 */
import java.util.ArrayList;
public class JadwalTayang {

    // =========================================================
    // ATRIBUT
    // =========================================================
    private int    id;
    private int    filmId;
    private String namaFilm;
    private int    studioId;
    private String namaStudio;
    private String tipeStudio;
    private String hari;
    private String jamTayang;
    private double harga;
    private ArrayList<JadwalTayang> daftarJadwal;

    // =========================================================
    // CONSTRUCTOR KOSONG
    // =========================================================
    public JadwalTayang() {}

    // =========================================================
    // CONSTRUCTOR LENGKAP
    // =========================================================
    public JadwalTayang(int id, int filmId, String namaFilm,
                        int studioId, String namaStudio, String tipeStudio,
                        String hari, String jamTayang, double harga) {
        this.id         = id;
        this.filmId     = filmId;
        this.namaFilm   = namaFilm;
        this.studioId   = studioId;
        this.namaStudio = namaStudio;
        this.tipeStudio = tipeStudio;
        this.hari       = hari;
        this.jamTayang  = jamTayang;
        this.harga      = harga;
    }

    // =========================================================
    // GETTER & SETTER
    // =========================================================
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getFilmId() { return filmId; }
    public void setFilmId(int filmId) { this.filmId = filmId; }

    public String getNamaFilm() { return namaFilm; }
    public void setNamaFilm(String namaFilm) { this.namaFilm = namaFilm; }

    public int getStudioId() { return studioId; }
    public void setStudioId(int studioId) { this.studioId = studioId; }

    public String getNamaStudio() { return namaStudio; }
    public void setNamaStudio(String namaStudio) { this.namaStudio = namaStudio; }

    public String getTipeStudio() { return tipeStudio; }
    public void setTipeStudio(String tipeStudio) { this.tipeStudio = tipeStudio; }

    public String getHari() { return hari; }
    public void setHari(String hari) { this.hari = hari; }

    public String getJamTayang() { return jamTayang; }
    public void setJamTayang(String jamTayang) { this.jamTayang = jamTayang; }

    public double getHarga() { return harga; }
    public void setHarga(double harga) { this.harga = harga; }

    // =========================================================
    // HELPER — format harga ke Rupiah
    // =========================================================
    public String getHargaFormatted() {
        long h = (long) harga;
        String s = Long.toString(h);
        StringBuilder sb = new StringBuilder();
        int count = 0;
        for (int i = s.length() - 1; i >= 0; i--) {
            if (count > 0 && count % 3 == 0) sb.insert(0, '.');
            sb.insert(0, s.charAt(i));
            count++;
        }
        return "Rp " + sb.toString();
    }

    @Override
    public String toString() {
        return "JadwalTayang{"
                + "id=" + id
                + ", namaFilm='" + namaFilm + '\''
                + ", namaStudio='" + namaStudio + '\''
                + ", tipe='" + tipeStudio + '\''
                + ", hari='" + hari + '\''
                + ", jam='" + jamTayang + '\''
                + ", harga=" + harga
                + '}';
    }
    
    public void tambahJadwal(JadwalTayang j) {
        daftarJadwal.add(j);
    }
}

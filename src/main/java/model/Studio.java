/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAFFA
 */
public class Studio {
    private int noStudio;
    private String tipeStudio;
    private int jumlahBaris;
    private int jumlahKolom;
    private char[][] denahKursi;

    // Constructor
    public Studio(int noStudio, String tipeStudio, int jumlahBaris, int jumlahKolom) {
        this.noStudio = noStudio;
        this.tipeStudio = tipeStudio;
        this.jumlahBaris = jumlahBaris;
        this.jumlahKolom = jumlahKolom;
        this.denahKursi = new char[jumlahBaris][jumlahKolom];
        
        initDenah(); // Menginisialisasi denah saat studio dibuat
    }

    public void initDenah() {
        // Mengisi semua kursi dengan 'O' (Kosong/Tersedia)
        for (int i = 0; i < jumlahBaris; i++) {
            for (int j = 0; j < jumlahKolom; j++) {
                denahKursi[i][j] = 'O'; 
            }
        }
    }

    public void tampilkanDenah() {
        System.out.println("Denah Kursi Studio " + noStudio + " (" + tipeStudio + "):");
        for (int i = 0; i < jumlahBaris; i++) {
            for (int j = 0; j < jumlahKolom; j++) {
                System.out.print(denahKursi[i][j] + " ");
            }
            System.out.println(); // Pindah baris
        }
    }

    public void pesanKursi(int baris, int kolom) {
        if (isTersedia(baris, kolom)) {
            denahKursi[baris][kolom] = 'X'; // Menandai kursi telah dipesan
            System.out.println("Kursi [" + baris + "][" + kolom + "] berhasil dipesan.");
        } else {
            System.out.println("Gagal memesan: Kursi tidak tersedia atau di luar batas.");
        }
    }

    public boolean isTersedia(int baris, int kolom) {
        // Cek apakah baris dan kolom berada dalam batas array
        if (baris >= 0 && baris < jumlahBaris && kolom >= 0 && kolom < jumlahKolom) {
            return denahKursi[baris][kolom] == 'O';
        }
        return false;
    }

    public int getSisaKursi() {
        int sisa = 0;
        for (int i = 0; i < jumlahBaris; i++) {
            for (int j = 0; j < jumlahKolom; j++) {
                if (denahKursi[i][j] == 'O') {
                    sisa++;
                }
            }
        }
        return sisa;
    }

    public String getTipeStudio() {
        return tipeStudio;
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAFFA
 */
public class DiskonNominal implements Promo {
    private String kodePromo;
    private double nominalDiskon;

    public DiskonNominal(String kodePromo, double nominalDiskon) {
        this.kodePromo = kodePromo;
        this.nominalDiskon = nominalDiskon;
    }

    @Override
    public double hitungDiskon(double totalHarga) {
        // Mencegah diskon lebih besar dari total harga
        return Math.min(nominalDiskon, totalHarga);
    }

    @Override
    public String getDeskripsiPromo() {
        return "Potongan harga Rp" + nominalDiskon + " dengan kode: " + kodePromo;
    }
}
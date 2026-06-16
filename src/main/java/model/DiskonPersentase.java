/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author UPLAND
 */
public class DiskonPersentase implements Promo {
    private String kodePromo;
    private double persentaseDiskon; // contoh: 10.0 berarti 10%

    public DiskonPersentase(String kodePromo, double persentaseDiskon) {
        this.kodePromo = kodePromo;
        this.persentaseDiskon = persentaseDiskon;
    }

    @Override
    public double hitungDiskon(double totalHarga) {
        return totalHarga * (persentaseDiskon / 100.0);
    }

    @Override
    public String getDeskripsiPromo() {
        return "Diskon " + persentaseDiskon + "% dengan kode: " + kodePromo;
    }
}
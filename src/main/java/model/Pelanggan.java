/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DAFFA
 */
import java.util.ArrayList;
public class Pelanggan extends Pengguna {
    private ArrayList<Transaksi> riwayatTransaksi;

    public Pelanggan(int id, String username, String password, String nama) {
        super(id, username, password, nama);
        this.riwayatTransaksi = new ArrayList<>();
    }

    @Override
    public String getRole() {
        return "Pelanggan";
    }

    public void tambahRiwayat(Transaksi t) {
        riwayatTransaksi.add(t);
    }

    public ArrayList<Transaksi> getRiwayatTransaksi() {
        return riwayatTransaksi;
    }
}

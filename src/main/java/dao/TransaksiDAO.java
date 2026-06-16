package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Transaksi;
import util.Dbconnection;

public class TransaksiDAO {

    public boolean insertTransaksi(Transaksi transaksi) {
        String query = "INSERT INTO transaksi (kode_booking, user_id, jadwal_id, jumlah_kursi, kursi_dipilih, total_harga, kode_promo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        boolean isSuccess = false;

        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, transaksi.getKodeBooking());
            stmt.setInt(2, transaksi.getUserId());
            stmt.setInt(3, transaksi.getJadwalId());
            stmt.setInt(4, transaksi.getJumlahKursi());
            stmt.setString(5, transaksi.getKursiDipilih());
            stmt.setDouble(6, transaksi.getTotalHarga());
            stmt.setString(7, transaksi.getKodePromo());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    public List<Transaksi> getAllTransaksi() {
        List<Transaksi> list = new ArrayList<>();
        String query = "SELECT t.*, u.nama as nama_user, f.judul as judul_film, j.hari, j.jam_tayang, s.nama_studio " +
                       "FROM transaksi t " +
                       "JOIN users u ON t.user_id = u.id " +
                       "JOIN jadwal_tayang j ON t.jadwal_id = j.id " +
                       "JOIN film f ON j.film_id = f.id " +
                       "JOIN studio s ON j.studio_id = s.id " +
                       "ORDER BY t.waktu_transaksi DESC";

        try (Connection conn = Dbconnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Transaksi t = new Transaksi(
                    rs.getInt("id"),
                    rs.getString("kode_booking"),
                    rs.getInt("user_id"),
                    rs.getInt("jadwal_id"),
                    rs.getInt("jumlah_kursi"),
                    rs.getString("kursi_dipilih"),
                    rs.getDouble("total_harga"),
                    rs.getString("kode_promo"),
                    rs.getTimestamp("waktu_transaksi")
                );
                
                t.setNamaUser(rs.getString("nama_user"));
                t.setJudulFilm(rs.getString("judul_film"));
                t.setHari(rs.getString("hari"));
                t.setJamTayang(rs.getString("jam_tayang"));
                t.setNamaStudio(rs.getString("nama_studio"));
                
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<String> getKursiDipilihByJadwal(int jadwalId) {
        List<String> listKursi = new ArrayList<>();
        String query = "SELECT kursi_dipilih FROM transaksi WHERE jadwal_id = ?";

        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, jadwalId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String kursi = rs.getString("kursi_dipilih");
                if (kursi != null && !kursi.trim().isEmpty()) {
                    String[] split = kursi.split(",");
                    for (String s : split) {
                        listKursi.add(s.trim());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listKursi;
    }
}

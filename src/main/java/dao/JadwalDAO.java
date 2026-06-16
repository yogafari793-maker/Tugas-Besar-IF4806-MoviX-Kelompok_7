/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao; // Pastikan murni 'dao'

import model.JadwalTayang; // Pastikan import ke model baru benar
import util.Dbconnection;   // Pastikan import ke util baru benar

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ghifa
 */

/**
 * JadwalDAO
 * Data Access Object untuk tabel jadwal_tayang.
*/
public class JadwalDAO {

    // =========================================================
    // BASE QUERY
    // =========================================================
    private static final String BASE_SELECT =
        "SELECT jt.id, jt.film_id, f.judul AS nama_film, "
      + "       jt.studio_id, s.nama_studio, s.tipe_studio, "
      + "       jt.hari, jt.jam_tayang, jt.harga "
      + "FROM jadwal_tayang jt "
      + "JOIN film f  ON jt.film_id  = f.id "
      + "JOIN studio s ON jt.studio_id = s.id ";

    // =========================================================
    // GET BY TIPE
    // =========================================================
    public List<JadwalTayang> getByTipe(String tipe) {
        List<JadwalTayang> list = new ArrayList<JadwalTayang>();
        String sql = BASE_SELECT
                   + "WHERE s.tipe_studio = ? "
                   + "ORDER BY jt.hari, jt.jam_tayang";

        // FIX: try-with-resources — koneksi otomatis ditutup
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tipe);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("[JadwalDAO] getByTipe error: " + e.getMessage());
        }

        return list;
    }

    // =========================================================
    // GET BY FILM + TIPE
    // =========================================================
    public List<JadwalTayang> getByFilmDanTipe(int filmId, String tipe) {
        List<JadwalTayang> list = new ArrayList<JadwalTayang>();
        String sql = BASE_SELECT
                   + "WHERE jt.film_id = ? AND s.tipe_studio = ? "
                   + "ORDER BY jt.hari, jt.jam_tayang";

        // FIX: try-with-resources
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, filmId);
            ps.setString(2, tipe);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("[JadwalDAO] getByFilmDanTipe error: " + e.getMessage());
        }

        return list;
    }

    // =========================================================
    // GET BY ID
    // =========================================================
    public JadwalTayang getById(int id) {
        String sql = BASE_SELECT + "WHERE jt.id = ?";

        // FIX: try-with-resources
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("[JadwalDAO] getById error: " + e.getMessage());
        }

        return null;
    }

    // =========================================================
    // PRIVATE HELPER
    // =========================================================
    private JadwalTayang mapRow(ResultSet rs) throws SQLException {
        return new JadwalTayang(
            rs.getInt("id"),
            rs.getInt("film_id"),
            rs.getString("nama_film"),
            rs.getInt("studio_id"),
            rs.getString("nama_studio"),
            rs.getString("tipe_studio"),
            rs.getString("hari"),
            rs.getString("jam_tayang"),
            rs.getDouble("harga")
        );
    }

    public boolean insert(int filmId, int studioId, String hari, String jamTayang, double harga) {
        String sql = "INSERT INTO jadwal_tayang (film_id, studio_id, hari, jam_tayang, harga) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, filmId);
            ps.setInt(2, studioId);
            ps.setString(3, hari);
            ps.setString(4, jamTayang);
            ps.setDouble(5, harga);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[JadwalDAO] insert error: " + e.getMessage());
            return false;
        }
    }

    public boolean update(int id, int filmId, int studioId, String hari, String jamTayang, double harga) {
        String sql = "UPDATE jadwal_tayang SET film_id = ?, studio_id = ?, hari = ?, jam_tayang = ?, harga = ? WHERE id = ?";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, filmId);
            ps.setInt(2, studioId);
            ps.setString(3, hari);
            ps.setString(4, jamTayang);
            ps.setDouble(5, harga);
            ps.setInt(6, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[JadwalDAO] update error: " + e.getMessage());
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM jadwal_tayang WHERE id = ?";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[JadwalDAO] delete error: " + e.getMessage());
            return false;
        }
    }
}

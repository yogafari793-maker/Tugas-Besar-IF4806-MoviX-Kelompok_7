package dao;

import model.Film;
import util.Dbconnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author AXELL
 */
public class FilmDAO {

    public List<Film> getAllFilms() {
        List<Film> list = new ArrayList<>();
        String sql = "SELECT * FROM film ORDER BY id DESC";

        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Film(
                    rs.getInt("id"),
                    rs.getString("judul"),
                    rs.getString("genre"),
                    rs.getInt("durasi"),
                    rs.getString("rating_usia"),
                    rs.getString("sinopsis"),
                    rs.getString("poster_url")
                ));
            }
        } catch (SQLException e) {
            System.err.println("[FilmDAO] getAllFilms error: " + e.getMessage());
        }

        return list;
    }

    public Film getFilmById(int id) {
        String sql = "SELECT * FROM film WHERE id = ?";
        
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Film(
                        rs.getInt("id"),
                        rs.getString("judul"),
                        rs.getString("genre"),
                        rs.getInt("durasi"),
                        rs.getString("rating_usia"),
                        rs.getString("sinopsis"),
                        rs.getString("poster_url")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[FilmDAO] getFilmById error: " + e.getMessage());
        }

        return null;
    }

    public boolean insert(Film film) {
        String sql = "INSERT INTO film (judul, genre, durasi, rating_usia, sinopsis, poster_url) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, film.getJudul());
            ps.setString(2, film.getGenre());
            ps.setInt(3, film.getDurasi());
            ps.setString(4, film.getRatingUsia());
            ps.setString(5, film.getSinopsis());
            ps.setString(6, film.getPosterUrl());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[FilmDAO] insert error: " + e.getMessage());
            return false;
        }
    }

    public boolean update(Film film) {
        String sql = "UPDATE film SET judul=?, genre=?, durasi=?, rating_usia=?, sinopsis=?, poster_url=? WHERE id=?";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, film.getJudul());
            ps.setString(2, film.getGenre());
            ps.setInt(3, film.getDurasi());
            ps.setString(4, film.getRatingUsia());
            ps.setString(5, film.getSinopsis());
            ps.setString(6, film.getPosterUrl());
            ps.setInt(7, film.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[FilmDAO] update error: " + e.getMessage());
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM film WHERE id=?";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[FilmDAO] delete error: " + e.getMessage());
            return false;
        }
    }
}

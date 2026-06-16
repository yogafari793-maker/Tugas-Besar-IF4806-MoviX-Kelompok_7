package dao;

import model.Film;
import util.Dbconnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
                    rs.getString("sinopsis")
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
                        rs.getString("sinopsis")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("[FilmDAO] getFilmById error: " + e.getMessage());
        }

        return null;
    }
}

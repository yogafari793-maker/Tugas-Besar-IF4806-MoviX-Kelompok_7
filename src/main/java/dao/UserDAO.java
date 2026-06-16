package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Admin;
import model.Pelanggan;
import model.Pengguna;
import util.Dbconnection;

/**
 *
 * @author AXELL
 */
public class UserDAO {

    public Pengguna loginUser(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int id = rs.getInt("id");
                String dbUser = rs.getString("username");
                String dbPass = rs.getString("password");
                String nama = rs.getString("nama");
                String role = rs.getString("role");
                
                if (role.equalsIgnoreCase("admin")) {
                    return new Admin(id, dbUser, dbPass, nama);
                } else {
                    return new Pelanggan(id, dbUser, dbPass, nama);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean registerUser(String username, String password, String nama) {
        String query = "INSERT INTO users (username, password, nama, role) VALUES (?, ?, ?, 'pelanggan')";
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, nama);
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

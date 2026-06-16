/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author ghifa
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class Dbconnection {

    // =========================================================
    // KONFIGURASI DATABASE XAMPP LOKAL
    // =========================================================
    private static final String HOST     = "localhost";
    private static final String PORT     = "3306";
    private static final String DATABASE = "db_tes";   // Nama database Anda
    private static final String USER     = "root";     // User default XAMPP
    private static final String PASSWORD = "";         // Password default XAMPP (Kosong)

    private static final String URL =
            "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE
            + "?useSSL=false&serverTimezone=Asia/Jakarta&allowPublicKeyRetrieval=true";

    // =========================================================
    // LOAD DRIVER
    // =========================================================
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("[Dbconnection] Driver MySQL tidak ditemukan: " + e.getMessage());
        }
    }

    // =========================================================
    // GET CONNECTION
    // =========================================================
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Tidak boleh di-instansiasi
    private Dbconnection() {}
}

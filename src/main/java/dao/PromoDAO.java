package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Promo;
import model.DiskonNominal;
import model.DiskonPersentase;
import util.Dbconnection;

public class PromoDAO {
    
    public Promo getPromoByKode(String kodePromo) {
        Promo promo = null;
        String query = "SELECT * FROM promo WHERE kode_promo = ?";
        
        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, kodePromo);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String tipeDiskon = rs.getString("tipe_diskon");
                double nilaiDiskon = rs.getDouble("nilai_diskon");
                
                if ("nominal".equalsIgnoreCase(tipeDiskon)) {
                    promo = new DiskonNominal(kodePromo, nilaiDiskon);
                } else if ("persentase".equalsIgnoreCase(tipeDiskon)) {
                    promo = new DiskonPersentase(kodePromo, nilaiDiskon);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return promo;
    }
}

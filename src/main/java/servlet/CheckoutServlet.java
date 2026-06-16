package servlet;

import dao.PromoDAO;
import dao.TransaksiDAO;
import model.Promo;
import model.Transaksi;
import model.Pengguna;
import model.JadwalTayang;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.UUID;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private String formatRupiah(double amount) {
        NumberFormat formatter = NumberFormat.getInstance(new Locale("id", "ID"));
        return formatter.format(amount);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String aksi = request.getParameter("aksi");
        if ("hapusPromo".equals(aksi)) {
            HttpSession session = request.getSession();
            session.removeAttribute("kodePromo");
            session.removeAttribute("promoDeskripsi");
            session.removeAttribute("diskon");
            session.removeAttribute("diskonFormatted");
            session.setAttribute("successPromo", "Promo telah dihapus.");
            
            hitungTotalAkhir(session);
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String aksi = request.getParameter("aksi");
        HttpSession session = request.getSession();
        
        Pengguna user = (Pengguna) session.getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        JadwalTayang jadwal = (JadwalTayang) session.getAttribute("jadwalDipilih");
        if (jadwal == null && !aksi.equals("review")) {
            response.sendRedirect(request.getContextPath() + "/katalog");
            return;
        }

        if ("review".equals(aksi)) {
            // Data received from pilihKursi.jsp
            String filmTitle = request.getParameter("film");
            String filmDate = request.getParameter("date");
            String filmTime = request.getParameter("time");
            String studioName = request.getParameter("studio");
            String[] selectedSeats = request.getParameterValues("selected");
            
            if (selectedSeats == null || selectedSeats.length == 0) {
                response.sendRedirect(request.getContextPath() + "/kursi?jadwalId=" + (jadwal != null ? jadwal.getId() : ""));
                return;
            }

            session.setAttribute("filmTitle", filmTitle);
            session.setAttribute("filmDate", filmDate);
            session.setAttribute("filmTime", filmTime);
            session.setAttribute("studioName", studioName);
            session.setAttribute("selectedSeats", selectedSeats);
            session.setAttribute("jumlahKursi", selectedSeats.length);
            
            // --- IMPLEMENTASI OOP ---
            Transaksi transaksiOOP = new Transaksi();
            for (String seat : selectedSeats) {
                // Parsing seat misal "A1"
                int baris = seat.charAt(0) - 'A';
                int kolom = 0;
                try {
                    kolom = Integer.parseInt(seat.substring(1));
                } catch (Exception e) {}
                
                model.Tiket tiket;
                if (jadwal.getNamaStudio().toLowerCase().contains("premier")) {
                    tiket = new model.TiketPremiere("TKT-" + seat, baris, kolom, jadwal);
                } else {
                    tiket = new model.TiketReguler("TKT-" + seat, baris, kolom, jadwal);
                }
                transaksiOOP.tambahTiket(tiket);
            }
            // Menggunakan Polymorphism dari Tiket.hitungHarga() via Transaksi.hitungTotal()
            double subtotal = transaksiOOP.hitungTotal();
            // ------------------------
            
            session.setAttribute("subtotal", subtotal);
            session.setAttribute("subtotalFormatted", formatRupiah(subtotal));
            session.setAttribute("transaksiOOP", transaksiOOP);
            
            // Reset promo and success flags
            session.removeAttribute("kodePromo");
            session.removeAttribute("promoDeskripsi");
            session.removeAttribute("diskon");
            session.removeAttribute("bayarSukses");
            session.removeAttribute("kodeBooking");
            
            hitungTotalAkhir(session);
            
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        } 
        else if ("terapkanPromo".equals(aksi)) {
            String kodePromo = request.getParameter("kodePromo");
            PromoDAO promoDAO = new PromoDAO();
            Promo promo = promoDAO.getPromoByKode(kodePromo);
            
            if (promo != null) {
                Double subtotalObj = (Double) session.getAttribute("subtotal");
                double subtotal = (subtotalObj != null) ? subtotalObj : 0.0;
                
                double diskon = promo.hitungDiskon(subtotal);
                
                session.setAttribute("kodePromo", kodePromo);
                session.setAttribute("promoDeskripsi", promo.getDeskripsiPromo());
                session.setAttribute("diskon", diskon);
                session.setAttribute("diskonFormatted", formatRupiah(diskon));
                session.setAttribute("successPromo", "Promo berhasil digunakan!");
            } else {
                session.setAttribute("errorPromo", "Kode promo tidak valid atau tidak ditemukan.");
            }
            
            hitungTotalAkhir(session);
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }
        else if ("bayarDanCetak".equals(aksi)) {
            String[] seats = (String[]) session.getAttribute("selectedSeats");
            Double totalAkhirObj = (Double) session.getAttribute("totalAkhir");
            String kodePromo = (String) session.getAttribute("kodePromo");
            
            if (seats == null || jadwal == null) {
                response.sendRedirect(request.getContextPath() + "/katalog");
                return;
            }
            
            String kursiDipilihStr = String.join(", ", seats);
            double totalAkhir = (totalAkhirObj != null) ? totalAkhirObj : 0.0;
            
            // Generate simple kode booking
            String kodeBooking = "MVX-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            Transaksi t = new Transaksi();
            t.setKodeBooking(kodeBooking);
            t.setUserId(user.getId());
            t.setJadwalId(jadwal.getId());
            t.setJumlahKursi(seats.length);
            t.setKursiDipilih(kursiDipilihStr);
            t.setTotalHarga(totalAkhir);
            t.setKodePromo(kodePromo);
            
            TransaksiDAO dao = new TransaksiDAO();
            boolean success = dao.insertTransaksi(t);
            
            if (success) {
                session.setAttribute("bayarSukses", true);
                session.setAttribute("kodeBooking", kodeBooking);
                response.sendRedirect(request.getContextPath() + "/checkout");
            } else {
                session.setAttribute("errorPromo", "Gagal memproses pembayaran. Silakan coba lagi.");
                response.sendRedirect(request.getContextPath() + "/checkout");
            }
            return;
        }
    }
    
    private void hitungTotalAkhir(HttpSession session) {
        Double subtotalObj = (Double) session.getAttribute("subtotal");
        Double diskonObj = (Double) session.getAttribute("diskon");
        
        double subtotal = (subtotalObj != null) ? subtotalObj : 0.0;
        double diskon = (diskonObj != null) ? diskonObj : 0.0;
        double biayaLayanan = 4000.0; // Fixed fee
        
        double totalAkhir = subtotal - diskon + biayaLayanan;
        if (totalAkhir < 0) totalAkhir = 0;
        
        session.setAttribute("totalAkhir", totalAkhir);
        session.setAttribute("totalAkhirFormatted", formatRupiah(totalAkhir));
    }
}

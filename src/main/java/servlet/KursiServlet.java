package servlet;

import model.JadwalTayang;
import model.Film;
import dao.FilmDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/kursi"})
public class KursiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        JadwalTayang jadwal = (JadwalTayang) session.getAttribute("jadwalDipilih");
        
        if (jadwal == null) {
            response.sendRedirect(request.getContextPath() + "/katalog");
            return;
        }

        try {
            FilmDAO filmDAO = new FilmDAO();
            Film film = filmDAO.getFilmById(jadwal.getFilmId());

            if (film != null) {
                request.setAttribute("posterUrl", film.getPosterUrl());
                request.setAttribute("filmTitle", film.getJudul());
            } else {
                request.setAttribute("posterUrl", "images/posters/default.jpg");
                request.setAttribute("filmTitle", jadwal.getNamaFilm());
            }

            request.setAttribute("filmDate", jadwal.getHari());
            request.setAttribute("filmTime", jadwal.getJamTayang());
            request.setAttribute("studioName", jadwal.getNamaStudio());
            request.setAttribute("ticketPrice", (int) jadwal.getHarga());
            
            dao.TransaksiDAO transaksiDAO = new dao.TransaksiDAO();
            java.util.List<String> takenSeats = transaksiDAO.getKursiDipilihByJadwal(jadwal.getId());
            StringBuilder takenSeatsFormatted = new StringBuilder();
            for (int i = 0; i < takenSeats.size(); i++) {
                takenSeatsFormatted.append("'").append(takenSeats.get(i)).append("'");
                if (i < takenSeats.size() - 1) {
                    takenSeatsFormatted.append(", ");
                }
            }
            request.setAttribute("takenSeatsFormatted", takenSeatsFormatted.toString()); 
            
            int rows = 8;
            int cols = 10;
            if (jadwal.getNamaStudio().toLowerCase().contains("premier")) {
                rows = 6;
                cols = 8;
            }
            request.setAttribute("seatRows", rows);
            request.setAttribute("seatCols", cols);

            // --- IMPLEMENTASI OOP ---
            model.Studio studioOOP = new model.Studio(jadwal.getStudioId(), jadwal.getNamaStudio(), rows, cols);
            for (String seat : takenSeats) {
                if(seat == null || seat.trim().isEmpty()) continue;
                int r = seat.charAt(0) - 'A';
                int c = 0;
                try {
                    // Dalam UI, kolom dimulai dari 1. Di matriks Studio, dimulai dari 0.
                    c = Integer.parseInt(seat.substring(1)) - 1;
                    studioOOP.pesanKursi(r, c);
                } catch (Exception e) {}
            }
            request.setAttribute("sisaKursiOOP", studioOOP.getSisaKursi());
            // ------------------------

            request.getRequestDispatcher("/pilihKursi.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/katalog");
        }
    }
}

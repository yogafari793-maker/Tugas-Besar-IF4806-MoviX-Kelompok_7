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
            
            if (jadwal.getNamaStudio().toLowerCase().contains("premier")) {
                request.setAttribute("seatRows", 6);
                request.setAttribute("seatCols", 8);
            } else {
                request.setAttribute("seatRows", 8);
                request.setAttribute("seatCols", 10);
            }

            request.getRequestDispatcher("/pilihKursi.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/katalog");
        }
    }
}

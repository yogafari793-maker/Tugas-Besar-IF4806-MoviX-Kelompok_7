package servlet;

import dao.FilmDAO;
import dao.JadwalDAO;
import model.Film;
import model.JadwalTayang;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    private final FilmDAO filmDAO = new FilmDAO();
    private final JadwalDAO jadwalDAO = new JadwalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        // Validasi Admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("userRole");
        if (role == null || !role.equals("Admin")) {
            response.sendRedirect(request.getContextPath() + "/katalog");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        if ("deleteJadwal".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                if (jadwalDAO.delete(id)) {
                    session.setAttribute("success", "Jadwal berhasil dihapus!");
                }
            } catch (Exception e) {
                System.err.println("Gagal delete jadwal: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
            return;
        } else if ("deleteFilm".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                if (filmDAO.delete(id)) {
                    session.setAttribute("success", "Film berhasil dihapus!");
                }
            } catch (Exception e) {
                System.err.println("Gagal delete film: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
            return;
        }

        if ("dashboard".equals(action)) {
            // Check for success message in session and move to request scope
            String successMsg = (String) session.getAttribute("success");
            if (successMsg != null) {
                request.setAttribute("success", successMsg);
                session.removeAttribute("success");
            }

            // Load Jadwal
            List<JadwalTayang> reguler = jadwalDAO.getByTipe("reguler");
            List<JadwalTayang> premier = jadwalDAO.getByTipe("premier");
            List<JadwalTayang> gabungan = new ArrayList<>(reguler);
            gabungan.addAll(premier);
            request.setAttribute("semuaJadwal", gabungan);

            // Load Film
            List<Film> semuaFilm = filmDAO.getAllFilms();
            request.setAttribute("semuaFilm", semuaFilm);

            request.getRequestDispatcher("/WEB-INF/admin_jadwal.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        // Validasi Admin
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("userRole");
        if (role == null || !role.equals("Admin")) {
            response.sendRedirect(request.getContextPath() + "/katalog");
            return;
        }

        String action = request.getParameter("action");

        if ("insertJadwal".equals(action) || "updateJadwal".equals(action)) {
            try {
                int filmId = Integer.parseInt(request.getParameter("filmId"));
                int studioId = Integer.parseInt(request.getParameter("studioId"));
                String hari = request.getParameter("hari");
                String jamTayang = request.getParameter("jamTayang");
                double harga = Double.parseDouble(request.getParameter("harga"));

                if ("insertJadwal".equals(action)) {
                    if (jadwalDAO.insert(filmId, studioId, hari, jamTayang, harga)) {
                        session.setAttribute("success", "Jadwal baru berhasil ditambahkan!");
                    }
                } else {
                    int id = Integer.parseInt(request.getParameter("id"));
                    if (jadwalDAO.update(id, filmId, studioId, hari, jamTayang, harga)) {
                        session.setAttribute("success", "Jadwal berhasil diperbarui!");
                    }
                }
            } catch (Exception e) {
                System.err.println("Gagal proses jadwal: " + e.getMessage());
            }
        } else if ("insertFilm".equals(action) || "updateFilm".equals(action)) {
            try {
                String judul = request.getParameter("judulFilm");
                String genre = request.getParameter("genreFilm");
                int durasi = Integer.parseInt(request.getParameter("durasiFilm"));
                String ratingUsia = request.getParameter("ratingUsia");
                if (ratingUsia == null) ratingUsia = "SU"; // Default
                String sinopsis = request.getParameter("sinopsis");
                if (sinopsis == null) sinopsis = "Sinopsis belum tersedia.";
                String posterUrl = request.getParameter("posterUrl");
                if (posterUrl == null) posterUrl = "images/posters/default.jpg";

                Film film = new Film(0, judul, genre, durasi, ratingUsia, sinopsis, posterUrl);

                if ("insertFilm".equals(action)) {
                    if (filmDAO.insert(film)) {
                        session.setAttribute("success", "Film baru berhasil ditambahkan!");
                    }
                } else {
                    int id = Integer.parseInt(request.getParameter("filmIdEdit"));
                    film = new Film(id, judul, genre, durasi, ratingUsia, sinopsis, posterUrl);
                    if (filmDAO.update(film)) {
                        session.setAttribute("success", "Film berhasil diperbarui!");
                    }
                }
            } catch (Exception e) {
                System.err.println("Gagal proses film: " + e.getMessage());
            }
        }

        // Redirect to GET dashboard to prevent form resubmission and reload data
        response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
    }
}

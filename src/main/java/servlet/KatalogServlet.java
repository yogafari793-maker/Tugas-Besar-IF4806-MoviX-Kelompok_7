package servlet;

import dao.FilmDAO;
import model.Film;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author AXELL
 */
@WebServlet(name = "KatalogServlet", urlPatterns = {"/katalog"})
public class KatalogServlet extends HttpServlet {

    private FilmDAO filmDAO;

    @Override
    public void init() {
        filmDAO = new FilmDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mengambil semua data film dari database
        List<Film> daftarFilm = filmDAO.getAllFilms();
        
        // Ekstrak genre unik secara dinamis
        java.util.Set<String> genreSet = new java.util.HashSet<>();
        for (Film f : daftarFilm) {
            if (f.getGenre() != null && !f.getGenre().trim().isEmpty()) {
                genreSet.add(f.getGenre().trim());
            }
        }
        List<String> daftarGenre = new java.util.ArrayList<>(genreSet);
        java.util.Collections.sort(daftarGenre);

        // Menyimpan data ke dalam request scope agar bisa dibaca oleh JSP
        request.setAttribute("daftarFilm", daftarFilm);
        request.setAttribute("daftarGenre", daftarGenre);
        
        // Meneruskan request ke halaman katalog.jsp
        request.getRequestDispatcher("/katalog.jsp").forward(request, response);
    }
}

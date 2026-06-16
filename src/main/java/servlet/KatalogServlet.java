package servlet;

import dao.FilmDAO;
import model.Film;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        
        // Menyimpan data film ke dalam request scope agar bisa dibaca oleh JSP
        request.setAttribute("daftarFilm", daftarFilm);
        
        // Meneruskan request ke halaman katalog.jsp
        request.getRequestDispatcher("/katalog.jsp").forward(request, response);
    }
}

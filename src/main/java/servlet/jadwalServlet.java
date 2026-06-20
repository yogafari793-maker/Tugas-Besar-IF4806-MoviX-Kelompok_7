/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.JadwalDAO;
import model.JadwalTayang;
import java.util.List;

import java.io.IOException;
// Jika Anda menggunakan Tomcat 10+ / GlassFish 6+, gunakan jakarta.servlet
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ghifa
 */
@WebServlet(urlPatterns = {"/jadwal", "/jadwal/reguler", "/jadwal/premier"})
public class jadwalServlet extends HttpServlet {

    private final JadwalDAO jadwalDAO = new JadwalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        String filmIdParam = request.getParameter("filmId");


        if (filmIdParam == null || filmIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/katalog");
            return;
        }


        if ("/jadwal".equals(path)) {
            try {
                int filmId = Integer.parseInt(filmIdParam);
                dao.FilmDAO filmDAO = new dao.FilmDAO();
                model.Film film = filmDAO.getFilmById(filmId);
                
                if (film != null) {
                    request.setAttribute("filmId", filmIdParam);
                    request.setAttribute("namaFilm", film.getJudul());
                    request.getRequestDispatcher("/WEB-INF/tiket.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/katalog");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/katalog");
            }
            return;
        }


        String tipe = path.endsWith("premier") ? "premier" : "reguler";
        List<JadwalTayang> jadwalList;

        try {
            int filmId = Integer.parseInt(filmIdParam);
            String tipeDb = "premier".equals(tipe) ? "Premiere" : "Reguler";
            jadwalList = jadwalDAO.getByFilmDanTipe(filmId, tipeDb);
            request.setAttribute("filmId", filmId);
        } catch (NumberFormatException e) {
            jadwalList = java.util.Collections.emptyList();
        }

        request.setAttribute("jadwalList", jadwalList);
        request.setAttribute("tipe", tipe);

        String jspTarget = "premier".equals(tipe) ? "/WEB-INF/jadwal_premier.jsp" : "/WEB-INF/jadwal_reguler.jsp";

        if (!jadwalList.isEmpty()) {
            JadwalTayang pertama = jadwalList.get(0);
            request.setAttribute("namaFilm",   pertama.getNamaFilm());
            request.setAttribute("namaStudio", pertama.getNamaStudio());
        } else {
            request.setAttribute("namaFilm",   "Film Tidak Tersedia di Kelas Ini");
            request.setAttribute("namaStudio", "-");
        }

        request.getRequestDispatcher(jspTarget).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jadwalIdParam = request.getParameter("jadwalId");
        String tipeParam = request.getParameter("tipe");
        if (tipeParam == null || tipeParam.isEmpty()) { tipeParam = "reguler"; }

        if (jadwalIdParam == null || jadwalIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/katalog");
            return;
        }

        try {
            int jadwalId = Integer.parseInt(jadwalIdParam);
            JadwalTayang jadwal = jadwalDAO.getById(jadwalId);

            if (jadwal == null) {
                response.sendRedirect(request.getContextPath() + "/katalog");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("jadwalDipilih", jadwal);
            response.sendRedirect(request.getContextPath() + "/kursi?jadwalId=" + jadwalId);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/katalog");
        }
    }
}

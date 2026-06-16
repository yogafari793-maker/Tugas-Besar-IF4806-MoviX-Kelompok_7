/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet; // 1. Pastikan nama packagenya murni 'servlet'

import dao.JadwalDAO;          // 2. Tambahkan/pastikan import ini benar
import model.JadwalTayang;      // 3. Tambahkan/pastikan import ini benar
import java.util.List;          // 4. Pastikan import List ada

import java.io.IOException;
// Jika Anda menggunakan Tomcat 10+ / GlassFish 6+, gunakan jakarta.servlet
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Tambahkan import session

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
        String actionParam = request.getParameter("action");

        if ("insertFilm".equals(actionParam)) {
            try {
                String judul = request.getParameter("judulFilm");
                String genre = request.getParameter("genreFilm");
                int durasi = Integer.parseInt(request.getParameter("durasiFilm"));

                boolean sukses = jadwalDAO.insertFilm(judul, genre, durasi);
                if (sukses) {
                    request.setAttribute("success", "Film baru berhasil didaftarkan ke sistem!");
                }
            } catch (Exception e) {
                System.err.println("Gagal insert film: " + e.getMessage());
            }

            // Refresh data gabungan jadwal untuk dikembalikan ke tampilan admin_jadwal.jsp
            List<JadwalTayang> reguler = jadwalDAO.getByTipe("reguler");
            List<JadwalTayang> premier = jadwalDAO.getByTipe("premier");
            List<JadwalTayang> gabungan = new java.util.ArrayList<>(reguler);
            gabungan.addAll(premier);

            request.setAttribute("semuaJadwal", gabungan);
            request.getRequestDispatcher("/WEB-INF/admin_jadwal.jsp").forward(request, response);
            return;
        }

        if ("admin".equals(actionParam)) {
            List<JadwalTayang> reguler = jadwalDAO.getByTipe("reguler");
            List<JadwalTayang> premier = jadwalDAO.getByTipe("premier");
            List<JadwalTayang> gabungan = new java.util.ArrayList<>(reguler);
            gabungan.addAll(premier);

            request.setAttribute("semuaJadwal", gabungan);
            request.getRequestDispatcher("/WEB-INF/admin_jadwal.jsp").forward(request, response);
            return;
        }
        
        // Di dalam metode doGet, sebelum pengecekan filmIdParam, tambahkan logika delete di bawah ini:
        if ("delete".equals(actionParam)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean sukses = jadwalDAO.delete(id);
                if (sukses) {
                    request.setAttribute("success", "Jadwal berhasil dihapus!");
                }
            } catch (Exception e) {
                System.err.println("Gagal delete data: " + e.getMessage());
            }
            // Paksa pindah ke halaman admin kembali untuk refresh data
            actionParam = "admin"; 
        }
        
        // VALIDASI: Jika tidak membawa ID Film, balikkan paksa ke index katalog film utama
        if (filmIdParam == null || filmIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // ALUR 2: Jika URL murni '/jadwal' dan membawa filmId -> Arahkan ke pilihan TIKET (Langkah 2)
        if ("/jadwal".equals(path)) {
            try {
                int filmId = Integer.parseInt(filmIdParam);
                JadwalTayang infoFilm = jadwalDAO.getByFilmDanTipe(filmId, "reguler").stream().findFirst()
                        .orElse(jadwalDAO.getByFilmDanTipe(filmId, "premier").stream().findFirst().orElse(null));
                
                if (infoFilm != null) {
                    request.setAttribute("filmId", filmIdParam);
                    request.setAttribute("namaFilm", infoFilm.getNamaFilm());
                    request.getRequestDispatcher("/WEB-INF/pilih_tiket.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
            return;
        }

        // ALUR 3: Jika URL mengandung '/reguler' atau '/premier' -> Tampilkan WAKTU JADWAL (Langkah 3)
        String tipe = path.endsWith("premier") ? "premier" : "reguler";
        List<JadwalTayang> jadwalList;

        try {
            int filmId = Integer.parseInt(filmIdParam);
            jadwalList = jadwalDAO.getByFilmDanTipe(filmId, tipe);
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
        String actionParam = request.getParameter("action");
        
        // FITUR ADMIN: Proses input jadwal baru ke database
        if ("insert".equals(actionParam)) {
            try {
                int filmId = Integer.parseInt(request.getParameter("filmId"));
                int studioId = Integer.parseInt(request.getParameter("studioId"));
                String hari = request.getParameter("hari");
                String jamTayang = request.getParameter("jamTayang");
                double harga = Double.parseDouble(request.getParameter("harga"));

                boolean sukses = jadwalDAO.insert(filmId, studioId, hari, jamTayang, harga);
                if (sukses) {
                    request.setAttribute("success", "Jadwal baru berhasil ditambahkan ke database!");
                }
            } catch (Exception e) {
                System.err.println("Gagal insert data: " + e.getMessage());
            }

            // Panggil ulang logika internal admin agar tabel ter-refresh otomatis
            List<JadwalTayang> reguler = jadwalDAO.getByTipe("reguler");
            List<JadwalTayang> premier = jadwalDAO.getByTipe("premier");
            List<JadwalTayang> gabungan = new java.util.ArrayList<>(reguler);
            gabungan.addAll(premier);

            request.setAttribute("semuaJadwal", gabungan);
            request.getRequestDispatcher("/WEB-INF/admin_jadwal.jsp").forward(request, response);
            return;
        }
        
        if (tipeParam == null || tipeParam.isEmpty()) { tipeParam = "reguler"; }

        if (jadwalIdParam == null || jadwalIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        try {
            int jadwalId = Integer.parseInt(jadwalIdParam);
            JadwalTayang jadwal = jadwalDAO.getById(jadwalId);

            if (jadwal == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("jadwalDipilih", jadwal);
            response.sendRedirect(request.getContextPath() + "/kursi?jadwalId=" + jadwalId);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
        
        // FITUR ADMIN: Proses input dan edit jadwal ke database
        if ("insert".equals(actionParam) || "update".equals(actionParam)) {
            try {
                int filmId = Integer.parseInt(request.getParameter("filmId"));
                int studioId = Integer.parseInt(request.getParameter("studioId"));
                String hari = request.getParameter("hari");
                String jamTayang = request.getParameter("jamTayang");
                double harga = Double.parseDouble(request.getParameter("harga"));

                if ("insert".equals(actionParam)) {
                    boolean sukses = jadwalDAO.insert(filmId, studioId, hari, jamTayang, harga);
                    if (sukses) request.setAttribute("success", "Jadwal baru berhasil ditambahkan!");
                } else {
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean sukses = jadwalDAO.update(id, filmId, studioId, hari, jamTayang, harga);
                    if (sukses) request.setAttribute("success", "Jadwal berhasil diperbarui!");
                }
            } catch (Exception e) {
                System.err.println("Gagal memproses data admin: " + e.getMessage());
            }

            // Panggil ulang logika internal admin agar tabel ter-refresh otomatis
            List<JadwalTayang> reguler = jadwalDAO.getByTipe("reguler");
            List<JadwalTayang> premier = jadwalDAO.getByTipe("premier");
            List<JadwalTayang> gabungan = new java.util.ArrayList<>(reguler);
            gabungan.addAll(premier);

            request.setAttribute("semuaJadwal", gabungan);
            request.getRequestDispatcher("/WEB-INF/admin_jadwal.jsp").forward(request, response);
            return;
        }
    }
}

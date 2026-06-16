package servlet;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Pengguna;

/**
 *
 * @author AXELL
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/logout")) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate(); // Clear session
            }
            response.sendRedirect(request.getContextPath() + "/");
        } else if (path.equals("/login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (path.equals("/register")) {
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        if (path.equals("/login")) {
            String uname = request.getParameter("username");
            String pass = request.getParameter("password");
            
            Pengguna user = userDAO.loginUser(uname, pass);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userRole", user.getRole());
                
                if (user.getRole().equalsIgnoreCase("Admin")) {
                    response.sendRedirect(request.getContextPath() + "/katalog");
                } else {
                    response.sendRedirect(request.getContextPath() + "/katalog");
                }
            } else {
                request.setAttribute("errorMessage", "Username atau Password salah!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } 
        else if (path.equals("/register")) {
            String nama = request.getParameter("nama");
            String uname = request.getParameter("username");
            String pass = request.getParameter("password");
            
            boolean success = userDAO.registerUser(uname, pass, nama);
            if (success) {
                request.setAttribute("successMessage", "Registrasi berhasil! Silakan login.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Username sudah terdaftar atau terjadi kesalahan!");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        }
    }
}

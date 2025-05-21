package za.ac.tut.bl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ConfirmBookingServlet.do")
public class ConfirmBookingServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://172.20.10.3:3306/edusync_db";
    private static final String DB_USER = "kgj";
    private static final String DB_PASSWORD = "kgotso";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String action = request.getParameter("action");

        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String updateSql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
            try (PreparedStatement ps = con.prepareStatement(updateSql)) {
                ps.setString(1, "confirm".equals(action) ? "Confirmed" : "Rejected");
                ps.setInt(2, bookingId);
                ps.executeUpdate();
            }

            // Insert status into confirmBookingsTBL (logging outcome)
            String logSql = "INSERT INTO confirmBookingsTBL (booking_id, status) VALUES (?, ?)";
            try (PreparedStatement ps2 = con.prepareStatement(logSql)) {
                ps2.setInt(1, bookingId);
                ps2.setString(2, "confirm".equals(action) ? "Confirmed" : "Rejected");
                ps2.executeUpdate();
            }

            response.sendRedirect("booking_report_outcome_page.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking_report_outcome_page.jsp?status=error");
        }
    }
}

package za.ac.tut.bl;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/DownloadFilteredReportServlet")
public class DownloadFilteredReportServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://172.20.10.3:3306/edusync_db";
    private static final String DB_USER = "kgj";
    private static final String DB_PASSWORD = "kgotso";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status");
        if (status == null || !(status.equalsIgnoreCase("Confirmed") || status.equalsIgnoreCase("Rejected"))) {
            response.getWriter().write("Invalid status filter.");
            return;
        }

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment;filename=filtered_bookings_" + status.toLowerCase() + ".csv");

        try (
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement ps = conn.prepareStatement(
                "SELECT booking_id, student_name, booking_date, booking_time FROM confirmBookingsTBL WHERE status = ?")
        ) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            PrintWriter out = response.getWriter();
            out.println("Booking ID,Student Name,Booking Date,Booking Time");

            while (rs.next()) {
                out.printf("%d,%s,%s,%s%n",
                        rs.getInt("booking_id"),
                        rs.getString("student_name").replace(",", " "),
                        rs.getDate("booking_date"),
                        rs.getString("booking_time"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error generating CSV.");
        }
    }
}

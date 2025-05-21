package za.ac.tut.bl;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import za.ac.tut.entities.AppUser;

@WebServlet("/ExportReportServlet.do")
public class ExportReportServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://172.20.10.3:3306/edusync_db";
    private static final String DB_USER = "kgj";
    private static final String DB_PASSWORD = "kgotso";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String format = request.getParameter("format");
        HttpSession session = request.getSession();
        AppUser user = (AppUser) session.getAttribute("user");

        String filterDate = request.getParameter("filter_date");
        String filterReason = request.getParameter("filter_reason");

        if (user == null || format == null || !"csv".equalsIgnoreCase(format)) {
            response.sendRedirect("fetch_report.jsp?status=error");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            StringBuilder sql = new StringBuilder("SELECT booking_date, time_slot, reason FROM tutorial_booking WHERE userid = ?");
            if (filterDate != null && !filterDate.isEmpty()) {
                sql.append(" AND booking_date = ?");
            }
            if (filterReason != null && !filterReason.isEmpty()) {
                sql.append(" AND reason LIKE ?");
            }

            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int i = 1;
            ps.setLong(i++, user.getUserId());
            if (filterDate != null && !filterDate.isEmpty()) {
                ps.setDate(i++, java.sql.Date.valueOf(filterDate));
            }
            if (filterReason != null && !filterReason.isEmpty()) {
                ps.setString(i++, "%" + filterReason + "%");
            }

            ResultSet rs = ps.executeQuery();

            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment;filename=consultation_report.csv");

            PrintWriter out = response.getWriter();
            out.println("Booking Date,Time Slot,Reason");

            while (rs.next()) {
                out.printf("%s,%s,%s%n",
                        rs.getDate("booking_date"),
                        rs.getString("time_slot"),
                        rs.getString("reason").replace(",", " "));
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error exporting report.");
        }
    }

}

package za.ac.tut.bl;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewHistoryServlet")
public class ViewHistoryServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://172.20.10.3:3306/edusync_db";
    private static final String DB_USER = "kgj";
    private static final String DB_PASSWORD = "kgotso";

    public static class Consultation {
        private String id;
        private String date;
        private String time;
        private String topic;

        public Consultation(String id,String date, String time, String topic) {
            this.id = id;
            this.date = date;
            this.time = time;
            this.topic = topic;
        }
        public String getId(){return id; }
        public String getDate() { return date; }
        public String getTime() { return time; }
        public String getTopic() { return topic; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filterDate = request.getParameter("filterDate");
        List<Consultation> consultations = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT userid,booking_date, time_slot, reason FROM tutorial_booking";
            if (filterDate != null && !filterDate.isEmpty()) {
                sql += " WHERE booking_date = ?";
            }

            PreparedStatement ps = conn.prepareStatement(sql);
            if (filterDate != null && !filterDate.isEmpty()) {
                ps.setString(1, filterDate);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String userid = rs.getString("userid");
                String date = rs.getString("booking_date");
                String time = rs.getString("time_slot");
                String topic = rs.getString("reason");
                consultations.add(new Consultation(userid,date, time, topic));
            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("consultations", consultations);
        request.setAttribute("selectedDate", filterDate);
        RequestDispatcher rd = request.getRequestDispatcher("view_history.jsp");
        rd.forward(request, response);
    }
}

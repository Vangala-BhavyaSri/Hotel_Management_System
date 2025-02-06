<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Room</title>
</head>
<body>
    <h2>Book Room</h2>
    <%
        
        String dbURL = "jdbc:mysql://localhost:3306/hotel";
        String dbUser = "Bhavya";
        String dbPass = "Bhavya@08";
        
        Connection conn = null;
        PreparedStatement pstmtBook = null;
        PreparedStatement pstmtVacate = null;
        
        
        String room_id_str = request.getParameter("room_id");
        
        if (room_id_str != null && !room_id_str.isEmpty()) {
            int roomId = Integer.parseInt(room_id_str);
            
            try {
             
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                
               
                String sqlBook = "UPDATE rooms SET availability = false WHERE id = ?";
                pstmtBook = conn.prepareStatement(sqlBook);
                pstmtBook.setInt(1, roomId);
                int rowsAffected = pstmtBook.executeUpdate();
                
                
                out.println("<p>Room with ID " + roomId + " booked successfully. Rows affected: " + rowsAffected + "</p>");
                
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error booking room: " + e.getMessage() + "</p>");
            } 
            finally {
                
                try { if (pstmtBook != null) pstmtBook.close(); } catch (SQLException e) { /* ignored */ }
                try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
            }
        } else {
            out.println("<p>Room ID parameter is missing or empty.</p>");
        }
    %>
    
    Username:<input type=text name=name value name>
    <p><a href="availability.jsp">Back to Availability</a></p>
    <p><a href="profile.jsp">Back to Profile</a></p>
    <p><a href="logout.jsp">Logout</a></p>
</body>
</html>

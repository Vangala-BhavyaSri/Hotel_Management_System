<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rooms Availability</title>
    <style>
        .container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .room-card {
            width: 400px; 
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .book-button {
            background-color: blue; 
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            width: 100%; 
        }
        .book-button.booked {
            background-color: red !important;
        }
        .vacate-button {
            background-color: green;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            width: 100%; 
        }
    </style>
</head>
<body>
 <h2>Available Rooms</h2> 
    <div class="container">
        <%
            
            String dbURL = "jdbc:mysql://localhost:3306/hotel";
            String dbUser = "Bhavya";
            String dbPass = "Bhavya@08";
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                
                
                String sqlSelect = "SELECT DISTINCT id, room_number, availability FROM rooms";
                pstmt = conn.prepareStatement(sqlSelect);
                rs = pstmt.executeQuery();
                
                
                while (rs.next()) {
                    int roomId = rs.getInt("id");
                    String roomNumber = rs.getString("room_number");
                    boolean availability = rs.getBoolean("availability");
                    
                    
                    out.println("<div class='room-card'>");
                    out.println("<p>Room Number: " + roomNumber + "</p>");
                    
                    
                    if (availability) {
                        out.println("<form action='bookRoom.jsp' method='post'>");
                        out.println("<input type='hidden' name='room_id' value='" + roomId + "'>");
                        out.println("<input type='submit' class='book-button' value='Book'>");
                        out.println("</form>");
                    } else {
                        out.println("<p>Room is booked by Bhavya </p>");
                        
                        out.println("<form action='vacateRoom.jsp' method='post'>");
                        out.println("<input type='hidden' name='room_id' value='" + roomId + "'>");
                        out.println("<input type='submit' class='vacate-button' value='Vacate Room'>");
                        out.println("</form>");
                    }
                    
                    
                    out.println("</div>");
                }
                
                
                if (!rs.isBeforeFirst()) {
                    out.println("<p>No rooms available at the moment.</p>");
                }
                
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { /* ignored */ }
                try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
            }
        %>
        
        <p><a href="profile.jsp">Back to Profile</a></p>
        <p><a href="logout.jsp">Logout</a></p>
    </div>
</body>
</html>

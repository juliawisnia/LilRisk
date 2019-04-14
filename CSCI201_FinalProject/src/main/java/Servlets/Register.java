import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("pw");
		String password2 = request.getParameter("cpw");
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		PrintWriter print = response.getWriter();

		
		try {

            Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			stmt = conn.createStatement();
			String queryString = "SELECT * FROM User";
			rs = stmt.executeQuery(queryString);
			boolean alreadyUser = false;
			
		    
            while(rs.next()) {
            	String unameD = rs.getString("email");
              
                //CHECK IF THE USERNAME ALREADY EXISTS
                if (email.equals(unameD)) {
                	print.println("This username is already taken.");
                	alreadyUser = true;
                }
               
            }
            stmt.close();
            
            //SUCCESSFUL NEW USER
            if (password.equals(password2)) {
            	if(!alreadyUser) {
	            	ps = conn.prepareStatement("INSERT INTO User(username, userPassword) VALUES(?,?)");
	            	ps.setString(1, email);
	            	ps.setString(2, password);
	            	ps.executeUpdate();
	                ps.close();
            	}
            }
            
            //CHECK IF THE PASSWORDS DON'T MATCH
            else {
            	if(!alreadyUser) {
                	print.println("The passwords do not match.");
            	}
            }
 
		} catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		} catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		} finally {
			try {
				if(rs != null) { rs.close(); }
				if(conn != null) { conn.close(); }
				if(stmt != null) { stmt.close(); }
			} catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}

}


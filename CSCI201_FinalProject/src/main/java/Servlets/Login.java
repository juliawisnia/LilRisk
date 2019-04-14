package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import coinData.UserClass;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LilRisk?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			boolean sent = false;
			while(rs.next()) {
				sent = true;
				if(!rs.getString("pass").equals(password)) {
					request.setAttribute("errorMessage", "Incorrect Password");
					String nextPage = "/login.jsp";
					RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
					dispatch.forward(request, response);
				}
				else {
					request.setAttribute("username", username);
					HttpSession ses = request.getSession();
					UserClass user = (UserClass)ses.getAttribute("user");
					user.setUsername(username);
					user.loadUser(rs.getInt("userID"), username);
					String nextPage = "/home.jsp";
					RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
					dispatch.forward(request, response);
				}
			}
			if(!sent) {
				request.setAttribute("errorMessage", "User was not found");
				String nextPage = "/login.jsp";
				RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
				dispatch.forward(request, response);
			}
		}
		catch (SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			}
			catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

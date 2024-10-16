package pension;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class loginok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String login_check = request.getParameter("login_check");
		HttpSession session = request.getSession();
		//HashMap<String, String> login_data = new HashMap<String, String>();
		db_pension db = new db_pension();
		ResultSet rs = null;
		PrintWriter pwr = null;
		try {
			if(id != null) {
				String sql = "SELECT uid,upass,utel FROM user_info WHERE uid=?";
				PreparedStatement ps =  db.getConnection().prepareStatement(sql);
				ps.setString(1, id);
				rs = ps.executeQuery();
				pwr = response.getWriter();
				while(rs.next()) {
					if(id.equals(rs.getString("uid")) && pw.equals(rs.getString("upass"))) {
						if(login_check != null) {
							pwr.write("<script>localStorage.setItem('storage_login_ck','"+ login_check +"')</script>");
							session.setAttribute("login_check", login_check);
							
						}
						session.setAttribute("id", id);
						session.setAttribute("tel", rs.getString("utel"));
						response.sendRedirect("./index.jsp");
					} else {
						pwr.write("<script>"
								+ "alert('?ïÑ?ù¥?îî?? ÎπÑÎ?Î≤àÌò∏Î•? ?ôï?ù∏?ï¥Ï£ºÏÑ∏?öî.');"
								+ "location.href = './index.jsp'"
								+ "</script>");
					}
					
				}
				pwr.close();
				rs.close();
				ps.close();
				db.getConnection().close();
			}
		} catch(Exception e) {
			System.out.println(e);
		}
	}
}

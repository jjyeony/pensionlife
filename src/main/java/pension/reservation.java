package pension;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class reservation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PrintWriter pw = null;
	Connection con = null;
	PreparedStatement ps = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		db_pension db = new db_pension();

		// 펜션예약정보
		String ruser_id = request.getParameter("ruser_id");
		String rpension_name = request.getParameter("rpension_name");
		String rroom = request.getParameter("rroom");
		String rdatechoice = request.getParameter("rdate");
		String rroom_info = request.getParameter("rinfo");
		String rmember = request.getParameter("rcount");
		String radd_member = request.getParameter("radd_member");
		String rprice = request.getParameter("rprice");
		
		//System.out.println(rdatechoice);
		// 예약자 정보
		String ruser_name = request.getParameter("rname");
		String ruser_hp = request.getParameter("rhp");
		String ruser_member = request.getParameter("rcount");
		String ruser_email = request.getParameter("remail");
	
		
		try {

			this.con = db.getConnection();
			String sql = "insert into reservation values ('0',?,?,?,?,?,?,?,?,?,?,?,?,now())";
			this.ps = this.con.prepareStatement(sql);
			this.ps.setString(1, ruser_id);
			this.ps.setString(2, rpension_name);
			this.ps.setString(3, rroom);
			this.ps.setString(4, rdatechoice);
			this.ps.setString(5, rroom_info);
			this.ps.setString(6, rmember);
			this.ps.setString(7, radd_member);
			this.ps.setString(8, rprice);
			this.ps.setString(9, ruser_name);
			this.ps.setString(10, ruser_hp);
			this.ps.setString(11, ruser_member);
			this.ps.setString(12, ruser_email);
			int result = this.ps.executeUpdate();
			this.pw = response.getWriter();
			if (result > 0) {
				this.pw.write("<script>" + "alert('예약 완료!');" + "location.href='./index.jsp';" + "</script>");
			} else {
				this.pw.write("<script>alert('오류가 발생하였습니다.');</script>");
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try {
				pw.close();
				this.con.close();
			}catch (Exception e) {
				
			}
			
		}

	}
}

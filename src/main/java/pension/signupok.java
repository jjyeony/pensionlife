package pension;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class signupok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String ck[] = {"term","collect","share","delegate","marketing"};
		String user_info[] = {"id","user_name","pw","email","tel"};
			db_pension db = new db_pension();
			try {
				String sql = "INSERT INTO user_info VALUES('0',?,?,?,?,?,now())";
				PreparedStatement ps = db.getConnection().prepareStatement(sql);				
				int count = 0;
				while(count < user_info.length) {
					if(!(getParameter(request, user_info[count],"").isBlank())) {
						ps.setString(count+1, getParameter(request, user_info[count],""));						
					}else {
						response.sendError(HttpServletResponse.SC_BAD_REQUEST, "?Ç¨?ö©?ûê ?ù¥Î¶?, ?ù¥Î©îÏùº Î∞? ?†Ñ?ôîÎ≤àÌò∏?äî ?ïÑ?àò?ûÖ?ãà?ã§.");
						return;
					}
					count++;
				}
				ps.executeUpdate();
				String sql2 = "INSERT INTO agree VALUES (?,?,?,?,?,?,now())";
				ps = db.getConnection().prepareStatement(sql2);
				int count2 = 0;
				int index = 1;
				while(count2 < ck.length) {
					if(count2 == 0) {
						if(!(getParameter(request, ck[count2],"").isBlank())) {
							ps.setString(index, getParameter(request, user_info[count2],""));
							index++;
							ps.setString(index, getCheck(request, ck[count2],"Y"));
						} else {
							response.sendError(HttpServletResponse.SC_BAD_REQUEST, "?Ç¨?ö©?ûê ?ù¥Î¶?, ?ù¥Î©îÏùº Î∞? ?†Ñ?ôîÎ≤àÌò∏?äî ?ïÑ?àò?ûÖ?ãà?ã§.");
							return;
						}
					} else {
						ps.setString(index, getCheck(request, ck[count2],"Y"));					
					}
					count2++;
					index++;
				}
				
				ps.executeUpdate();
				ps.close();
				db.getConnection().close();
				
				HttpSession session = request.getSession();
		//		HashMap<String, String> login_data = new HashMap<String, String>();
		//		login_data.put("id", getParameter(request, "id",""));
		//		login_data.put("user_name", getParameter(request, "user_name",""));
		//		login_data.put("tel", getParameter(request, "tel",""));
		//		session.setAttribute("data", login_data);
				session.setAttribute("id", getParameter(request, user_info[0],""));
				session.setAttribute("tel", getParameter(request, user_info[4],""));
				response.sendRedirect("index.jsp");
				
			} catch (Exception e) {
				PrintWriter pw = new PrintWriter(System.out);
				
				pw.write("<script>"
						+ "alert('?ïÑ?ù¥?îî ?òê?äî ?†Ñ?ôîÎ≤àÌò∏Î•? Î∞îÍæ∏?Öî?ïº?ï©?ãà?ã§.');"
						+ "history.go(-1);"
						+ "</script>");
				
				pw.close();
				System.out.println(e);
				//response.sendError(0);
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "?ÑúÎ≤? ?Ç¥Î∂? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§.");
			}
		
	}
	
	private String getParameter(HttpServletRequest request, String param, String defaultValue) {
		String paramValue = request.getParameter(param);
		return (paramValue != null) ? paramValue : defaultValue;
	}
	
	private String getCheck(HttpServletRequest request, String param, String defaultValue) {
		String paramValue = request.getParameter(param);
		return (paramValue != null) ? "Y" : defaultValue;
	}

}

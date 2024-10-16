package pension;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class agree extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
	

		HashMap<String, String> hm = new HashMap<String,String>();
		
		String ck[] = {"term","collect","share","delegate","marketing"};
		HttpSession session = request.getSession();
		for(String a : ck) {
			String v = request.getParameter(a);
			if(v != null)
				hm.put(a, v);
		}
		session.setAttribute("arguments", hm);			
		
		response.sendRedirect("./join_info.jsp");
	}

}

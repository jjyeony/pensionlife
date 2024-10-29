package pension;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class admin_qawriteok extends HttpServlet {
	private static final long serialVersionUID = 1L;
    PrintWriter pw=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		String idx=request.getParameter("qidx");
		String text=request.getParameter("qa_answer");
		
		ArrayList<String> data=new ArrayList<String>();
		data.add(idx);
		data.add(text);
		
		insert_answer as=new insert_answer();
		int result=as.aswrite(data);
	
		this.pw=response.getWriter();
		if(result>0) {
			this.pw.write("<script>alert('답변 등록이 완료되었습니다.');"
					+ "location.href='./admin_qalist.jsp';"
					+ "</script>");
		}
		else {
			this.pw.write("<script>alert('오류가 발생하였습니다.');</script>");
		}
		
		this.pw.close();
	}

}

package pension;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class qadeleteok extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PrintWriter pw=null;
	PreparedStatement ps=null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String idx=request.getParameter("modify_idx");
		String file_del1=request.getParameter("file_del1");
		String file_del2=request.getParameter("file_del2");
		
		String url=request.getServletContext().getRealPath("/upload/");
		File fe=null;
		
		if(file_del1!="") {
			int del=file_del1.lastIndexOf("/");
			String del_filename=file_del1.substring(del+1);		
			
			fe=new File(url+del_filename);
			fe.delete();		//?›¹ ?””? ‰?† ë¦¬ì—?„œ ?ŒŒ?¼1 ?‚­? œ
		}
		if(file_del2!="") {
			int del=file_del2.lastIndexOf("/");
			String del_filename=file_del2.substring(del+1);		
			
			fe=new File(url+del_filename);
			fe.delete();		//?›¹ ?””? ‰?† ë¦¬ì—?„œ ?ŒŒ?¼2 ?‚­? œ
		}
		
		
		db_pension db=new db_pension();
		
		try {
			this.con=db.getConnection();
			String sql="delete from qa where qidx=?";
			this.ps=this.con.prepareStatement(sql);
			this.ps.setString(1, idx);
			System.out.println(this.ps);
			int result=this.ps.executeUpdate();
			this.pw=response.getWriter();
			if(result>0) {
				this.pw.write("<script>"
						+ "alert('ë¬¸ì˜ ?‚­? œê°? ?™„ë£Œë˜?—ˆ?Šµ?‹ˆ?‹¤.');"
						+ "location.href='./qalist.jsp';"
						+ "</script>");
			}
			else {
				this.pw.write("<script>"
						+ "alert('?˜¤ë¥˜ê? ë°œìƒ?•˜???Šµ?‹ˆ?‹¤..');"
						+ "</script>");
			}
		}
		catch (Exception e) {
			System.out.println(e);
		}
		finally {
			try {
				
				this.ps.close();
				this.con.close();
			} 
			catch (Exception e) {
				System.out.println(e);
			}
		}
		
	}

}

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

public class file_delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PrintWriter pw=null;
	PreparedStatement ps=null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		this.pw=response.getWriter();
		String fileinfo=request.getParameter("fileinfo");
		
		String file[]=fileinfo.split("@");
		String filename=file[0];
		String fileno=file[1];
		String idx=file[2];
		
		int del=filename.lastIndexOf("/");
		String del_filename=filename.substring(del+1);		
		String url=request.getServletContext().getRealPath("/upload/");
		
		File fe=new File(url+del_filename);
		fe.delete();		//?›¹ ?””? ‰?† ë¦¬ì—?„œ ?ŒŒ?¼ ?‚­? œ
		
		//db?— ???ž¥?œ ?ŒŒ?¼ ? •ë³? ?‚­? œ
		String sql1="";
		String sql2="";
		if(fileno.equals("file_btn1")) {
			sql1="update qa set qfile_url1=' ' where qidx=?";
			sql2="update qa set qfile_name1=' ' where qidx=?";
		}
		else if(fileno.equals("file_btn2")) {
			sql1="update qa set qfile_url2=' ' where qidx=?";
			sql2="update qa set qfile_name2=' ' where qidx=?";
		}
	
		
		db_pension db=new db_pension();
		int result1=0,result2=0;
		try {
			this.con=db.getConnection();
			this.ps=this.con.prepareStatement(sql1);
			this.ps.setString(1, idx);
			result1=this.ps.executeUpdate();
			
			this.ps=this.con.prepareStatement(sql2);
			this.ps.setString(1, idx);
			result2=this.ps.executeUpdate();
			
			if(result1>0&&result2>0) {
				
				this.pw.write("ok");
			}
			
		}catch (Exception e) {
			System.out.println(e);
		}
		finally {
			try {
				this.pw.close();
				this.con.close();
				this.ps.close();
			}
			catch (Exception e) {
				System.out.println(e);
			}
		}
		
	}

}

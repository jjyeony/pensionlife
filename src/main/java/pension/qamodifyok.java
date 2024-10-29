package pension;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
@MultipartConfig(
		fileSizeThreshold = 1024*1024*2,
		maxFileSize = 1024*1024*4,
		maxRequestSize = 1024*1024*10
)
public class qamodifyok extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
    PreparedStatement ps=null;
    PrintWriter pw=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String title=request.getParameter("modify_title");
		String text=request.getParameter("modify_text");
		String idx=request.getParameter("modify_idx");
		String fileno=request.getParameter("fileno");
		Part file=request.getPart("modify_file");
		
		String filename=file.getSubmittedFileName();
		long filesize=file.getSize();
	
		String file_db="";
		String file_rename="";
		
		String url=request.getServletContext().getRealPath("/upload/");
		file_rename re=new file_rename();		//파일 이름 변경 class로드		
		if(filename!=""||filesize>0) {
			file_rename=re.rename(filename);
			file_db="/upload/"+file_rename;
			file.write(url+file_rename);				//web 디렉토리에 파일 저장
		}
	
		//db 정보 수정 
		db_pension db=new db_pension();
		String sql1="update qa set qtitle=? where qidx=?";
		String sql2="update qa set qtext=? where qidx=?";
		String sql3="";
		String sql4="";
		if(fileno.equals("1")) {
			sql3="update qa set qfile_name1=? where qidx=?";
			sql4="update qa set qfile_url1=? where qidx=?";
		}
		else {
			sql3="update qa set qfile_name2=? where qidx=?";
			sql4="update qa set qfile_url2=? where qidx=?";
		}
		
		int result1,result2,result3,result4;
		try {
			this.con=db.getConnection();
			this.ps=this.con.prepareStatement(sql1);
			this.ps.setString(1, title);
			this.ps.setString(2, idx);
			result1=this.ps.executeUpdate();
			
			this.ps=this.con.prepareStatement(sql2);
			this.ps.setString(1, text);
			this.ps.setString(2, idx);
			result2=this.ps.executeUpdate();
			
			this.ps=this.con.prepareStatement(sql3);
			this.ps.setString(1, filename);
			this.ps.setString(2, idx);
			result3=this.ps.executeUpdate();
			
			this.ps=this.con.prepareStatement(sql4);
			this.ps.setString(1, file_db);
			this.ps.setString(2, idx);
			result4=this.ps.executeUpdate();
			
			this.pw=response.getWriter();
			if(result1>0&&result2>0&&result3>0&&result4>0) {
				this.pw.write("<script>"
						+ "alert('문의가 정상적으로 수정되었습니다.');"
						+ "location.href='./qalist.jsp';"
						+ "</script>");
			}
		}
		catch (Exception e) {
			System.out.println(e);
		}
		finally {
			try {
				this.pw.close();
				this.ps.close();
				this.con.close();
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		
		
	}

}

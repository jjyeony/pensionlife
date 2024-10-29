package pension;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
@MultipartConfig(
		fileSizeThreshold = 1024*1024*2,
		maxFileSize = 1024*1024*4,
		maxRequestSize = 1024*1024*10
)
public class qawriteok extends HttpServlet {
	PrintWriter pw=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String category=request.getParameter("qcategory");
		String name=request.getParameter("qname");
		String tel=request.getParameter("qtel");
		String email=request.getParameter("qemail");
		String title=request.getParameter("qtitle");
		String text=request.getParameter("qtext");
		
		Part file1=request.getPart("qfile1");
		String filename1=file1.getSubmittedFileName();
		long filesize1=file1.getSize();
		Part file2=request.getPart("qfile2");
		String filename2=file2.getSubmittedFileName();
		long filesize2=file2.getSize();
		String file1_db="";
		String file_rename1="";
		String file2_db="";
		String file_rename2="";
		
		String url=request.getServletContext().getRealPath("/upload/");
		file_rename re=new file_rename();		//파일 이름 변경 class로드		
		if(filename1!=""||filesize1>0) {
			file_rename1=re.rename(filename1);	
			file1_db="/upload/"+file_rename1;
			file1.write(url+file_rename1);			//web 디렉토리에 파일 저장
		}
		if(filename2!=""||filesize2>0) {	
			file_rename2=re.rename(filename2);
			file2_db="/upload/"+file_rename2;
			file2.write(url+file_rename2);			//web 디렉토리에 파일 저장
		}
		
		//qawrite에서 받은 data를 배열에 입력
		ArrayList<String> db_data=new ArrayList<String>();	
		db_data.add(category);
		db_data.add(name);
		db_data.add(tel);
		db_data.add(email);
		db_data.add(title);
		db_data.add(text);
		db_data.add(file1_db);
		db_data.add(filename1);
		db_data.add(file2_db);
		db_data.add(filename2);
		db_data.add("미답변");
		//qa table에 insert하여 db에 정보를 저장하는 class
		insert_qa in=new insert_qa();
		int result=in.qawrite(db_data);
		
		this.pw=response.getWriter();
		if(result>0) {
			this.pw.write("<script>alert('Q&A가 저장되었습니다.');"
					+ "location.href='./qalist.jsp';"
					+ "</script>");
		}
		else {
			this.pw.write("<script>alert('오류가 발생하였습니다.');</script>");
		}
		
		this.pw.close();
	}

}

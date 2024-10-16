package pension;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class search_id extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sb = new StringBuilder();
		response.setContentType("appliction/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String search_id = "";
		
		try (BufferedReader rd = request.getReader()){
			String line;
			while((line =rd.readLine()) != null) {
				sb.append(line);
			}
		} catch(Exception e) {
			System.out.println(e);
		}
		
		JSONParser parser = new JSONParser();
		JSONObject data;
		try {
			data = (JSONObject)parser.parse(sb.toString());
			db_pension db = new db_pension();
			String sql = "SELECT uid FROM user_info WHERE uname=? AND utel=? AND umail=?";
			try {
				PreparedStatement ps = db.getConnection().prepareStatement(sql);
				ps.setString(1, (String)data.get("name"));
				ps.setString(2, (String)data.get("tel"));
				ps.setString(3, (String)data.get("email"));
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
					search_id = rs.getString(1);					
				}
				if(search_id != null) {
					int leng = search_id.length();
					search_id = search_id.substring(0,leng/2);
					for(int i=0; i<(leng/2); i++) {
						search_id+="*";
					}
				}
				
				JSONObject res = new JSONObject();
				
				res.put("search_id", search_id);
				response.getWriter().write(res.toString());				
				rs.close();
				ps.close();
				db.getConnection().close();
				
			}  catch (Exception e) {
				e.printStackTrace();
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
	}

}

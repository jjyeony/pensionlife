package pension;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class search_pw extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sb = new StringBuilder();
		response.setContentType("appliction/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
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
			String sql = "UPDATE user_info SET upass=? WHERE uid=? AND uname=? AND utel=?";
			try {
				PreparedStatement ps = db.getConnection().prepareStatement(sql);
				ps.setString(1, (String)data.get("pw"));
				ps.setString(2, (String)data.get("id"));
				ps.setString(3, (String)data.get("name"));
				ps.setString(4, (String)data.get("tel"));
				
				int result = ps.executeUpdate();
				
				JSONObject res = new JSONObject();
				
				res.put("search_result", result);
				response.getWriter().write(res.toString());				
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

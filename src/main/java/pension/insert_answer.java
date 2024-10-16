package pension;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

public class insert_answer {
	db_pension db=new db_pension();
	Connection con=null;
	PreparedStatement ps=null;
	
	public int aswrite(ArrayList<String> data) {
		int result=0;
		String sql="insert into qa_answer values ('0',?,?,now())";
		try {
			this.con=this.db.getConnection();
		
			this.ps=this.con.prepareStatement(sql);
			this.ps.setString(1, data.get(0));
			this.ps.setString(2, data.get(1));
			
			result=this.ps.executeUpdate();
			
			if(result>0) {
				String sql2="update qa set qanswer='?‹µë³??™„ë£?' where qidx=?";
				this.ps=this.con.prepareStatement(sql2);
				this.ps.setString(1, data.get(0));
				int result2=this.ps.executeUpdate();
				
			}
		}
		catch(Exception e){
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
		return result;
	}
	
}

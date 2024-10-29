package pension;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
//qa table에 정보를 저장하는 class
public class insert_qa {
	db_pension db=new db_pension();
	Connection con=null;
	Statement st=null;
	public int qawrite(ArrayList<String> data) {
		int result=0;
		try {	
			this.con=this.db.getConnection();
			
			String sql="insert into qa(qidx,qcategory,qname,qtel,qmail,qtitle,qtext,qfile_url1,qfile_name1,qfile_url2,qfile_name2,qanswer,qindate) values "
					+"('0','"+data.get(0)+"','"+data.get(1)+"','"+data.get(2)+"','"+data.get(3)+"','"+data.get(4)+"','"+data.get(5)+"','"+data.get(6)+"','"+data.get(7)+"','"+data.get(8)+"','"+data.get(9)+"','"+data.get(10)+"',now())";
			this.st=this.con.createStatement();
			result=this.st.executeUpdate(sql);
		}
		catch (Exception e) {
			System.out.println("e1:"+e);
		}
		finally{
			try {
				this.st.close();
				this.con.close();
			}
			catch (Exception e) {
				System.out.println("e2:"+e);
			}
		}
		
		return result;
	}
}

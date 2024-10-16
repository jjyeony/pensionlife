package pension;


import java.sql.Connection;
import java.sql.DriverManager;

public class db_pension {

	public Connection getConnection() throws Exception{
		String dbinfo = "com.mysql.jdbc.Driver";
		String dburl = "jdbc:mysql://localhost:3306/ckk_402";
		String dbuser = "ckk_402";
		String dbpass = "404_ckk";
		
		Class.forName(dbinfo);
		Connection con = DriverManager.getConnection(dburl,dbuser,dbpass);
		
		return con;
	}
}

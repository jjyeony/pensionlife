package pension;

import java.text.SimpleDateFormat;
import java.util.Date;

public class file_rename {
	String filename="";
	public String rename(String nm) {
		filename=nm;
		int rnd=(int)Math.ceil(Math.random()*1500);
		SimpleDateFormat sf=new SimpleDateFormat("yyyyMMdd");
		Date day=new Date();
		String today=sf.format(day);
		int a=filename.lastIndexOf(".");
		String type=filename.substring(a+1);
		filename=today+rnd+"."+type;
		
		return filename;
	}
}

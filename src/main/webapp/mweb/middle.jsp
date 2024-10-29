<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./db_pension.jsp"%>
<%
PreparedStatement ps = null;
Statement st = null;
RequestDispatcher rd = null;
ResultSet rs = null;


String sql1 = "select * from pensionlist where ppension_name='[강원 평창군] 한화리조트 평창' order by pprice asc limit 0,1";
ps = dbcon.prepareStatement(sql1);
rs = ps.executeQuery();
String ppension_name1="";
String pprice1="";

while(rs.next()) {
ppension_name1=rs.getString("ppension_name");
pprice1=rs.getString("pprice");
}

String sql2 = "select * from pensionlist where ppension_name='[강원 평창군] 휘닉스 평창' order by pprice asc limit 0,1";
ps = dbcon.prepareStatement(sql2);
rs = ps.executeQuery();
String ppension_name2="";
String pprice2="";

while(rs.next()) {
ppension_name2=rs.getString("ppension_name");
pprice2=rs.getString("pprice");
}

String sql3 = "select * from pensionlist where ppension_name='[제주시] 한화리조트 제주' order by pprice asc limit 0,1";
ps = dbcon.prepareStatement(sql3);
rs = ps.executeQuery();
String ppension_name3="";
String pprice3="";

while(rs.next()) {
ppension_name3=rs.getString("ppension_name");
pprice3=rs.getString("pprice");
}

String sql4 = "select * from pensionlist where ppension_name='[제주시] 금호제주 리조트' order by pprice asc limit 0,1";
ps = dbcon.prepareStatement(sql4);
rs = ps.executeQuery();
String ppension_name4="";
String pprice4="";

while(rs.next()) {
ppension_name4=rs.getString("ppension_name");
pprice4=rs.getString("pprice");
}

String sql5 = "select * from pensionlist where ppension_name='[경남 거제시] 소노캄 거제' order by pprice asc limit 0,1";
ps = dbcon.prepareStatement(sql5);
rs = ps.executeQuery();
String ppension_name5="";
String pprice5="";

while(rs.next()) {
ppension_name5=rs.getString("ppension_name");
pprice5=rs.getString("pprice");
}

String sql6 = "select * from pensionlist where ppension_name='[충남 보령시] 보령베이스 리조트' order by pprice asc limit 0,1";
ps = dbcon.prepareStatement(sql6);
rs = ps.executeQuery();
String ppension_name6="";
String pprice6="";

while(rs.next()) {
ppension_name6=rs.getString("ppension_name");
pprice6=rs.getString("pprice");
}
%>
<section>

    <ol class="product">
        <li>
            <div onclick="reservation('<%=ppension_name1  %>')">
                <span><img src="./img/hotel_01.jpg"></span>
                <span><%=ppension_name1  %></span>
                <span><%=pprice1  %></span>
            </div>
        </li>
        <li>
            <div onclick="reservation('<%=ppension_name2 %>')">
                <span><img src="./img/hotel_02.jpg"></span>
                <span><%=ppension_name2  %></span>
                <span><%=pprice2  %></span>
            </div>
        </li>
        <li>
            <div onclick="reservation('<%=ppension_name3 %>')">
                <span><img src="./img/hotel_03.jpg"></span>
                <span><%=ppension_name3  %></span>
                <span><%=pprice3  %></span>
            </div>
        </li>
        <li>
            <div onclick="reservation('<%=ppension_name4 %>')">
                <span><img src="./img/hotel_04.jpg"></span>
                <span><%=ppension_name4  %></span>
                <span><%=pprice4  %></span>
            </div>
        </li>
        <li>
            <div onclick="reservation('<%=ppension_name5 %>')">
                <span><img src="./img/hotel_05.jpg"></span>
                <span><%=ppension_name5  %></span>
                <span><%=pprice5  %></span>
            </div>
        </li>
        <li>
            <div onclick="reservation('<%=ppension_name6 %>')">
                <span><img src="./img/hotel_06.jpg"></span>
                <span><%=ppension_name6  %></span>
                <span><%=pprice6  %></span>
            </div>
        </li>
    </ol>
<form id="frm">
<input type="hidden" name="hname">
</form>
</section>
<%
dbcon.close();
%>
<script>
function reservation(a){
	frm.hname.value=a;
	//console.log(frm.hname.value)
	frm.method="post";
	frm.action="./reservation.jsp";
	frm.submit();
}

</script>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./db_pension.jsp"%>
<%
String ad_id=request.getParameter("ad_id");
String sql="select * from qa where qanswer='미답변' order by qidx desc";
PreparedStatement ps=dbcon.prepareStatement(sql);
ResultSet rs=ps.executeQuery();

%>
<header class="admin_header"><img src="./img/header_logo.png"></header>
<aside class="admin_qa">
    <p><img src="./admin_img/logo.png"><span><%=ad_id %>님 환영합니다. <a href="javascript:void logout()">[로그아웃]</a></span></p>
</aside>
<article class="admin_lists">
    <p>QA 문의 게시판 리스트</p>
    <ul class="lists_uls color1">
        <li>제목</li>
        <li>글쓴이</li>
        <li>등록일</li>
    </ul>
    <!--qa 데이터 출력 리스트 부분 -->
	<%while(rs.next()){ %>
    <ul class="lists_uls" onclick="select_ad_qalist('<%=rs.getString("qidx") %>')">
        <li style="text-align: left;"><%String title=rs.getString("qtitle"); if(title.length()>14){String retitle=title.substring(0,15)+"..."; out.print(retitle);}else{out.print(title);} %></li>
        <li><%=rs.getString("qname") %></li>
        <li><%String date=rs.getString("qindate");  date=date.split(" ")[0]; out.print(date);%></li>
    </ul>
	<%} %>
    <!--qa 데이터 출력 리스트 부분 -->
</article>
<form id="frm_ad_qalist">
     <input type="hidden" name="ad_qalist_idx">
</form>
<script>
function select_ad_qalist(i){
	frm_ad_qalist.ad_qalist_idx.value=i;
	frm_ad_qalist.method="post";
	frm_ad_qalist.action="./admin_qawrite.jsp";
	frm_ad_qalist.submit();
}
function logout(){
	if(confirm("로그아웃 하시겠습니까?")){
		alert("로그아웃 되었습니다.");
		location.href="./admin_login.jsp";
	}
}
</script>
<%
rs.close();
ps.close();
dbcon.close();
%>
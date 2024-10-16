<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./db_pension.jsp"%>
<%
String idx=request.getParameter("ad_qalist_idx");

String sql="select * from qa where qidx="+idx;
PreparedStatement ps=dbcon.prepareStatement(sql);
ResultSet rs=ps.executeQuery();
%>
<article class="admin_lists">
    <p>QA 문의 내용</p>
    <ul class="qa_write">
    <%while(rs.next()){ %>
        <li>고객명</li>
        <li><%=rs.getString("qname") %></li>
        <li>제목</li>
        <li><%=rs.getString("qtitle") %></li>
        <li>내용</li>
        <li class="view1"><%=rs.getString("qtext") %></li>
        <li>등록일</li>
        <li><%String date=rs.getString("qindate");  date=date.split(" ")[0]; out.print(date);%></li>
        <%} %>
        <li>답변</li>
    <form id="frm_ad_qawrite">
        <input type="hidden" name="qidx" value="<%=idx%>">
        <li><textarea name="qa_answer" placeholder="답변내용을 입력하세요" class="answer"></textarea></li>
    </form>
    </ul>
    <input type="button" class="adbtn1" value="답변등록" onclick="answer_send()">
</article>
<script>
function answer_send(){
	frm_ad_qawrite.method="post";
	frm_ad_qawrite.action="admin_qawriteok.do";
	frm_ad_qawrite.submit();
}
</script>
<%
rs.close();
ps.close();
dbcon.close();
%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./db_pension.jsp"%>
<%
String usertel=(String)session.getAttribute("tel");

if(usertel==null){		
	out.print("<script>alert('로그인 하셔야 문의 게시판 이용이 가능합니다.'); location.href='./index.jsp';</script>");
}

String sql="select * from qa where qtel=? order by qidx desc";
PreparedStatement ps=dbcon.prepareStatement(sql);
ps.setString(1, usertel);
ResultSet rs=ps.executeQuery();

%>
<section class="subpage">
    <div class="member_agree">
        <p>1:1 문의게시판</p>
        <span class="sub_titles">질문하신 리스트가 출력 됩니다.</span>
        <ul class="qa_lists">
            <li>질문제목</li>
            <li>글쓴이</li>
            <li>등록일</li>
            <li>처리</li>
        </ul>
        <%while(rs.next()){ %>
        <ul class="qa_lists2" onclick="select_qalist('<%=rs.getString("qidx") %>')">
            <li><%String title=rs.getString("qtitle"); if(title.length()>14){String retitle=title.substring(0,15)+"..."; out.print(retitle);}else{out.print(title);} %></li> 
            <li><%=rs.getString("qname") %></li>
            <li><%String date=rs.getString("qindate");  date=date.split(" ")[0]; out.print(date);%></li>
            <li><%=rs.getString("qanswer") %></li>
        </ul>
        <%} %>
        <div class="member_agreebtn" onclick="qna()">문의하기</div>
        <form id="frm_qalist">
        <input type="hidden" name="qalist_idx">
        </form>
    </div>  
</section>
<script>
function qna(){
	location.href="./qawrite.jsp";
}
function select_qalist(i){
	frm_qalist.qalist_idx.value=i;
	frm_qalist.method="post";
	frm_qalist.action="./qaview.jsp";
	frm_qalist.submit();
}
</script>
<%
rs.close();
ps.close();
dbcon.close();
%>
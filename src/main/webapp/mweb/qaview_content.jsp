<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./db_pension.jsp"%>
<%
String idx=request.getParameter("qalist_idx");

String sql="select * from qa where qidx="+idx;
PreparedStatement ps=dbcon.prepareStatement(sql);
ResultSet rs=ps.executeQuery();


String sql2="select * from qa_answer where qidx="+idx;
ps=dbcon.prepareStatement(sql2);
ResultSet rs2=ps.executeQuery();

%>
<section class="subpage">
    <div class="member_agree">
        <p>1:1 문의게시판(내용확인)</p>
        <span class="sub_titles">빠르게 궁금한 사항을 답변 드리도록 하겠습니다.</span>
        <%while(rs.next()){ %>
        <ul class="write_ul">
            <li class="cate_txt">질문항목 : <%=rs.getString("qcategory") %></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("qname") %>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("qtel") %>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("qmail") %>" readonly></li>
            <li><input type="text" class="w_input1" value="<%=rs.getString("qtitle") %>" readonly></li>
            <li><textarea class="w_input2" readonly><%=rs.getString("qtext") %></textarea></li>
            <li class="fileview" id="file_view1">첨부파일 : <%=rs.getString("qfile_name1") %><input type="hidden" id="file1" value="<%=rs.getString("qfile_name1") %>"> </li>
            <li class="fileview" id="file_view2">첨부파일 : <%=rs.getString("qfile_name2") %><input type="hidden" id="file2" value="<%=rs.getString("qfile_name2") %>"> </li>
            <script>var answerok="<%=rs.getString("qanswer")%>"</script>
        </ul>
        <%} %>
        <!--관리자 답변사항-->
        <span class="admin_view" style="display: block;">관리자 답변내용</span>
        <ul class="answer_admin" style="display: block; min-height:50px">
        <%while(rs2.next()){ %>
            <li><%=rs2.getString("atext") %></li>
        <%} %>
        </ul>
        <!--관리자 답변사항-->
        <div class="member_agreebtn" id="qamodify_btn" onclick="go_qamodify('<%=idx%>')">문의수정</div>
        <div class="member_agreebtn" onclick="go_qalist('<%=idx%>')">문의 리스트</div>
    </div>  
    <form id="frm_qaview">
        <input type="hidden" name="qalist_idx">
     </form>
</section>
<script>
var file_view1=document.getElementById("file_view1");
var file_view2=document.getElementById("file_view2");
var file1=document.getElementById("file1");
var file2=document.getElementById("file2");

if(file1.value=="" || file1.value==" "){
	file_view1.style.display="none";
}
if(file2.value==""){
	file_view2.style.display="none";
}

if(answerok=="답변완료"){
	var modify_btn=document.getElementById("qamodify_btn");
	modify_btn.style.display="none";
}
function go_qalist(i){
	frm_qaview.qalist_idx.value=i;
	frm_qaview.method="post";
	frm_qaview.action="./qalist.jsp";
	frm_qaview.submit();
}
function go_qamodify(i){
	frm_qaview.qalist_idx.value=i;
	frm_qaview.method="post";
	frm_qaview.action="./qamodify.jsp";
	frm_qaview.submit();
}
</script>
<%
rs.close();
ps.close();
dbcon.close();
%>
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

%>
<section class="subpage">
    <div class="member_agree">
        <p>1:1 문의게시판(문의수정)</p>
        <span class="sub_titles">빠르게 궁금한 사항을 답변 드리도록 하겠습니다.</span>
       <form id="frm_modifyok" enctype="multipart/form-data">
        <input type="hidden" name="modify_idx">
        <input type="hidden" name="fileno">
        <%while(rs.next()){ %>
        <ul class="write_ul">
            <li class="cate_txt">질문항목 : <%=rs.getString("qcategory") %></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("qname") %>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("qtel") %>" readonly></li>
            <li><input type="text" class="w_input1 w_bg" value="<%=rs.getString("qmail") %>" readonly></li>
            <li><input type="text" class="w_input1" name="modify_title" value="<%=rs.getString("qtitle") %>"></li>
            <li><textarea class="w_input2" name="modify_text" ><%=rs.getString("qtext") %></textarea></li>
            <li class="fileview" id="file_btn1" >첨부파일 : <%=rs.getString("qfile_name1") %><span class="btn_del" onclick="filedelete('<%=rs.getString("qfile_url1")%>',this)" >삭제</span></li>
        	<input type="hidden" id="file_hd1" value="<%=rs.getString("qfile_name1") %>">
        	<li class="fileview" id="file_btn2" value="<%=rs.getString("qfile_name2") %>">첨부파일 : <%=rs.getString("qfile_name2") %><span class="btn_del" onclick="filedelete('<%=rs.getString("qfile_url2")%>',this)" >삭제</span></li>
            <input type="hidden" id="file_hd2" value="<%=rs.getString("qfile_name2") %>">
            <li class="fileview" id="file_add" style="display: none;"><input type="file" name="modify_file" class="w_li"> * 최대 2MB까지 가능</li>
            <li>※ 첨부파일은 이미지만 등록 가능합니다.</li>
        </ul>
        <script>
        var file_url1="<%=rs.getString("qfile_url1")%>";
        var file_url2="<%=rs.getString("qfile_url2")%>";
        </script>
        <%} %>
        </form>
        <div class="member_agreebtn" onclick="qamodify('<%=idx%>')">문의수정</div>
        <div class="member_agreebtn" onclick="qadelete('<%=idx%>')" style="background-color: darkblue; color:white;">문의삭제</div>
    </div>  
    <form id="frm_qamodify">
    <input type="hidden" name="modify_idx">
    <input type="hidden" name="file_del1">
    <input type="hidden" name="file_del2">
    </form>
    </section>
<script>
var file1=document.getElementById("file_btn1");
var file_hd1=document.getElementById("file_hd1");
var file2=document.getElementById("file_btn2");
var file_hd2=document.getElementById("file_hd2");
var file_add=document.getElementById("file_add");
var fileno="";

if(file_hd1.value=="" || file_hd1.value==" "){
	file1.style.display="none";
	file_add.style.display="block";
	
	if(file_hd2.value=="" || file_hd2.value==null){
		file2.style.display="none";
		file_add.style.display="block";
	}
	fileno="1";
}
else if(file_hd2.value=="" || file_hd2.value==null){
	file2.style.display="none";
	file_add.style.display="block";
	fileno="2";
}

function qamodify(i){
	var f=document.getElementsByName("modify_file");
	frm_modifyok.modify_idx.value=i;
	frm_modifyok.fileno.value=fileno;
	frm_modifyok.method="post";
	frm_modifyok.action="./qamodifyok.do";
	if(frm_modifyok.modify_title.value==""){
		alert("제목을 입력하셔야 합니다.");
	}
	else if(frm_modifyok.modify_text.value==""){
		alert("내용을 입력하셔야 합니다.");
	}
	else if(f[0].value!=""){
			if(f[0].files[0].size>2097152){
				alert("파일은 2MB이하만 첨부 가능합니다.");
			}
			else if(f[0].files[0].type.indexOf("image")==-1){
				alert("파일은 이미지만 첨부 가능합니다.");
			}
			else{
				frm_modifyok.submit();
			}
	}
	else{
		frm_modifyok.submit();
	}
}
function qadelete(i){
	frm_qamodify.file_del1.value=file_url1;
	frm_qamodify.file_del2.value=file_url2;
	frm_qamodify.modify_idx.value=i;
	frm_qamodify.method="post";
	frm_qamodify.action="./qadeleteok.do";
	frm_qamodify.submit();
}
var a;
function filedelete(i,t){
	if(confirm("첨부 파일을 삭제하시겠습니까?")){
		var fileinfo=i+"@"+t.parentNode.id+"@"+<%=idx%>;
		var http, result;
		http=new XMLHttpRequest();
		http.onreadystatechange=function(){
			if(http.readyState==4&&http.status==200){
				console.log(this.response);
			}
		}
		http.open("post","./file_delete.do",true);
		http.setRequestHeader("content-type","application/x-www-form-urlencoded");
		http.send("fileinfo="+fileinfo);
		
		
		t.parentNode.style.display="none";	//파일 삭제시 element 삭제
		t.parentNode.value="";
		file_add.style.display="block";		//파일 삭제시 파일 추가 버튼 생성
	}
}
</script>
<%
rs.close();
ps.close();
dbcon.close();
%>
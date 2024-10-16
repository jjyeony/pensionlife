<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./db_pension.jsp"%>
<%
String usertel=(String)session.getAttribute("tel");
String sql="select * from user_info where utel=?";
PreparedStatement ps=dbcon.prepareStatement(sql);
ps.setString(1, usertel);
ResultSet rs=ps.executeQuery();

%>
<section class="subpage">
    <div class="member_agree">
        <p>1:1 문의게시판(글쓰기)</p>
        <span class="sub_titles">문의 유형 선택</span>
    <form id="frm_qawrite" enctype="multipart/form-data">
        <input type="hidden" name="qcategory">
        <ol class="qa_part"> 
            <li value="이용문의">이용문의</li>
            <li value="예약 및 취소">예약 및 취소</li>
            <li value="환불 및 요금">환불 및 요금</li>
            <li value="시설 문의">시설문의</li>
            <li value="이벤트 문의">이벤트 문의</li>
            <li value="기타문의">기타문의</li>
        </ol>
        <%while(rs.next()){ %>
        <ul class="write_ul">
            <li><input type="text" name="qname" class="w_input1 w_bg" value="<%=rs.getString("uname") %>" readonly></li>
            <li><input type="text" name="qtel" class="w_input1 w_bg" value="<%=usertel %>" readonly></li>
            <li><input type="text" name="qemail" class="w_input1 w_bg" value="<%=rs.getString("umail") %>" readonly></li>
            <li><input type="text" name="qtitle" class="w_input1" placeholder="질문 제목"></li>
            <li><textarea name="qtext" class="w_input2" placeholder="질문 내용"></textarea></li>
            <li><input type="file"  name="qfile1" class="w_li"> * 최대 2MB까지 가능</li>
            <li><input type="file" name="qfile2" class="w_li"> * 최대 2MB까지 가능</li>
            <li>※ 첨부파일은 이미지만 등록 가능합니다.</li>
        </ul>
        <%} %>
        <div class="member_agreebtn" onclick="qa_send()">문의등록</div>
    </div>  
    </form>
</section>
<script>
function qa_send(){
	var f1=document.getElementsByName("qfile1");
	var f2=document.getElementsByName("qfile2");
	var fileok1="";
	var fileok2="";
	
	frm_qawrite.method="post";
	frm_qawrite.action="./qawriteok.do";
	
	if(document.querySelector(".onselect") === null){
		alert("문의 유형을 선택하셔야합니다.");
	}
	else if(document.querySelector(".onselect") != null){
		var cate=document.getElementsByName("qcategory");
		var c=document.querySelector(".onselect").innerText;
		cate[0].value=c;			//hidden 태그에 선택된 문의 유형 값 이관
		
		if(frm_qawrite.qtitle.value==""){
			alert("제목을 입력하셔야 합니다.");
		}
		else if(frm_qawrite.qtext.value==""){
			alert("내용을 입력하셔야 문의가 진행됩니다.");
		}
		else if(f1[0].value!=""){
			if(f1[0].files[0].size>2097152){
				alert("파일은 2MB이하만 첨부 가능합니다.");
			}
			else if(f1[0].files[0].type.indexOf("image")==-1){
				alert("파일은 이미지만 첨부 가능합니다.");
			}
			else if(f2[0].value!=""){
				if(f2[0].files[0].size>2097152){
					alert("파일은 2MB이하만 첨부 가능합니다.");
				}
				else if(f2[0].files[0].type.indexOf("image")==-1){
					alert("파일은 이미지만 첨부 가능합니다.");
				}
				else{
					frm_qawrite.submit();
				}
			}
			else{
				frm_qawrite.submit();
			}
		}
		else if(f2[0].value!=""){
			if(f2[0].files[0].size>2097152){
				alert("파일은 2MB이하만 첨부 가능합니다.");
			}
			else if(f2[0].files[0].type.indexOf("image")==-1){
				alert("파일은 이미지만 첨부 가능합니다.");
			}
			else{
				frm_qawrite.submit();
			}
		}
		else{
			frm_qawrite.submit();
		}
		
	}
	
}
</script>
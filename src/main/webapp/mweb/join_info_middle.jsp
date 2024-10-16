<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	HttpSession se = request.getSession(false);
	if(se != null){
		HashMap<String, String> arguments = (HashMap<String,String>)se.getAttribute("arguments");
		if(arguments != null){
%>			
			

<section class="subpage">
    <div class="member_agree">
<% 
			for(String key : arguments.keySet()){
				String value = arguments.get(key);
%>
	
	<input type="hidden" class="ckboxes" name="<%=key %>" value="<%=value %>">
<%
			}
		}
		session.invalidate();
%>    
    <p>회원 기본 정보입력</p>
    <ol class="join_ol">
    <li><input type="text" class="join_input1" name="id" placeholder="아이디 (영문/숫자 6~16자리)" maxlength="16" autocomplete="off"></li>
    <li><input type="text" class="join_input1" name="user_name" placeholder="이름 (홍길동)" maxlength="10" autocomplete="off"></li>
    <li><input type="password" class="join_input1" name="pw" placeholder="비밀번호 (영문/숫자 6~12자리)" maxlength="12" autocomplete="off"></li>
    <li><input type="password" class="join_input1" name="pw_ok" placeholder="동일한 패스워드를 입력하세요" maxlength="12" autocomplete="off"></li>
    <li><input type="email" class="join_input1" name="email" placeholder="이메일을 입력하세요" maxlength="35" autocomplete="off"></li>
    <li><input type="tel" class="join_input1" name="tel" placeholder="연락처 ('-'는 미입력)" maxlength="11" autocomplete="off"></li>
    <li class="security">
    보안코드 : <input type="text" class="join_input2 bgcolor" maxlength="6" readonly="readonly">
    <input type="number" class="join_input2" placeholder="보안코드 6자리 입력" maxlength="6" autocomplete="off">
    </li>
    </ol>
    <div class="member_agreebtn">회원가입</div>
    </div>
</section>
<%				
	}else {
%>
		<script>
			alert("시간이 경과되었습니다.");
			location.href = "./index.jsp"
		</script>		
<%	
	}
%>
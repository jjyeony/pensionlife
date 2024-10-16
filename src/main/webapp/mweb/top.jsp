<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session = request.getSession();
	String id = "";
	String login_check = "";
	String tel = "";
	if(session != null){
		id=(String)session.getAttribute("id");
		login_check=(String)session.getAttribute("login_check");
		tel=(String)session.getAttribute("tel");
	}
%>    
<div class="menus_bar" id="menus_bar">
    <div class="load_menus" id="load_menus">
        <ul>
            <li onclick="go_reservation_ck()">팬션 예약확인</li>
            <li >팬션 예약취소</li>
            <li onclick="go_qalist()">1:1문의 게시판</li>
        </ul>
    </div>
</div>
<header>
<ul class="top_menu">
    <li id="menu_slide"><img src="./img/menu.svg"></li>
    <li id="pop"><img src="./img/header_logo.png"></li>
<%
if(id == null) {
%>    
    <li onclick="login_pop();"><img src="./img/login.svg"></li>
<%
} else {
%>
	<li><%=id %>님<%if(login_check != null){ %><a href="javascript:void remove_lo_ck()">[자동로그인 해제]</a><%} %><a href="./logout.jsp">[로그아웃]</a></li>
<%
}
%>
</ul>
</header>

<aside class="popup" id="popup" style="display:none;">
	<div class="login">
		<span class="close" onclick="pop_close();">X</span>
		<p>MEMBER-LOGIN</p>
		<ol>
		<li><input type="text" name="id" class="login_input" placeholder="아이디를 입력하세요" autocomplete="off" ></li>
		<li><input type="password" name="pw" class="login_input" placeholder="패스워드를 입력하세요" autocomplete="off"></li>
		<li><label><input type="checkbox" name="login_check" class="login_check"> 자동로그인</label></li>
		<li><input type="submit" value="로그인" class="login_btn"></li>
		<li class="login_info">
		<span onclick="page_location(1)">아이디 찾기</span>
		<span onclick="page_location(2)">회원가입</span>	
		</li>
		</ol>
	</div>
</aside>

<script>
let storage_login_ck = localStorage.getItem("storage_login_ck");
var pop=document.getElementById("pop");

function remove_lo_ck(){
	<%session.removeAttribute("login_check");%>
	localStorage.removeItem("storage_login_ck");
	location.reload();
}

function go_qalist(){
	location.href="./qalist.jsp";
}

const pop_click = () =>{
	location.href="./index.jsp";
};

pop.addEventListener("click",pop_click);

function go_reservation_ck(){
	location.href = "./reservation_check.jsp";
}
</script>

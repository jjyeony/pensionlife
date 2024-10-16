<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="./css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="./admin_css/index.css?v=4">
    <script src="./js/jquery.js"></script>
</head>
<body>
<header class="admin_header"><img src="./img/header_logo.png"></header>
<aside class="admin_login">
    <p><img src="./admin_img/logo.png"><span>ADMINISTRATOR</span></p>
    <form id="frm_adlogin">
    <ol class="admin_part">
        <li><input type="text" class="adin1" name="ad_id" placeholder="아이디를 입력하세요"></li>
        <li><input type="password" class="adin1" name="ad_pass" placeholder="패스워드를 입력하세요"></li>
        <li><input type="button" class="adbtn1" value="LOGIN" onclick="logins()"></li>
    </ol>
    </form>
</aside>
<%@include file="./footer.jsp"%>
</body>
</html>
<script>
function logins(){

	if(frm_adlogin.ad_id.value==""){
		alert("아이디를 입력하세요");
	}
	else if(frm_adlogin.ad_pass.value==""){
		alert("패스워드를 입력하세요");
	}
	else if(frm_adlogin.ad_id.value=="admin"||frm_adlogin.ad_pass.value=="a1004"){
		alert("로그인 되었습니다.");
		frm_adlogin.method="post";
		frm_adlogin.action="./admin_qalist.jsp";
		frm_adlogin.submit();
	}
	else{
		alert("아이디 및 패스워드를 확인하세요.");
	}
}
</script>
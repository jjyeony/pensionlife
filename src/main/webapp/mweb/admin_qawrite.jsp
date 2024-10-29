<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="./css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="./admin_css/index.css?v=6">
    <script src="./js/jquery.js"></script>
</head>
<body>
<header class="admin_header"><img src="./img/header_logo.png"></header>
<aside class="admin_qa">
    <p><img src="./admin_img/logo.png"><span>admin님 환영합니다. <a href="javascript:void logout()">[로그아웃]</a></span></p>
</aside>
<%@ include file="./admin_qawrite_content.jsp"%>
<%@ include file="./footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="./css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="./css/m_sub.css?v=2">
    <link rel="stylesheet" type="text/css" href="./css/m_qaboard.css?v=2">
    <script src="./js/jquery.js"></script>
    <script src="./js/m_index.js"></script>
</head>
<body>
    <div class="menus_bar" id="menus_bar">
        <div class="load_menus" id="load_menus">
            <ul>
                <li>팬션 예약확인</li>
                <li>팬션 예약취소</li>
                <li>1:1문의 게시판</li>
            </ul>
        </div>
    </div>    
<!-- 상단 시작 -->
<%@include file="./top.jsp" %>
<!-- 상단 끝 -->
<main>
<!-- 배너 -->
<section>
    <img src="./img/title_Resort.jpg">
</section>
<!-- 배너 끝-->
<!-- 중단 -->
<%@include file="./qamodify_content.jsp" %>
<!-- 하단 시작 -->
<%@include file="./bottom.jsp" %>
</main>
<%@include file="./footer.jsp"%>
</body>
</html>
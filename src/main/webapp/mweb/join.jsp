<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>호텔 & 펜션 예약시스템</title>
    <link rel="stylesheet" type="text/css" href="./css/m_index.css?v=1">
    <link rel="stylesheet" type="text/css" href="./css/m_sub.css?v=1">
    <script src="./js/jquery.js"></script>
    <script src="./js/m_index.js"></script>
    <script>
	  //  document.addEventListener("DOMContentLoaded", function(){
	    //	const se ="<%--=session--%>";
	    //	if(se != null){
	    //		location.href="index.jsp";
	    //	}
	   // });
    </script>
</head>
<body>
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
<%@include file="./join_agree.jsp" %>
<!-- 하단 시작 -->
<%@include file="./bottom.jsp" %>
</main>
<%@include file="./footer.jsp"%>
</body>
<script src="./js/agree.js?v=2"></script>
</html>
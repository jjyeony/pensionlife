<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="./db_pension.jsp" %>
<%
PreparedStatement ps = null;
ResultSet rs = null;
String user_id = (String) session.getAttribute("id");
String sql = "select * from reservation where ruser_id = ?";
ps = dbcon.prepareStatement(sql);
ps.setString(1, user_id);
rs = ps.executeQuery();

// ResultSet에 데이터가 있는지 먼저 확인
if(user_id == null)
{
	%>
	<script>alert("로그인이 필요합니다.");location.href="index.jsp";</script>
	<%
} else {
if (rs.next()) {
    // 데이터가 있을 경우 변수 초기화
    String rpension_name = rs.getString("rpension_name") != null ? rs.getString("rpension_name") : "정보 없음";
    String rroom = rs.getString("rroom") != null ? rs.getString("rroom") : "정보 없음";
    String rdatechoice = rs.getString("rdatechoice") != null ? rs.getString("rdatechoice") : "정보 없음";
    String rroom_info = rs.getString("rroom_info") != null ? rs.getString("rroom_info") : "정보 없음";
    String rmember = rs.getString("rmember") != null ? rs.getString("rmember") : "정보 없음";
    String radd_member = rs.getString("radd_member") != null ? rs.getString("radd_member") : "정보 없음";
    String rprice = rs.getString("rprice") != null ? rs.getString("rprice") : "정보 없음";
    String ruser_name = rs.getString("ruser_name") != null ? rs.getString("ruser_name") : "정보 없음";
    String ruser_hp = rs.getString("ruser_hp") != null ? rs.getString("ruser_hp") : "정보 없음";
    String ruser_member = rs.getString("ruser_member") != null ? rs.getString("ruser_member") : "정보 없음";
    String ruser_email = rs.getString("ruser_email") != null ? rs.getString("ruser_email") : "정보 없음";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 확인 시스템</title>
    <link rel="stylesheet" type="text/css" href="./css/m_index.css?v=2">
    <link rel="stylesheet" type="text/css" href="./css/m_sub.css?v=1">
    <link rel="stylesheet" type="text/css" href="./css/m_reservation.css?v=1">
    <script src="./js/jquery.js"></script>
    <script src="./js/m_index.js"></script>
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
<section class="subpage">
    <div class="member_agree">
    <p>펜션 예약확인</p>
    <ol class="reser_ol">
    <li>
    <span class="reser_part1">펜션명</span>
    <span class="reser_part2" ><%=rpension_name %></span>
    </li>
    <li>
    <span class="reser_part1">객실선택</span>
    <span class="reser_part2"><%=rroom %></span>
    </li>
    <li>
    <span class="reser_part1">일자선택</span>
    <span class="reser_part2"><%=rdatechoice %></span>
    </li>
    <li>
    <span class="reser_part1">객실구조</span>
    <span class="reser_part2"><%=rroom_info %></span>
    </li>
    <li>
    <span class="reser_part1">입실인원</span>
    <span class="reser_part2"><%=rmember %></span>
    </li>
    <li>
    <span class="reser_part1">추가인원</span>
    <span class="reser_part2"><%=radd_member %></span>
    </li>
    <li>
    <span class="reser_part1">구매금액</span>
    <span class="reser_part2"><%=rprice %></span>
    </li>
   </ol>
    <p>예약자정보 입력</p>
        <ol class="reser_ol">
    <li>
    <span class="reser_part1">객실선택</span>
    <span class="reser_part2"><%=rpension_name %></span>
    </li>
    <li>
    <li>
    <span class="reser_part1">예약자명</span>
    <span class="reser_part2"><%=ruser_name %></span>
    </li>
    <li>
    <span class="reser_part1">휴대폰</span>
    <span class="reser_part2"><%=ruser_hp %></span>
    </li>
    <li>
    <span class="reser_part1">입실인원</span>
    <span class="reser_part2"><%=ruser_member %></span>
    </li>
    <li>
    <span class="reser_part1">이메일</span>
    <span class="reser_part2"><%=ruser_email %></span>
    </li>
    </ol>
    <div type="button" class="member_agreebtn" onclick="reservation()">예약취소</div>
    </div>
</section>
<!-- 하단 시작 -->
<%@include file="./bottom.jsp" %>
</main>
<%@include file="./footer.jsp" %>
</body>
</html>
<%
} else {
    // 예약 내역이 없을 경우 처리
    %>
    <script>alert("예약 내역이 없습니다.");location.href="index.jsp";</script>
    <%
}
}
rs.close();
ps.close();
dbcon.close();
%>

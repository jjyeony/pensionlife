<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	HttpSession hs = request.getSession();
	hs.invalidate(); // 모든 세션을 초기화
%>

<script>
alert('정상적으로 로그아웃 되셨습니다.');
location.href='./index.jsp';
</script>
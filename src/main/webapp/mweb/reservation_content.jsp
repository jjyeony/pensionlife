<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./db_pension.jsp"%>
<%
PreparedStatement ps = null;
ResultSet rs = null;
ResultSet rs2 = null;

response.setContentType("text/html; charset=utf-8");
request.setCharacterEncoding("utf-8");

String pension = request.getParameter("hname");
String r_room = null;
String r_room_dtc = null; //각 방별 상세 정보
String pidx = request.getParameter("pidx");

String ruser_id = (String) session.getAttribute("id"); //세션값
//String ruser_id = "tester";

if (pidx == null) {
	r_room = "select * from pensionlist where ppension_name='" + pension + "'";
} else {
	r_room_dtc = "select * from pensionlist where pidx='" + pidx + "'";
	ps = dbcon.prepareStatement(r_room_dtc);
	rs = ps.executeQuery();
	rs.next();
	pension = rs.getString("ppension_name");
	r_room = "select * from pensionlist where ppension_name='" + pension + "'";
}

ps = dbcon.prepareStatement(r_room);
rs2 = ps.executeQuery();
rs2.next();
%>
<section class="subpage">
	<form id="frm">
		<input type="hidden" name="idx" value=<%=pidx%>> <input
			type="hidden" name="ruser_id" value=<%=ruser_id%>>
		<div class="member_agree">
			<p>펜션 예약하기</p>
			<ol class="reser_ol">
				<li><span class="reser_part1">펜션명</span> <input type="hidden"
					name="rpension_name" value="<%=pension%>"> <span
					class="reser_part2"> <%=pension%>
				</span></li>
				<li><span class="reser_part1">객실선택</span> <span
					class="reser_part2"> <%
 if (pidx != null) {
 %> <input type="hidden"
						value="<%=rs.getString("proom_name")%>" name="rroom"> <%
 }
 %>
						<select onchange="roomchoice(this.value)" class="reser_select"
						name="rroomch">
							<option value="">객실선택</option>
							<%
							while (rs2.next()) {
							%>
							<option value="<%=rs2.getString("pidx")%>"><%=rs2.getString("proom_name")%></option>
							<%
							}
							%>
					</select>
				</span></li>
				<li><span class="reser_part1">일자선택</span> <span
					class="reser_part2"> <input type="date" class="reser_input"
						name="rdate">
				</span></li>
				<li>
					<%
					if (pidx == null) {
					%> <span class="reser_part1">객실구조</span> <span class="reser_part2"
					id="rinfo" name="rinfo"></span>
				</li>
				<li><span class="reser_part1">입실인원</span> <span
					class="reser_part2" name="rcount"> </span></li>
				<li><span class="reser_part1">추가인원</span> <span
					class="reser_part2"> 기준인원 초과시 추가요금이 발생합니다. </span></li>
				<li><span class="reser_part1">구매금액</span> <span
					class="reser_part2" name="rprice"> </span> <%
 } else {
 %> <span class="reser_part1">객실구조</span> <input type="hidden"
					name="rinfo" value="<%=rs.getString("proom_info")%>"> <span
					class="reser_part2"><%=rs.getString("proom_info")%></span></li>
				<li><span class="reser_part1">입실인원</span> <input type="hidden"
					name="rcount" value="<%=rs.getString("pcount")%>"> <span
					class="reser_part2">기준<%=rs.getString("pcount")%>인 / 최대 <%=rs.getString("pmax_count")%>인
				</span></li>
				<li><span class="reser_part1">추가인원</span> <input type="hidden"
					name="radd_member" value="<%=rs.getString("pmax_count")%>">
					<span class="reser_part2"> 기준인원 초과시 추가요금이 발생합니다. </span></li>
				<li><span class="reser_part1">구매금액</span> <input type="hidden"
					name="rprice" value="<%=rs.getString("pprice")%>"> <span
					class="reser_part2"> <%=rs.getString("pprice")%>
				</span> <%
 rs.close();
 }
 rs2.close();
 ps.close();
 dbcon.close();
 %></li>
			</ol>
			<p>예약자정보 입력</p>
			<ol class="reser_ol">
				<li><span class="reser_part1">예약자명</span> <span
					class="reser_part2"> <input type="text" name="rname"
						class="reser_input" maxlength="30">
				</span></li>
				<li><span class="reser_part1">휴대폰</span> <span
					class="reser_part2"> <input type="number" name="rhp"
						class="reser_input" maxlength="11">
				</span></li>
				<li><span class="reser_part1">입실인원</span> <span
					class="reser_part2"> <select class="reser_select"
						name="rcount">
							<option value="">입실 인원선택</option>
							<option>1인</option>
							<option>2인</option>
							<option>3인</option>
							<option>4인</option>
							<option>5인</option>
					</select>
				</span></li>
				<li><span class="reser_part1" name="ruser_email">이메일</span> <span
					class="reser_part2"> <input type="email" name="remail"
						class="reser_input" maxlength="50">
				</span></li>
			</ol>
			<div type="button" class="member_agreebtn" onclick="reservation()">예약하기</div>
		</div>
	</form>
</section>
<script>
	var w = 1;
	while (w < frm.rroomch.children.length) {
		if (frm.rroomch.children[w].value == frm.idx.value) {
			frm.rroomch.children[w].selected = true;
		}
		w++;
	}
	console.log(frm.rroomch);
	function roomchoice(rc) {
		if (frm.rroomch.children[0].selected != true) {
			location.href = './reservation.jsp?pidx=' + rc;
		}
	}

	function reservation() {
		//console.log(frm.rdate.value);
		if (frm.rroomch.children[0].selected == true) {
			alert("객실을 선택해주세요.");
		} else if (frm.rdate.value == "") {
			alert("날짜를 입력해주세요.");
		} else if (frm.rname.value == "") {
			alert("예약자명을 입력해주세요.");
		} else if (frm.rhp.value == "") {
			alert("휴대폰 번호를 입력해주세요.");
		} else if (document.querySelectorAll(".reser_select")[1].children[0].selected) {
			alert("인원을 선택해주세요.");
		} else if (frm.remail.value == "") {
			alert("이메일을 입력해주세요.");
		} else {
			frm.method = "post";
			frm.action = "./reservation.do"
			frm.submit();
		}
	}
</script>
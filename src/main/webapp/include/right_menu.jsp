<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table class="table_aside">

		<%
		if( session.getAttribute("userid") == null ) {
		%>
	<tr>
		<th colspan="2" class="th_login_aside"><a href="../member/loginWrite.jsp">LOGIN</a></th>
	</tr>
		<%
		} else {
		%>
	<tr>
		<th colspan="2" class="th_login_aside"><a href="../member/logOut.jsp">LOGOUT</a></th>
	</tr>	
		<%
		}
		%>

		<%
		if( session.getAttribute("userid") == null ) {
		%>
	<tr>
		<th colspan="2" class="th_aside"><a href="../member/loginWrite.jsp">게임등록</a></th>
	</tr>
		<%
		} else {
		%>
	<tr>
		<th colspan="2" class="th_aside"><a href="../member/gameidWrite.jsp">게임등록</a></th>
	</tr>
		<%
		}
		%>
		
		<%
		if( session.getAttribute("userid") == null ) {
		%>
	<tr>
		<th class="th_aside"><a href="../member/loginWrite.jsp">캐쉬<br>충전</a></th>
		<th class="th_aside"><a href="../member/loginWrite.jsp">마일<br>리지</a></th>
	</tr>
		<%
		} else {
		%>		
	<tr>
		<th class="th_aside"><a href="../mypage/mypage.jsp">캐쉬<br>충전</a></th>
		<th class="th_aside"><a href="../mypage/mileage.jsp">마일<br>리지</a></th>
	</tr>
		<%
		}
		%>
		
		<%
		if( session.getAttribute("userid") == null ) {
		%>
	<tr>
		<th class="th_aside"><a href="../member/loginWrite.jsp">채팅</a></th>
		<th class="th_aside"><a href="../member/loginWrite.jsp">찜한<br>물품</a></th>
	</tr>
		<%
		} else {
		%>		
	<tr>
		<th class="th_aside"><a href="../chat/chat.jsp">채팅</a></th>
		<th class="th_aside"><a href="../market/marketList_company.jsp">찜한<br>물품</a></th>
	</tr>
		<%
		}
		%>
	
		<%
		if( session.getAttribute("userid") == null ) {
		%>
	<tr>
		<th class="th_aside"><a href="../member/loginWrite.jsp">고객<br>센터</a></th>
		<th class="th_aside"><a href="../member/loginWrite.jsp">마이<br>페이지</a></th>
	</tr>
		<%
		} else {
		%>
	<tr>
		<th class="th_aside"><a href="../service/CustomerService.jsp">고객<br>센터</a></th>
		<th class="th_aside"><a href="../mypage/mypage.jsp">마이<br>페이지</a></th>
	</tr>
		<%
		}
		%>
</table>
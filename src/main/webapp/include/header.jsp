<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="../css/mypage.css">
<div class="div_header">
	<ul class="ul_header">
	
	<%
	if( session.getAttribute("userid") == null ) {
	%>
		<li class="li_header" ><a href="../member/loginWrite.jsp">로그인</a></li>
	<%
	} else {
	%>	
		<li class="li_header"><a href="../member/logOut.jsp">로그아웃</a></li>		
	<%
	}
	%>
	
	<%
	if( session.getAttribute("userid") == null ) {
	%>
		<li class="li_header"><a href="../member/memberWrite.jsp">회원가입</a></li>
	<%
	} else {
	%>		
		<li class="li_header"><a href="../mypage/mypage.jsp">마이페이지</a></li>
	<%
	}
	%>	
	
	<%
	if( session.getAttribute("userid") == null ) {
	%>
		<li class="li_header" ><a href="../member/loginWrite.jsp">고객센터</a></li>
	<%
	} else {
	%>	
		<li class="li_header" style="border:none;"><a href="../service/CustomerService.jsp">고객센터</a></li>
	<%
	}
	%>	
	</ul>
</div>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="conn.ConOracle" %>
<%@ include file="../include/dbcon.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 아이디 등록</title>
	<link rel="stylesheet" href="../css/login.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="../include/main.jsp">
	<link rel="stylesheet" href="../css/gameid.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	
<script>

if((navigator.userAgent).indexOf("Chrome")>-1){
	   document.write("<link rel='stylesheet' href='../css/aside_chrome.css'>");
	}
	else{
	   document.write("<link rel='stylesheet' href='../css/aside_ie.css'>");
	}
	
$(function(){
	
		$("body").css("width",screen.width-30);
});
</script>

<%
String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");
String email = request.getParameter("email");

String sql = " SELECT COUNT(*) FROM MEMBER "
			+ " WHERE userid='"+userid+"' "
			+ " AND userpw='"+userpw+"' "
			+ " AND email='"+email+"' ";
ResultSet count = stmt.executeQuery(sql);
count.next();
%>
<script>

function fn_test(){
	alert("test");
	
	return false; 
}
</script>

<script>
function fn_submit(){
	
	var f = document.frm;
	
	if( document.frm.userid.value == "" ) {
		alert("아이디를 입력해주세요.");
		f.userid.focus();
		return false;
	}
	if( document.frm.userpw.value == "" ) {
		alert("비밀번호 입력해주세요.");
		f.userpw.focus();
		return false;
	}
	if( document.frm.email.value == "" ) {
		alert("이메일을 입력해주세요.");
		f.email.focus();
		return false;
	}
	document.frm.submit();	
}
</script>

</head>
<body>

<header>
	<%@ include file="../include/header.jsp" %>
</header>
<nav>
	<%@ include file="../include/nav.jsp" %>
</nav>	

<section>
	<article>	
			<div class="format">
				<form name="frm" method="post" action="gameidWriteSave.jsp" onsubmit="return true;">	
					<table>
						<tr>
							<td class="type">아이디 (ID)</td>
							<td><input type="text" name="userid"/></td>
						</tr>
						<tr>
							<td class="type">비밀번호</td>
							<td><input type="password" name="userpw"/></td>
						</tr>
						<tr>
							<td class="type">이메일 (E-MAIL)</td>
							<td><input type="email" name="email"/></td>
						</tr>
							<tr>
							<td class="type">등록할 게임아이디</td>
							<td>
							<input type="text" name="game_name" placeholder=게임명>
							<input type="text" name="game_id" placeholder="게임아이디를 입력해주세요.">
							</td>
						<tr>
							<td class="type">휴대폰번호 인증</td>
							<td><button><a href="https://www.niceid.co.kr/resources/images/prod/img_mobi_slider1-1.jpg" onclick="window.open(this.href, '_blank', 'width=500px, height=700px, toolbars = no, scrollbars=no'); return false;">인증</a></button></td>
						</tr>	
						
						
					</table>
						<div class="button">
							<div></div>
							<div class="button__submit">
								<input type="submit" value="등록완료"/>
								<input type="reset" value="취소"/>			
							</div>
							<div></div>
						</div>
	   			</form>
			</div>
	</article>
	<aside>
		<%@ include file="../include/right_menu.jsp" %>
	</aside>
</section>

<footer>
	<%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>
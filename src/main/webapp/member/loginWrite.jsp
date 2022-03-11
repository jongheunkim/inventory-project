<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/dbcon.jsp" %>    
       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
	<link rel="stylesheet" href="../css/login.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="../include/main.jsp">
	
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

function fn_reset() {
	location="../main/main.jsp";
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
		<div class="first_row">
			<div></div>
			<div>
				<h1>로그인</h1>
				<span>다양한 서비스를 이용하시려면 로그인이 필요합니다.</span><br><br>
			</div>
		</div>

		<div class="second_row">
			<div></div>
			<div><img class="game_image" src="../images/log_game.png" /></div>
			<div class="format">
				<form class="format__form" name="frm" method="post" action="loginWriteSave.jsp">	
					<table cellspacing="2" align="center" cellpadding="8" border="0">
						<tr>
							<td class="format__form__id">아이디 (ID) :</td>
							<td><input type="text" name="userid" placeholder="아이디를 입력해주세요" /></td>
						</tr>
						<tr>
							<td class="format__form__password">비밀번호 :</td>
							<td><input type="password" name="userpw" placeholder="비밀번호를 입력해주세요" /></td>
						</tr>
						<tr>
							<td>
								<div class="info">아이디와 비밀번호 찾기는 1:1문의 및 고객센터를 이용해주세요.</div>
							</td>
						<td>
							<input type="submit" value="로그인" class="btn" />
							<input type="reset" value="취소" class="btn" onclick="fn_reset();return false;"/>			
						</td>
						</tr>
					</table>
	   			</form>
			</div>
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
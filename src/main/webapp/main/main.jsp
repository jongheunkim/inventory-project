<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면_인기게임사</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="../css/main.css">
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

</script>
<style>


</style>
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
		<div class="company">
			<div class="company_category">	
				<div class="company__gamecom"><a href="main.jsp">인기게임사</a></div>
				<div class="company__game"><a href="main2.jsp">인기게임</a></div>
			</div>	
		
			<div class="company_type">
				<div class="company__text">넥슨</div>
				<div class="company__text">넷마블</div>
				<div class="company__text">NC</div>
				<div class="company__text">스마일게이트</div>
				
				<div class="company__text">EA코리아</div>
				<div class="company__text">네오플</div>
				<div class="company__text">카카오게임</div>
				<div class="company__text">펄어비스</div>
				
				<div class="company__text">블리자드코리아</div>
				<div class="company__text">라이엇</div>
				<div class="company__text">크래프톤</div>
			</div>
					
		</div>
		
			<div class="company_footer">
			<h1 class="text">아이템 시세 그래프</h1>
			</div>
				
				<div class="company_image">
					<img src="../images/items.png">
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
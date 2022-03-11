<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면_인기게임</title>
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
				<div class="company__text"><a href="../market/market_maplestory">메이플스토리</a></div>
				<div class="company__text">로스트아크</div>
				<div class="company__text">피파온라인4</div>
				<div class="company__text">아이온</div>
				
				<div class="company__text">리니지</div>
				<div class="company__text">던전&파이터</div>
				<div class="company__text">리니지2</div>
				<div class="company__text">검은사막</div>
				
				<div class="company__text">디아블로</div>
				<div class="company__text">리니지W</div>
				<div class="company__text">블레이드&소울</div>
				<div class="company__text">오딘</div>
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
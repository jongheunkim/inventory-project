<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="div1_nav">
	<ul class="ul_nav">
		<%
		if( session.getAttribute("userid") == null ) {
		%>
			<li class="li_nav" style="color:red;">즐겨찾기</li>
			<li class="li_nav">게임목록</li>
			<li class="li_nav">일대일문의</li>
			<li class="li_nav">캐쉬충전</li>
			<li class="li_nav" style="padding-right:40px;">마이페이지</li>
		<%
		} else {
		%>
			<li class="li_nav" style="color:red;">즐겨찾기</li>
			<a href="../market/marketList_game.jsp"><li class="li_nav" style="color:blue;">게임목록</li></a>
			<a href="../service/oneonone.jsp"><li class="li_nav">일대일문의</li></a>
			<li class="li_nav">캐쉬충전</li>
			<a href="../mypage/mypage.jsp"><li class="li_nav" style="padding-right:40px;">마이페이지</li></a>
		<%
		}
		%>	
	</ul>
	<a href="../main/main.jsp"><img class="img1_nav" src="../images/main_icon.PNG"></a>
</div>
<div style="width:100%;padding:0px;background-size:100% 100%;background-image:url('../images/nav_line_icon.PNG');">
	<div class="div2_nav">
		<img class="img2_nav" src="../images/nav_line_icon.PNG">
	</div>
</div>
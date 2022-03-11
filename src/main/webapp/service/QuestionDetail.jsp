<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/dbcon.jsp" %>      
<%
	String unq = request.getParameter("unq");
	
	if(unq == null || unq.equals("")){
%>
	<script>
		alert("잘못된 접근입니다!!");
		location="question.jsp";
	</script>
<% 		
	return;
	}
	
	String sql ="select q_title, q_content, q_wdate from cs_question where unq =" + unq;
	
	ResultSet rs = stmt.executeQuery(sql);
	
	String title = "";
	String content ="";
	String wdate = "";
	
	if(rs.next()){
		title = rs.getString("q_title");
		content = rs.getString("q_content");
		wdate = rs.getString("q_wdate");
		content = content.replace("\n", "<br>");
		content = content.replace(" ", "&nbsp;");
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/aside.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="../css/customerservice.css">
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
		<div class="all_space">
		<!-- 왼쪽 메뉴와 공백 -->
		<%@ include file="../include/n_left_menu.jsp" %>
		<!-- 왼쪽 메뉴와 공백 -->
		 <div class="n_notice_logo">	
			<img src="../images/q_banner.png" alt="logo">
		</div>			
			<div class="n_notice_main">	
				<table class="n_detail_table">
					<tr>
						<td><%=title %></td>
						<td style="text-align:right;padding-right:6px;"><span class="n_span3"><%=wdate %></span></td>
					</tr>
					<tr>
						<td colspan="2"><span class="n_span3">작성자</span> &nbsp; &nbsp; &nbsp;최고관리자</td>
					</tr>
					<tr>
						<td colspan="2">
							<%=content %>
						</td>
					</tr>
				</table>
				<div class="n_detail_button">
					<a href="Question.jsp" class="n_btn03">목록보기</a>
				</div>
			</div>
			<div style="height:50px;">
				&nbsp;
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
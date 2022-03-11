<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@include file="../include/dbcon.jsp" %>   
    
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
		<div class="c_customer_main">
			<span class="n_span1">고객센터</span>
		<div>
			<table class="n_table">
				<tr>
					<td><span class="n_span2">공지사항</span></td>
					<td class="n_td1"><a href="notice.jsp"><img src="../images/n_button1.png" alt="more" width="20" height="20"></a></td>
				</tr>
				<tr>
					<td colspan="2" class="n_td2">
				</tr>
				<%
					String sql = "select unq, n_title from cs_notice where rownum <= 5 order by unq desc";
				
					ResultSet rs = stmt.executeQuery(sql);
					
					while(rs.next()){
					String n_unq = rs.getString("unq");	
					String n_title = rs.getString("n_title"); 	
				%>
				<tr>
					<td colspan='2'><a href="noticeDetail.jsp?unq=<%=n_unq%>"><%=n_title %></a></td>		
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<div>
		<table class="n_table">
			<tr>
				<td><span class="n_span2">자주 묻는 질문</span></td>
				<td class="n_td1"><a href="Question.jsp"><img src="../images/n_button1.png" alt="more" width="20" height="20"></a></td>
			</tr>
			<tr>
				<td colspan="2" class="n_td2">
			</tr>
				<%
					String sql1 = "select unq, q_title from cs_question where rownum <= 5 order by unq desc";
				
					ResultSet rs1 = stmt.executeQuery(sql1);
					
					while(rs1.next()){
					String q_unq = rs1.getString("unq");	
					String q_title = rs1.getString("q_title");
					
					if(q_title.length() > 40){
						q_title = q_title.substring(0,40) + "...";
					}
				%>
				<tr>
					<td colspan='2'><a href="QuestionDetail.jsp?unq=<%=q_unq%>"><%=q_title %></a></td>		
				</tr>
				<%
					}
				%>
		</table>
		</div>
		<div class="c_div2">
			<table class="n_table">
				<tr>
					<td><span class="n_span2">1대1 문의</span></td>
					<td class="n_td1"><a href="oneonone.jsp"><img src="../images/n_button1.png" alt="more" width="20" height="20"></a></td>
				</tr>
				<tr>
					<td colspan="2" class="n_td2">
				</tr>
				<%
					String sql2 = "select unq, one_title from cs_oneonone where rownum <= 5 order by unq desc";
				
					ResultSet rs2 = stmt.executeQuery(sql2);
					
					while(rs2.next()){
					String one_unq = rs2.getString("unq");	
					String one_title = rs2.getString("one_title");
					
					if(one_title.length() > 30){
						one_title = one_title.substring(0,30) + "...";
					}
				%>
				<tr>
					<td colspan='2'><a href="oneonone.jsp"><%=one_title %></a></td>		
				</tr>
				<%
					}
				%>
			</table>	
		</div>
			<div >
				<img src="../images/n_customerimg.png" alt="customer" width="330" height="330">
			</div>	
			<div style="height:50px;">
				&nbsp;
			</div>		
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
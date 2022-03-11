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
		location="oneonone.jsp";
	</script>
<% 		
	return;
	}
		
	String sql ="select unq,one_name,one_content,one_title,one_wdate,one_check from cs_oneonone where unq =" + unq;
	
	ResultSet rs = stmt.executeQuery(sql);
	
	String title = "";
	String name = "";
	String content ="";
	String wdate = "";
	String answer = "";
	String udate = "";
	int chk = 0; 
	
	if(rs.next()){
		title = rs.getString("one_title");
		content = rs.getString("one_content");
		wdate = rs.getString("one_wdate");
		name = rs.getString("one_name");
		chk = rs.getInt("one_check");
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
			<img src="../images/o_banner.png" alt="logo">
		</div>			
			<div class="n_notice_main">	
				<table class="n_detail_table">
					<tr>
						<td><span style="font-weight:bold; font-size:20px;">Q : </span><%=title %></td>
						<td style="text-align:right;padding-right:6px;" class="n_td1"><span class="n_span3"><%=wdate %></span></td>
					</tr>
					<tr>
						<td colspan="2"><span class="n_span3">작성자</span> &nbsp; &nbsp; &nbsp;<%=name %></td>
					</tr>
					<tr>
						<td colspan="2">
							<%=content %>
						</td>
					</tr>
				</table>
				<div style="height:50px;">
				&nbsp;
				</div>
				<% 
					if(chk == 1){
					
						String sql1 = "select one_udate, one_answer from cs_oneonone where unq =" + unq;
						
						ResultSet rs1 = stmt.executeQuery(sql1);
						
						if(rs1.next()){
							answer = rs1.getString("one_answer");
							udate = rs1.getString("one_udate");
							
							answer = answer.replace("\n", "<br>");
							answer = answer.replace(" ", "&nbsp;");
						}				
				%>
				<table class="n_detail_table">
					<tr>
						<td><span style="font-weight:bold; font-size:20px;">A : </span> <%=title %> 
						<span class="t_span001" style="font-weight:bold; font-size:15px;">에 대한 답변</span></td>
						<td style="text-align:right;padding-right:6px;" class="n_td1"><span class="n_span3"><%=udate %></span></td>
					</tr>
					<tr>
						<td colspan="2"><span class="n_span3">작성자</span> &nbsp; &nbsp; &nbsp;관리자</td>
					</tr>
					<tr>
						<td colspan="2">
							<span style="font-weight:bold; font-size:15px; line-height:50px;">
							<%=answer %>
							</span>
						</td>
					</tr>
				</table>
				<%
					}else{
				%>
					<div style="height:70px;">
						&nbsp;
					</div>
					<img alt="답변" src="../images/wait.png" width=700px; height=250px;>
					<div>
						<hr>
					</div>
				<%
					}
				%>
				<div class="n_detail_button">
					<a href="oneonone.jsp" class="n_btn03">목록보기</a>
					<a href="oneonone_pass.jsp?unq=<%=unq %>&type=del" class="n_btn03">삭제하기</a>
					<a href="oneononeModify.jsp?unq=<%=unq %>&type=mod" class="n_btn03">수정하기</a>
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
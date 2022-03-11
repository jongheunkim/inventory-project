<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/dbcon.jsp" %>
<%

String list_title=request.getParameter("list_title");


String sql="select "
				+"distinct(game_company) game_company"
				+" from gamelist";
ResultSet rs=stmt.executeQuery(sql);
int cnt=1;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	
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
function fn_submit(company){
	company=company.replace("/"," ");
	$("#company").val(company);
	$("#frm_submit").submit();
}

</script>
<style>
.table_marketList{
	border:1px solid #ccc;
	width:80%;
	margin:0 auto;
	border-collapse:collapse;
	font-size:17px;
	margin-bottom:40px;
}
.th_marketList{
	height:60px;
}
.div_gamecompany{
	float:left;
	border:1px solid #A4A4A4;
	font-size:15px;
	margin-left:20px;
	position:fixed;
	margin-top:50px;
	border-radius:5px;
	padding:10px;
	height:50px;
	line-height:3.5;
	color:#fff;
	font-weight:bold;
	background-color:#A4A4A4;
}
.a_marketList{
	text-decoration:none;
	color:#000;
}
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
		<a href="marketList_game.jsp">
		<div class="div_gamecompany">
			게임목록
		</div>
		</a>
		<table class="table_marketList">
			<colgroup>
				<col width="20%">
				<col width="20%">
				<col width="20%">
				<col width="20%">
				<col width="20%">
			</colgroup>
			<tr>
			<%
			while(rs.next()){ 
				if(cnt%5==1&&cnt!=1){
					%>
						</tr>
						<tr>
					<%
				}
				String game_company=rs.getString("game_company");
				String[] array_name=game_company.split(" ");
				String company_name=game_company.replace(" ","/");
			%>
				<th class="th_marketList">
				<a href="javascript:fn_submit('<%=company_name %>')" class="a_marketList">
					<%
					for(int i=0;i<array_name.length;i++){ 
					%>	
						<%=array_name[i] %><br>
					<%	
					}
					%>
				</a>
				</th>
			<% 	
				cnt++;
			}
			if((cnt-1)%5!=0){
				for(int i=1;i<=5-(cnt-1)%5;i++){
				%>
					<th class="th_marketList"></th>
				<%	
				}
			}
			%>
			</tr>
		</table>
		<form id="frm_submit" method="post" action="marketList_game.jsp">
			<input type="hidden" id="company" name="company">
		</form>
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
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ include file="../include/dbcon.jsp" %>
<%@ page import="conn.ConOracle" %>


<%
String userid = request.getParameter("userid");
if(userid == null || userid.trim().equals("")) {
		return;
}
%>

<%

String sql = "select count(*) cnt from member "
		+ "	 where USERID='"+userid+"' ";
ResultSet rs = stmt.executeQuery(sql);
rs.next();
int cnt = rs.getInt("cnt");

String message = "";

if(cnt == 0) {
	message = "사용가능한 아이디 입니다.";
	out.print("<script> opener.document.frm.idcheck.value='Y'; </script>");
} else {
	message = "이미 사용중인 아이디 입니다.";
	out.print("<script> opener.document.frm.idcheck.value='N'; </script>");
}
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="width:280px; 
			height:100px;
			font-size:12px; 
			background-color:skyblue;
			text-align:center;">
	<br><br>
	<%=message %>
	<br><br>
	<button type="button" onclick="self.close()">닫기</button>
</div>	
</body>
</html>


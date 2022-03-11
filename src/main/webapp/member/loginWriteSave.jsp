<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="conn.Cookies" %>
<%@ page import="conn.ConOracle" %>

<%
Statement stmt = ConOracle.dbconnect();

String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");

String sql = "select count(*) cnt from member "
	+ " where userid='"+userid+"' and userpw='"+userpw+"' ";
ResultSet rs = stmt.executeQuery(sql);
rs.next();

int cnt = rs.getInt("cnt");
if( cnt == 0 ) {
%>
		<script>
		alert("다시 확인해주세요!");
		history.back();
		</script>
<%
		return;} 
else {
String sqlGetName = "select name from member "
	+ " where userid='"+userid+"' and userpw='"+userpw+"' ";
ResultSet rsName = stmt.executeQuery(sqlGetName);
rsName.next();

String name = rsName.getString(1);
session.setAttribute("userid", userid);
session.setAttribute("name", name);
%>
		<script>
		alert("<%=name %>님 로그인 되었습니다.");
		location="../main/main.jsp";
		</script>

<%

}
%>

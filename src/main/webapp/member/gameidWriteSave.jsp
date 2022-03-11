<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/dbcon.jsp" %>
<%@ page import="conn.ConOracle" %>

<%
String userid 		= request.getParameter("userid");
String userpw	  	= request.getParameter("userpw");
String email		= request.getParameter("email");
String game_name		= request.getParameter("game_name");
String game_id		= request.getParameter("game_id");
%>

<%
if( userid==null || 
	userpw==null ||
	email==null   ||
	game_name==null  || game_id==null ) {
%>
<script>
	alert("잘못된 경로로의 접근!!");
	location="../main/main.jsp";
</script>
<%
		return;
}
%>

<%
boolean result1 = userid.matches("^[a-zA-Z]{1}[a-zA-Z0-9_-]{3,11}$");
if( result1 == false ) {
%>
		<script>
		alert("아이디를 다시 확인해주세요.");
		history.back();
		</script>
<%
		return;
}
String sql_idcheck = " SELECT COUNT(*) FROM MEMBER "
		+ " WHERE userid='"+userid+"' "
		+ " AND userpw='"+userpw+"' "
		+ " AND email='"+email+"' ";
ResultSet rs = stmt.executeQuery(sql_idcheck);
rs.next();
int count = rs.getInt(1);

if(count == 1){
	String sql = "insert into gameid (  p_userid, "
			+ " email, "
			+ " game_name, "
			+ " game_id ) "
				+ " values ( "
					+ "'"+userid+"',"
					+"'"+email+"',"
					+"'"+game_name+"',"
					+"'"+game_id+"' ) ";
	int result = stmt.executeUpdate(sql);

	if( result == 1 ) {	
	%>
		<script>
		alert("게임아이디 등록이 완료되었습니다.");
		location="../main/main.jsp";
		</script>
	<% 
	}
	
} else{
%>
		<script>
		alert("오류가 발생했습니다. 작성하신 정보를 다시 확인해주세요.");
		location="gameidWrite.jsp";
		</script>
<%
}
%> 

								
								
								
								
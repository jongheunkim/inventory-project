<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>    
<%@ page import="conn.Cookies" %>
<%@ page import="conn.ConOracle" %>

<html>
	<head>
	</head>
	<body>

<%

Statement stmt = ConOracle.dbconnect();

String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");
String name = request.getParameter("name");
String hp1 = request.getParameter("hp1");
String hp2 = request.getParameter("hp2");
String hp3 = request.getParameter("hp3");
String em1 = request.getParameter("em1");
String em2 = request.getParameter("em2");
String year  		= request.getParameter("year");
String month 	 	= request.getParameter("month");
String day  		= request.getParameter("day");
String gender 	 	= request.getParameter("gender");
String zipcode 		= request.getParameter("zipcode");
String addr1  		= request.getParameter("addr1");
String addr2  		= request.getParameter("addr2");
String bank_type  		= request.getParameter("bank_type");
String bank_account_detail  	= request.getParameter("bank_account_detail");
String account_name  	= request.getParameter("account_name");
String service = (request.getParameter("service") == null? "false" : request.getParameter("service"));
String my_number  	= request.getParameter("my_number");

String phone = hp1+"-"+hp2+"-"+hp3;
String email = em1+"@"+em2;
String birth = year+"-"+month+"-"+day; 

String sql = "insert into member (userid, "
								+ " userpw, "
								+ " name, "
								+ " phone, "
								+ " email, "
								+ " birth, "
								+ " gender, "
								+ " zipcode, "
								+ " addr1, "
								+ " addr2, "
								+ " bank_type, "
								+ " bank_account_detail, "
								+ " account_name, "
								+ " service, "
								+ " my_number, "
								+ " rdate) "

				+ " values ('"+userid+"', "
					+ " '"+userpw+"', "
					+ " '"+name+"', "
					+ " '"+phone+"', "
					+ " '"+email+"', "
					+ " '"+birth+"', "
					+ " '"+gender+"', "
					+ " '"+zipcode+"', "
					+ " '"+addr1+"', "
					+ " '"+addr2+"', "
					+ " '"+bank_type+"', "
					+ " '"+bank_account_detail+"', "
					+ " '"+account_name+"', " 
					+ " '"+service+"', "
					+ " '"+my_number+"', "
					+ " sysdate) ";

ResultSet rs = stmt.executeQuery(sql);
rs.next();
%>			
		<script>
		alert("회원가입이 완료되었습니다.");
		location="../member/loginWrite.jsp";
		</script>
	</body>  
</html>


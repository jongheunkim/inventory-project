<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../include/dbcon.jsp" %>    

<%
	String unq = request.getParameter("unq");
	String pass = request.getParameter("pass");
	
	String sql = "select count(*) cnt from cs_oneonone where unq="+unq+"and one_passwd=" + pass;	

	ResultSet rs = stmt.executeQuery(sql);
	
	rs.next();
	int cnt = rs.getInt("cnt");
	String msg = "fail";
	
	if(cnt == 1){
		msg = "del_ok";
	}
%>

{"result":"<%=msg %>"}
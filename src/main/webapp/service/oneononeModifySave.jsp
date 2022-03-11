<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file = "../include/dbcon.jsp" %>  

<%
	String unq = request.getParameter("unq");
 	String msg = "fail";
	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String phone = request.getParameter("phone");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int result = 0;
	
	if(title == null || pass == null || title.trim().equals("") || pass.trim().equals("")){
		msg = "data_null";			
	}else{	
		if(title.length() > 4000){
			msg = "data_size";
		}else{
			String sql = "update cs_oneonone set one_name='"+name+"', one_passwd='"+pass+"', "
					+ " one_phone='"+phone+"',one_title='"+title+"',one_content='"+content+"' where unq="+unq;
			
			result = stmt.executeUpdate(sql);
		}
	}
	
	if(result == 1) msg = "ok";
%>

{"result":"<%=msg %>"}
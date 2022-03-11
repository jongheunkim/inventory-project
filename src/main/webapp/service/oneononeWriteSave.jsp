<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file = "../include/dbcon.jsp" %>  

<%
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
			String sql = "insert into cs_oneonone (unq,one_name,one_passwd,one_title,one_phone,one_wdate,one_content) "
					+ " values (cs_oneonone_seq.nextval,'"+name+"','"+pass+"','"+title+"','"+phone+"',sysdate,'"+content+"')";
			
			result = stmt.executeUpdate(sql);
		}
	}
	
	if(result == 1) msg = "ok";
%>

{"result":"<%=msg %>"}
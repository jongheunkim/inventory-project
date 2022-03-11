
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/dbcon.jsp" %>
    
<%
 	String unq = request.getParameter("unq");
 		
	if(unq == null || unq.equals("")){
%>
	<script>
		alert("잘못된 접근입니다.");
		location='oneonone.jsp';
	</script>
<% 	
	}
	String sql = "delete from cs_oneonone where unq ="+unq;

	
	int result = stmt.executeUpdate(sql);
	
	if(result == 1) {
%>    
 <script>
	alert("삭제완료");
	location = 'oneonone.jsp'; 
</script>  
<%
	}else{
%>    
<script>
	alert("삭제실패");
	history.back(); 
</script>      
<%
	}
%>    
    
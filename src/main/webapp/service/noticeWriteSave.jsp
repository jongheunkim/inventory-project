
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/dbcon.jsp" %>
    
<%
 	String title = request.getParameter("title");
 	String content = request.getParameter("content");
 		
 	int con_len = 0;
	if(content != null){
		
		con_len = content.length();
			
	}
	
	if(con_len >= 4000){
%>
	<script>
	alert("내용의 양이 너무 많습니다. \n4000자 까지 가능.")
	history.back();
	</script>		
<% 
	return;
}
 	
	String sql = "INSERT INTO cs_notice(unq,n_title,n_content,n_wdate)"
		+ " VALUES(cs_notice_seq.nextval,'"+title+"','"+content+"',sysdate)";


	int result = stmt.executeUpdate(sql);
	
	if(result == 1) {
%>    
 <script>
	alert("저장완료");
	location = 'notice.jsp'; // 목록으로 페이지 이동
</script>  
<%
	}else{
%>    
<script>
	alert("저장실패");
	history.back(); // 이전 화면으로 페이지 이동
</script>   
    
<%
	}
%>    
    
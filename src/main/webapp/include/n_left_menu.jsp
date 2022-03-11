<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/dbcon2.jsp" %>

<%
	int n_total = 0;
	int q_total = 0;
	int one_total = 0;
	String n_sql = "select count(*) n_total from cs_notice";
	
	ResultSet rsn = stmt2.executeQuery(n_sql);
	
	rsn.next();
	
	n_total = rsn.getInt("n_total");
	
	String q_sql = "select count(*) q_total from cs_question";
	
	ResultSet rsq = stmt2.executeQuery(q_sql);
	
	rsq.next();
	
	q_total = rsq.getInt("q_total");
	
	String one_sql = "select count(*) one_total from cs_oneonone";
	
	ResultSet rso = stmt2.executeQuery(one_sql);
	
	rso.next();
	
	one_total = rso.getInt("one_total");
%>
    
<div class="n_left_space">	
	&nbsp;
</div>    
<div class="n_left_menu">
	<div class="n_left_menu2">
		<div class="n_left_logo">
			<img src="../images/Customer_logo.png">
		</div>
		<span>고객센터</span>
		<table>
			<tr>
				<td><a href="../service/notice.jsp">공지사항</a></td>
				<td class="td1"><button disabled><%=n_total %></button></td>
			</tr>
			<tr>
				<td><a href="../service/oneonone.jsp">1대1문의</a></td>
				<td class="td1"><button disabled><%=q_total %></button></td>
			</tr>
			<tr>
				<td><a href="../service/Question.jsp">자주묻는질문</a></td>
				<td class="td1"><button disabled><%=one_total %></button></td>
			</tr>
		</table>
	</div>
	&nbsp;
</div>
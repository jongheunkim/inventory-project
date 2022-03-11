<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/dbcon.jsp" %>    

<%
String search_field = request.getParameter("n_search_st");
String search_text = request.getParameter("n_search_txt");

if( search_field == null ) search_field = "";
if( search_text == null ) search_text = "";

String str = "";

if( search_field != null && search_text != null 
	&& !search_text.equals("") && !search_field.equals("")){
	str = "where "+search_field+" like '%"+search_text+"%'";
}

String page_no = request.getParameter("page_no");

if(page_no == null || page_no.trim().equals("")){
	page_no = "1";
}

if( !page_no.matches("[0-9]+")){
	page_no = "1";
}

int rn_eno = Integer.parseInt(page_no) * 10;
int rn_sno = rn_eno - 9;

String sql1 = "select count(*) total from cs_oneonone " + str;

ResultSet rs1 = stmt.executeQuery(sql1);

int total = 0;

if(rs1.next()){
 total = rs1.getInt("total");
}

int lastpage = (int) Math.ceil(total/10.0);

String sql2 = "select b.* from( "
		+ " select rownum rn, a.* from ( "
		+ " select unq ,one_title, to_char(one_wdate,'yyyy-mm-dd') one_wdate, one_name, one_check from cs_oneonone " + str +" order by unq desc) a) b "
		+ " where rn BETWEEN "+rn_sno+" and "+ rn_eno ;

ResultSet rs2 = stmt.executeQuery(sql2);
	
int rownum = total - ((rn_eno) - 10); //행번호

int pg_sno = ((Integer.parseInt(page_no)-1)/10)*10 + 1;
int pg_eno = pg_sno + 9;

if(pg_eno > lastpage){
	pg_eno = lastpage;
}
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/aside.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="../css/customerservice.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
if((navigator.userAgent).indexOf("Chrome")>-1){
	document.write("<link rel='stylesheet' href='../css/aside_chrome.css'>");
}
else{
	document.write("<link rel='stylesheet' href='../css/aside_ie.css'>");
}
$(function(){
		$("body").css("width",screen.width-30);							
});
</script>
<style>		
</style>
</head>
<body>
<header>
	<%@ include file="../include/header.jsp" %>
</header>
<nav>
	<%@ include file="../include/nav.jsp" %>
</nav>
<section>
	<article>
		<div class="all_space">	
		
		<!-- 왼쪽 메뉴와 공백 -->
		<%@ include file="../include/n_left_menu.jsp" %>
		<!-- 왼쪽 메뉴와 공백 -->
			
		<div class="n_notice_logo">	
			<img src="../images/o_banner.png" alt="logo">
		</div>			
		<div class="n_notice_main">				
				<div style="text-align:center;margin-top:15px;">
				<form name="frm" method="post" action="oneonone.jsp">
					<select name="n_search_st" class="n_search_st">	
						<option value="">-선택-</option>
						<option value="one_title">제목</option>
						<option value="one_name">이름(아이디)</option>
					</select>
					<input type="text" name="n_search_txt" class="n_search_txt" value="<%=search_text%>">
					<button type="submit" class="n_btn01">검색</button>
				</form>	
				</div>	
				<div style="text-align:right; padding-right:28px; margin-bottom:-20px;">
					<button type="button" class="n_btn03" onclick="location='oneononeWrite.jsp'">▶글쓰기</button>	
				</div>	
				<table style="font-size:12px;">
					<colgroup>
						<col width="10%">
						<col width="*">
						<col width="15%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<tr>	
						<th>번호</th>
						<th>제목</th>
						<th>이름</th>
						<th>등록일</th>
						<th>처리상태</th>
					</tr>
<%
				while(rs2.next()){		
					String unq = rs2.getString("unq");
					String name = rs2.getString("one_name");
					String title = rs2.getString("one_title");
					String wdate = rs2.getString("one_wdate");
					int chk = rs2.getInt("one_check");	
					
					if(title.length() > 20){
						title = title.substring(0,20) + "...";
					}			
%>	
					<tr>
						<td class="n_td0"><%=rownum %></td>
						<td><a href="oneonone_pass.jsp?unq=<%=unq %>"><%=title %></a></td>
						<td class="n_td0"><%=name %></td>
						<td class="n_td0"><%=wdate %></td>
						<td class="n_td0">
						<%
						if(chk == 1){					
						%>
							<button class="one_btn02" disabled>답변완료</button>
						<%
						} else{
						%>	
							<button class="one_btn03" disabled>미답변</button>
						<% 
						}
						%>						
						</td>					
					</tr>
<%
					rownum--;
				}			
%>				
				</table>		
		<div class="n_number">
		<%
			if((pg_sno-1) > 0){
		%>
		<a href="oneonone.jsp?page_no=<%=pg_sno-1 %>" class="n_btn02">[before]</a>	
		<%
			}	
			for(int i = pg_sno; i <= pg_eno; i++)	{
		%>		
			<a href="oneonone.jsp?page_no=<%=i %>" class="n_btn02"><%=i %></a>
		<% 
			}		
			if(pg_eno != lastpage){
		%>
		<a href="oneonone.jsp?page_no=<%=pg_eno+1 %>" class="n_btn02">[next]</a>
		<%
			}
		%>						
				</div>	
		</div>
		<div style="height:50px;">
				&nbsp;
		</div>				
	</div>
	</article>
	<aside>
		<%@ include file="../include/right_menu.jsp" %>
	</aside>
</section>
<footer>
	<%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/dbcon.jsp" %>

<%
String search_field = request.getParameter("n_search_st");
String search_text = request.getParameter("n_search_txt");

String pageNo = request.getParameter("page_no");
if(pageNo == null) {
	pageNo = "1";
}

if( search_field == null ) search_field = "";
if( search_text == null ) search_text = "";

String str = " ";

if(     search_field != null && search_text != null 
    && !search_field.equals("") && !search_text.trim().equals("") ) {

	str = " where "+search_field+" like '%"+search_text+"%' ";
} else if( search_field != null && !search_field.equals("") && search_text.trim().equals("")){
	str = "where q_category = '"+ search_field +"'"; 
}

int unit = 14;

// 총 데이터 개수 SQL 작성
String sqlTot = "select count(*) total from cs_question " + str;
ResultSet rsTot = stmt.executeQuery(sqlTot);
rsTot.next();
int total = rsTot.getInt("total");

int total_page = (int)(Math.ceil((double)total/unit)); //  (double)51/10 -> ceil(5.1) -> 6 

//(초기)행번호 얻기
int rownum = total - ((Integer.parseInt(pageNo)-1)*unit);

// pageNo 1:1, 2:11, 3:21
int start_no = (Integer.parseInt(pageNo)-1)*unit + 1;
int end_no = (start_no+ (unit-1) );

// 1~10(1) , 11~20(11) , 21~30(21)
// 3->1, 7->1, 10/10->1        , 12/10->11, 15->11, 22->21, 29->21
// 페이징 번호의 초기값 세팅
int page_sno = ((Integer.parseInt(pageNo)-1)/unit)*unit + 1;
// 페이징 번호의 마지막값 세팅
int page_eno = page_sno + (10-1);

if( total_page < page_eno ) {
	page_eno = total_page;
}
%>

<!-- 전체 데이터 목록 SQL작성 적용 -->
<%
String sql = "   SELECT b.* FROM ( "
			+" 		SELECT rownum rn, a.* FROM ( "
			+" 	  		SELECT unq, q_title, q_category "
			+" 				FROM cs_question " + str + " ORDER BY q_wdate desc) a ) b"
			+"	WHERE rn between " + start_no + " AND "+ end_no;
ResultSet rs = stmt.executeQuery(sql);

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

function fn_submit(a){
	var key = a;
	
	if(a.equals("전체")){
		alert("ddd");
	}
	
	
}

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
			<%@ include file="../include/n_left_menu.jsp" %>		
		<div class="q_notice_logo">	
			<img src="../images/q_banner.png" alt="logo">
		</div>			
		<div class="q_notice_main">			
				<form name="frm" method="post" action="Question.jsp">
				<div style="text-align:center;margin-top:15px;">
				
					<select name="n_search_st" class="n_search_st">	
						<option value="q_title">제목</option>
						<option value="q_content">내용</option>
					</select>
					<input type="text" name="n_search_txt" class="n_search_txt" >
					<button type="submit" class="n_btn01">검색</button>
				</div>			
				<div style="margin-left:10px;margin-top:10px;">
					<button type="button" onclick="location='Question.jsp'" class="Q_btn1">전체보기</button>
					<button type="button" onclick="location='Question.jsp?n_search_st=일반'" class="Q_btn1">일반</button>
					<button type="button" onclick="location='Question.jsp?n_search_st=마일리지'" class="Q_btn1">마일리지</button>
					<button type="button" onclick="location='Question.jsp?n_search_st=물품판매'" class="Q_btn1">물품판매</button>
					<button type="button" onclick="location='Question.jsp?n_search_st=물품구매'" class="Q_btn1">물품구매</button>		
				</div>
				</form>
				<table style="font-size:12px;">						
					<%
					while( rs.next() ){
						String unq = rs.getString("unq");
						String category = rs.getString("q_category");
						String title = rs.getString("q_title");	
					%>		
					<tr>	
						<td><a href="QuestionDetail.jsp?unq=<%=unq %>"><span>[<%=category %>]</span> <%=title %></a></td>					
					</tr>
					<%
					}
					%>						
				</table>
				<div class="n_number">
					<%
					if((page_sno-1) > 0){
					%>
					<a href="Question.jsp?page_no=<%=page_sno-1 %>" class="n_btn02">[before]</a>	
					<%
						}	
						for(int i = page_sno; i <= page_eno; i++)	{
					%>		
						<a href="Question.jsp?page_no=<%=i %>" class="n_btn02"><%=i %></a>
					<% 
						}		
						if(page_eno != total_page){
					%>
					<a href="Question.jsp?page_no=<%=page_eno+1 %>" class="n_btn02">[next]</a>
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
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/dbcon.jsp" %>
<%
String user_id=(String)session.getAttribute("userid");
if(user_id==null){
%>
	<script>
		alert("르그인후 이용해주세요");
		location="../member/loginWrite.jsp";
	</script>
<%
	return;
}
%>
<%
String sql_gameid_chk="select count(*) cnt from gameid where game_name='메이플스토리' and p_userid='"+user_id+"'";
ResultSet rs_gameid_chk=stmt.executeQuery(sql_gameid_chk);
rs_gameid_chk.next();
int gameidchk=rs_gameid_chk.getInt("cnt");
if(gameidchk==0){
%>
	<script>
		alert("메이플스토리 게임아이디를 등록 후 이용하세요.");
		location="../member/gameidWrite.jsp";
	</script>
<%
	return;
}

String sql_server="select DISTINCT(game_server) game_server from gamechar "
				+"where game_name='메이플스토리' and p_gameid=(select game_id from gameid "
				+"where p_userid='"+user_id+"' and game_name='메이플스토리')";
Statement stmt2=conn.createStatement();
ResultSet rs_server=stmt2.executeQuery(sql_server);

String search_game_server=request.getParameter("game_server");
String search_char_name=request.getParameter("char_name");


if(search_char_name==null){
	search_char_name="";
}

int unit=8;
String pageNo=request.getParameter("pageNo");
if(pageNo==null||pageNo.equals("")){
	pageNo="1";
}

int s_no=(Integer.parseInt(pageNo)-1)*unit+1;
int e_no=s_no+(unit-1);

String sql_total="select count(*) total from market_maplestory "
		+"	where sell='Y' and item_owner='"+search_char_name+"' and game_server='"+search_game_server+"' "
		+"	or sysdate>rdate+2 and item_owner='"+search_char_name+"' and game_server='"+search_game_server+"' ";
ResultSet rs_total=stmt.executeQuery(sql_total);
rs_total.next();
int total=rs_total.getInt("total");

int total_page=(int)Math.ceil((double)total/unit);
int before_page=Integer.parseInt(pageNo)-1;
int after_page=Integer.parseInt(pageNo)+1;
if(before_page<1){
	before_page=1;
}
if(after_page>total_page){
	after_page=total_page;
}

/* 선택된 캐릭터의 완료된 거래소 아이템 목록 S */
String sql_char_market="select b.* from"
		+"	(select rownum rn,a.* from "
		+"	(select unq,"
		+"	decode(item_volume,1,item_name,item_name||'('||item_volume||')') item_name,"
		+"	decode(sell,'N','0',to_char(decode(item_volume,1,item_price,item_price*item_volume),'FM999,999,999,999,999,999,999')) item_allprice,"
		+"	to_char(item_price,'FM999,999,999,999,999,999,999') item_price,"
		+"	to_char(rdate,'yyyy-mm-dd') rdate,"
		+"	to_char(rdate+30,'yyyy-mm-dd') keepdate,"
		+"	replace(item_info,',','<br>') item_info,"
		+"	decode(sell,'N','미판매',decode(substr(item_owner,instr(item_owner,'-')+1),'판매','판매완료','구매','구매완료')) sell,"
		+"	replace(substr(replace(item_part,',','<br>'),instr(item_part,'-')+1),'(','<br>(') item_part"
		+"	from market_maplestory "
		+"	where sell='Y' and (item_owner='"+search_char_name+"-구매' or item_owner='"+search_char_name+"-판매') and game_server='"+search_game_server+"' "
		+"	or sysdate>rdate+2 and item_owner='"+search_char_name+"' and game_server='"+search_game_server+"' "
		+"	) a) b "
		+"	where rn>="+s_no+" and rn<="+e_no;;
Statement stmt_char_market=conn.createStatement();
ResultSet rs_char_market=stmt_char_market.executeQuery(sql_char_market);
/* 선택된 캐릭터의 완료된 거래소 아이템 목록 S */

String sql_char="select char_name from gamechar "
		+"where game_name='메이플스토리' and game_server='"+search_game_server+"' "
		+" and p_gameid=(select game_id from gameid "
		+"where p_userid='"+user_id+"' and game_name='메이플스토리')";
Statement stmt3=conn.createStatement();
ResultSet rs_char=stmt3.executeQuery(sql_char);

String sql_charinfo="select to_char(char_money,'FM999,999,999,999') char_money from gamechar where char_name='"+search_char_name+"'";
Statement stmt4=conn.createStatement();
ResultSet rs_charinfo=stmt4.executeQuery(sql_charinfo);
String char_money="";
if(rs_charinfo.next()){
	char_money=rs_charinfo.getString("char_money");
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	
	
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
		

		
		$("#game_server").change(function(){
			
			$("#frm_server_char").submit();
			
		});
		
		$("#char_name").change(function(){
			
			$("#frm_server_char").submit();
		});
		
		
});




function replaceAll(str, searchStr, replaceStr) {

	   return str.split(searchStr).join(replaceStr);
}
function fn_info(price,name,info,part,cnt){
	
	var tr=$(".table_marketSell tr:eq("+cnt+")");
	for(var i=1;i<$(".table_marketSell tr").length;i++){
		if(i!=cnt){
			$(".table_marketSell tr:eq("+i+")").css("background-color","#585858");
		}
		else{
			$(".table_marketSell tr:eq("+i+")").css("background-color","#2E64FE");
		}
	}
	$("#div_info").html("<div style='float:left;margin-left:200px;'><div style='margin-top:20px;margin-left:40px;'>"+name+"</div><div style='width:80%;float:left;margin-top:20px;margin-left:40px;'>"+part+"</div></div><div style='float:left;font-size:10px;margin-top:20px;margin-left:40px;'>"+info+"</div><div style='float:left;margin-top:20px;margin-left:40px;'> 개당 가격 : "+price+"</div>");
}
function fn_page(no){
	$("#pageNo").val(no);
	$("#frm_page").submit();
}
function fn_register(){
	if($("#item_volume").val()==""){
		alert("수량을 정해주세요.");
		$("#item_volume").focus();
		return;
	}
	if($("#item_price").val()==""){
		alert("가격을 정해주세요.");
		$("#item_price").focus();
		return;
	}
	
	var formdata=$("#frm_register").serialize();
	
	$.ajax({
		
		type:"post",
		url:"marketSellSave_maplestory.jsp",
		data:formdata,
		
		datatype:"text",
		success:function(data){
			data=$.trim(data);
			if(data=="ok"){
				alert("등록 완료!");
				location.reload();
			}
			else if(data=="volume_err"){
				alert("수량을 다시 입력해주세요");
			}
			else if(data=="insert_err"){
				alert("등록 실패!!");
			}
			else{
				alert("존재 하지 않는 아이템입니다.");
			}
		},
		error:function(){
			alert("오류 발생");
		}
	});
}
</script>
<style>
.div1_title{
	margin:0 auto;
	width:80%;
	height:50px;
}
.div2_title{
	font-size:30px;
	float:left;
	font-weight:bold;
	margin-right:20px;
}
.div3_title{
	font-size:15px;
	float:left;
	line-height:3.5;
	width:100px;
}
.div4_title{
	float:right;
	line-height:4.0;
}
.div1_market{
	margin:0 auto;
	width:90%;
	background-color:#848484;
	margin-top:20px;
	padding:10px;
	margin-bottom:50px;
}
.div2_market{
	float:left;
}
.div3_market{
	float:right;
}
.ul_market{
	list-style:none;
}
.li_market{
	float:left;
	border:1px solid #1C1C1C;
	width:23%;
	height:30px;
	font-size:15px;
	text-align:center;
	margin-left:5px;
	border-radius:5px;
	line-height:2.0;
	color:#ccc;
	font-weight:bold;
	box-shadow:3px 3px 3px 3px #424242;
	background-color:#1c1c1c;
}

select{
	height:25px;
	border-radius:5px;
	background-color:#1C1C1C;
	border:1px solid #1c1c1c;
	color:#ccc;
}
.li_marketSell{
	border:1px solid #1c1c1c;
	margin-top:10px;
	padding:10px;
	border-radius:5px;
	background-color:#1c1c1c;
	color:#ccc;
	box-shadow:3px 3px 3px 3px #424242;
	text-align:center;
	cursor:pointer;
}
.td_marketSell{
	text-align:center;
	padding:5px;
	border:1px solid #ccc;
	border-radius:5px;
	height:42px;
	font-size:10px;
	background-color:#ccc;
	box-shadow:1px 1px 1px 1px #424242;
}
.table_marketSell{
	 width:90%;
	 margin:0 auto;
	 border-collapse:collapse;
	 border:1px solid #424242;
	 color:#ccc;
	 background-color:#585858;
}
.th_marketSell{
	border-top:1px solid #424242;
	padding:10px;
	font-size:12px;
}
.a_marketSell{
	text-decoration:none;
	color:#000;
}
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
		<!-- 거래소 게임 타이틀 s -->
		<div class="div1_title">
			<div class="div2_title">메이플스토리</div><div class="div3_title">거래소</div>
		<div class="div4_title">
			<form name="frm_server_char" id="frm_server_char" method="post" action="marketComplete_maplestory.jsp">
			<select id="game_server" name="game_server" style="margin-right:10px;">
				<option value="">=서버 선택=</option>
				<%
				while(rs_server.next()){
					String game_server=rs_server.getString("game_server");
				%>
					<option value="<%=game_server%>" <%if(search_game_server!=null&&search_game_server.equals(game_server)){out.print("selected");} %>><%=game_server %></option>
				<%
				}
				%>
			</select>
			<select id="char_name" name="char_name">
				<option value="">=캐릭 선택=</option>
				<%
				while(rs_char.next()){
					String char_name=rs_char.getString("char_name");
				%>
					<option value="<%=char_name%>" <%if(search_char_name!=null&&search_char_name.equals(char_name)){out.print("selected");} %>><%=char_name %></option>
				<%
				}
				%>
			</select>
			</form>
			<form id="frm_server_char_sell" method="post" action="marketSell_maplestory.jsp">
				<input type="hidden" name="game_server" id="game_server" value="<%=search_game_server%>">
				<input type="hidden" name="char_name" id="char_name" value="<%=search_char_name%>">
			</form>
		</div>
		</div>
		<!-- 거래소 게임 타이틀 e  -->
		<!-- 거래소 화면 s -->
		<div class="div1_market">
			<div style="width:90%;height:30px;margin:0 auto;">
				<form id="frm_name" name="frm_name" method="post" action="market_maplestory.jsp">
				<input type="hidden" name="game_server" id="game_server" value="<%=search_game_server%>">
				<input type="hidden" name="char_name" id="char_name" value="<%=search_char_name%>">
				<div class="div2_market"> 
					검색 
					<input type="text" id="search_item_name" name="search_item_name">
				</div>
				</form>
				<div class="div3_market">
					<%=search_char_name %> 
					<input type="text" readonly name="my_money" id="my_money" value="<%=char_money%>">
				</div>
			</div>
				<%@ include file="../include/marketMenu_maplestory.jsp" %>
			<div style="width:100%;margin-top:20px;margin-bottom:20px;">
				<table class="table_marketSell">
					<colgroup>
						<col width="20%"/>
						<col width="30%"/>
						<col width="10%"/>
						<col width="15%"/>
						<col width="*"/>
					</colgroup>
					<tr>
						<th class="th_marketSell">거래날짜</th>
						<th class="th_marketSell">아이템 이름</th>
						<th class="th_marketSell">상태</th>
						<th class="th_marketSell">가격</th>
						<th class="th_marketSell">처리</th>
					</tr>
					<%
					int cnt=1;
					while(rs_char_market.next()){
						int unq=rs_char_market.getInt("unq");
						String item_name=rs_char_market.getString("item_name");
						String item_allprice=rs_char_market.getString("item_allprice");
						String rdate=rs_char_market.getString("rdate");
						String keepdate=rs_char_market.getString("keepdate");
						String item_info=rs_char_market.getString("item_info");
						String item_part=rs_char_market.getString("item_part");
						String sell=rs_char_market.getString("sell");
						String item_price=rs_char_market.getString("item_price");
					%>
					<tr style="cursor:pointer;" onclick="fn_info('<%=item_price %>','<%=item_name%>','<%=item_info%>','<%=item_part%>','<%=cnt%>')">
						<th class="th_marketSell"><%=rdate %><br>(보관 만료 : <%=keepdate %>)</th>
						<th class="th_marketSell" style="text-align:left;"><%=item_name %></th>
						<th class="th_marketSell"><%=sell %></th>
						<th class="th_marketSell"><%=item_allprice %></th>
						<th class="th_marketSell" style="padding:0px;">
							<%
							if(sell.equals("미판매")){
							%>
							<button type="button" onclick="fn_reget(<%=unq%>)" style='color:#ccc;background-color:#1c1c1c;border-radius:5px;border:1px solid #1c1c1c;width:80px;'>물품반환</button>
							<button type="button" onclick="fn_resubmit(<%=unq %>)" style='color:#ccc;background-color:#1c1c1c;border-radius:5px;border:1px solid #1c1c1c;width:80px;'>재등록</button>
							<%
							}
							else{
							%>
							<button type="button" onclick="fn_get(<%=unq%>)" style='color:#ccc;background-color:#1c1c1c;border-radius:5px;border:1px solid #1c1c1c;width:80px;'>수령</button>
							<%
							}
							%>
						</th>
					</tr>
					<%
						cnt++;
					}
					%>
				</table>
			<div style="text-align:center;margin-top:10px;">
				<a href="javascript:fn_page('1')"><img src="../images/market_firstpage.PNG"></a>
				<a href="javascript:fn_page('<%=before_page%>')"><img src="../images/market_beforepage.PNG"></a>
				<%=pageNo %>/<%=total_page %>
				<a href="javascript:fn_page('<%=after_page%>')"><img src="../images/market_afterpage.PNG"></a>
				<a href="javascript:fn_page('<%=total_page%>')"><img src="../images/market_lastpage.PNG"></a>
			</div>
			<form id="frm_page" method="post" action="marketComplete_maplestory.jsp">
				<input type="hidden" name="pageNo" id="pageNo" value="<%=pageNo%>">
				<input type="hidden" name="game_server" value="<%=search_game_server%>">
				<input type="hidden" name="char_name" value="<%=search_char_name%>">
			</form>
			</div>
			
			<div id="div_info" style="color:#ccc;width:90%;height:200px;margin-bottom:20px;margin-top:10px;margin:0 auto;border:1px solid #424242;border-radius:5px;background-color:#086A87">
					
			</div>
		</div>
		<!-- 거래소 화면 e -->
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
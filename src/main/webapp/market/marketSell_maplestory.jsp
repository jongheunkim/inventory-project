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
String search_str="	where item_owner='"+search_char_name+"'";

int unit=8;
String pageNo=request.getParameter("pageNo");
if(pageNo==null||pageNo.equals("")){
	pageNo="1";
}

int s_no=(Integer.parseInt(pageNo)-1)*unit+1;
int e_no=s_no+(unit-1);

String sql_total="select count(*) total from market_maplestory "
		+"	where sell='N' and sysdate<=rdate+2 and item_owner='"+search_char_name+"' and game_server='"+search_game_server+"' ";
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

/* 선택된 캐릭터가 거래소에 등록한 아이템 목록 S */
String sql_char_market="select b.* from"
		+"	(select rownum rn,a.* from "
		+"	(select item_name,"
		+"	to_char(decode(item_volume,1,item_price,item_price*item_volume),'FM999,999,999,999,999,999,999') item_allprice,"
		+"	to_char(rdate+2,'yyyy mm dd hh24 mi ss') rdate from market_maplestory"
		+"	where sell='N' and sysdate<=rdate+2 and item_owner='"+search_char_name+"' and game_server='"+search_game_server+"' "
		+"	) a) b "
		+"	where rn>="+s_no+" and rn<="+e_no;
Statement stmt_char_market=conn.createStatement();
ResultSet rs_char_market=stmt_char_market.executeQuery(sql_char_market);
/* 선택된 캐릭터가 거래소에 등록한 아이템 목록 E */

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

/* 장비,소비,기타,설치,캐쉬 각각의 선택된 캐릭터의 아이템 목록 S */
/* 장비 S */
String sql_iteminfo_equip="select unq,"
					+"	replace(decode(item_volume,1,item_name,item_name||'('||item_volume||')'),' ','<br>') item_name,"
					+"	replace(replace(item_info,',','<br>'),' ','&nb') item_info,"
					+"	replace(replace(substr(replace(item_part,',','&nb'),instr(item_part,'-')+1),'(','&nb('),' ','&nb') item_part"
					+"	from item_info_maplestory "
					+search_str
					+" and item_part like '%장비%' and item_volume!='0'";
Statement stmt_equip=conn.createStatement();
ResultSet rs_iteminfo_equip=stmt_equip.executeQuery(sql_iteminfo_equip);
/* 장비 E */
/* 소비 S */
String sql_iteminfo_consume="select unq,"
					+"	replace(decode(item_volume,1,item_name,item_name||'('||item_volume||')'),' ','<br>') item_name,"
					+"	replace(replace(item_info,',','<br>'),' ','&nb') item_info,"
					+"	replace(replace(substr(replace(item_part,',','&nb'),instr(item_part,'-')+1),'(','&nb('),' ','&nb') item_part"
					+"	from item_info_maplestory "
					+search_str
					+" and item_part like '%소비%' and item_volume!='0'";
Statement stmt_consume=conn.createStatement();
ResultSet rs_iteminfo_consume=stmt_consume.executeQuery(sql_iteminfo_consume);
/* 소비 E */
/* 기타 S */
String sql_iteminfo_rest="select unq,"
					+"	replace(decode(item_volume,1,item_name,item_name||'('||item_volume||')'),' ','<br>') item_name,"
					+"	replace(replace(item_info,',','<br>'),' ','&nb') item_info,"
					+"	replace(replace(substr(replace(item_part,',','&nb'),instr(item_part,'-')+1),'(','&nb('),' ','&nb') item_part"
					+"	from item_info_maplestory "
					+search_str
					+" and item_part like '%기타%' and item_volume!='0'";
Statement stmt_rest=conn.createStatement();
ResultSet rs_iteminfo_rest=stmt_rest.executeQuery(sql_iteminfo_rest);
/* 기타 E */
/* 설치 S */
String sql_iteminfo_install="select unq,"
					+"	replace(decode(item_volume,1,item_name,item_name||'('||item_volume||')'),' ','<br>') item_name,"
					+"	replace(replace(item_info,',','<br>'),' ','&nb') item_info,"
					+"	replace(replace(substr(replace(item_part,',','&nb'),instr(item_part,'-')+1),'(','&nb('),' ','&nb') item_part"
					+"	from item_info_maplestory "
					+search_str
					+" and item_part like '%설치%' and item_volume!='0'";
Statement stmt_install=conn.createStatement();
ResultSet rs_iteminfo_install=stmt_install.executeQuery(sql_iteminfo_install);
/* 설치 E */
/* 캐쉬 S */
String sql_iteminfo_cash="select unq,"
					+"	replace(decode(item_volume,1,item_name,item_name||'('||item_volume||')'),' ','<br>') item_name,"
					+"	replace(replace(item_info,',','<br>'),' ','&nb') item_info,"
					+"	replace(replace(substr(replace(item_part,',','&nb'),instr(item_part,'-')+1),'(','&nb('),' ','&nb') item_part"
					+"	from item_info_maplestory "
					+search_str
					+" and item_part like '%캐쉬%' and item_volume!='0'";
Statement stmt_cash=conn.createStatement();
ResultSet rs_iteminfo_cash=stmt_cash.executeQuery(sql_iteminfo_cash);
/* 캐쉬 E */
/* 장비,소비,기타,설치,캐쉬 각각의 선택된 캐릭터의 아이템 목록 E */
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
		
		$("#equip").css("background-color","#424242");
		$("#equip").css("border","1px solid #424242");
		
		$("#equip_div").css("display","inline");
		$("#rest_div").css("display","none");
		$("#install_div").css("display","none");
		$("#cash_div").css("display","none");
		$("#consume_div").css("display","none");
		
		$("#game_server").change(function(){
			
			$("#frm_server_char").submit();
			
		});
		
		$("#char_name").change(function(){
			
			$("#frm_server_char").submit();
		});
		
		
});


function fn_change_itempage(type){
	if(type=="equip"){
		$(".li_marketSell").css("background-color","#1c1c1c")
		$(".li_marketSell").css("border","1px solid #424242");
		$("#equip").css("background-color","#424242");
		$("#equip").css("border","1px solid #424242");
		
		$("#consume_div").css("display","none");
		$("#rest_div").css("display","none");
		$("#install_div").css("display","none");
		$("#cash_div").css("display","none");
		
		$("#equip_div").css("display","inline");
		
	}
	else if(type=="consume"){
		$(".li_marketSell").css("background-color","#1c1c1c")
		$(".li_marketSell").css("border","1px solid #424242");
		$("#consume").css("background-color","#424242");
		$("#consume").css("border","1px solid #424242");
	
		$("#equip_div").css("display","none");
		$("#rest_div").css("display","none");
		$("#install_div").css("display","none");
		$("#cash_div").css("display","none");
		
		$("#consume_div").css("display","inline");
	}
	else if(type=="rest"){
		$(".li_marketSell").css("background-color","#1c1c1c")
		$(".li_marketSell").css("border","1px solid #424242");
		$("#rest").css("background-color","#424242");
		$("#rest").css("border","1px solid #424242");
		
		$("#consume_div").css("display","none");
		$("#equip_div").css("display","none");
		$("#install_div").css("display","none");
		$("#cash_div").css("display","none");
		
		$("#rest_div").css("display","inline");
	}
	else if(type=="install"){
		$(".li_marketSell").css("background-color","#1c1c1c")
		$(".li_marketSell").css("border","1px solid #424242");
		$("#install").css("background-color","#424242");
		$("#install").css("border","1px solid #424242");
		
		$("#consume_div").css("display","none");
		$("#rest_div").css("display","none");
		$("#equip_div").css("display","none");
		$("#cash_div").css("display","none");
		
		$("#install_div").css("display","inline");
	}
	else if(type=="cash"){
		$(".li_marketSell").css("background-color","#1c1c1c")
		$(".li_marketSell").css("border","1px solid #424242");
		$("#cash").css("background-color","#424242");
		$("#cash").css("border","1px solid #424242");
		
		$("#consume_div").css("display","none");
		$("#rest_div").css("display","none");
		$("#install_div").css("display","none");
		$("#equip_div").css("display","none");
		
		$("#cash_div").css("display","inline");
	}
	
}
function replaceAll(str, searchStr, replaceStr) {

	   return str.split(searchStr).join(replaceStr);
}
function fn_info(unq,name,part,info){
	name=replaceAll(name,"&nb","&nbsp;");
	name=replaceAll(name,"/","%");
	part=replaceAll(part,"&nb","&nbsp;");
	part=replaceAll(part,"br","<br>");
	part=replaceAll(part,"/","%");
	info=replaceAll(info,"&nb","&nbsp;");
	info=replaceAll(info,"br","<br>");
	info=replaceAll(info,"/","%");
	$("#item_name").html(name);
	$("#item_part").html(part);
	$("#item_info").html(info);
	$("#unq").val(unq);
	$("#sell_button").html("수량 : <input style='width:40px;text-align:right;margin-bottom:10px;' type='text' name='item_volume' id=\"item_volume\" value='1'><br> 가격 <br> <input style='width:80px;margin-top:5px;' type='text' name='item_price' id='item_price'><button type='button' id='btn_register' style='margin-top:10px;margin-left:10px;color:#ccc;background-color:#1c1c1c;border-radius:5px;border:1px solid #1c1c1c;width:60px;' onclick='fn_register()'>등록</button>")
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
	height:800px;
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
	height:60px;
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
	 font-size:12px;
}
.th_marketSell{
	border-top:1px solid #424242;
	padding:10px;
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
			<form name="frm_server_char" id="frm_server_char" method="post" action="marketSell_maplestory.jsp">
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
			<form id="frm_server_char_complete" method="post" action="marketComplete_maplestory.jsp">
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
			<div style="width:10%;margin-left:10px;float:left;">
			<ul style="list-style:none;margin-top:20px;width:50px;">
				<li class="li_marketSell" onclick="fn_change_itempage('equip')" id="equip">장비</li>
				<li class="li_marketSell" onclick="fn_change_itempage('consume')" id="consume">소비</li>
				<li class="li_marketSell" onclick="fn_change_itempage('rest')" id="rest">기타</li>
				<li class="li_marketSell" onclick="fn_change_itempage('install')" id="install">설치</li>
				<li class="li_marketSell" onclick="fn_change_itempage('cash')" id="cash">캐쉬</li>
			</ul>
			</div>
			<div id="equip_div" style="height:260px;width:55%;float:left;">
			<table style="margin-top:20px;margin-left:10px;width:550px;border-spacing:5px;">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<tr>
				<%
				int cnt=1;
				while(rs_iteminfo_equip.next()){
					if(cnt%5==1&&cnt!=1){
						%>
							</tr>
							<tr>
						<%
					}
					int unq=rs_iteminfo_equip.getInt("unq");
					String item_name=rs_iteminfo_equip.getString("item_name");
					String item_part=rs_iteminfo_equip.getString("item_part");
					String item_info=rs_iteminfo_equip.getString("item_info");
					
					String name=item_name.replace("<br>","&nb");
					String part=item_part.replace("<br>","br");
					String info=item_info.replace("<br>","br");
					name=name.replace("%","/");
					part=part.replace("%","/");
					info=info.replace("%","/");
				%>
					<td class="td_marketSell">
					<a href="javascript:fn_info('<%=unq %>','<%=name %>','<%=part %>','<%=info %>')" class="a_marketSell">
						<%=item_name %>
					</a>
					</td>
					
				<%
					cnt++;
				}
				if((cnt-1)%5!=0){
					for(int i=1;i<=5-(cnt-1)%5;i++){
					%>
						<td class="td_marketSell"></td>
					<%	
					}
				}
				%>
				</tr>
			</table>
			</div>
			<div id="consume_div" style="height:260px;width:55%;float:left;display:none;">
			<table style="margin-top:20px;margin-left:10px;width:550px;border-spacing:5px;">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<tr>
				<%
				cnt=1;
				while(rs_iteminfo_consume.next()){
					if(cnt%5==1&&cnt!=1){
						%>
							</tr>
							<tr>
						<%
					}
					int unq=rs_iteminfo_consume.getInt("unq");
					String item_name=rs_iteminfo_consume.getString("item_name");
					String item_part=rs_iteminfo_consume.getString("item_part");
					String item_info=rs_iteminfo_consume.getString("item_info");
					
					String name=item_name.replace("<br>","&nb");
					String part=item_part.replace("<br>","br");
					String info=item_info.replace("<br>","br");
					name=name.replace("%","/");
					part=part.replace("%","/");
					info=info.replace("%","/");
				%>
					<td class="td_marketSell">
					<a href="javascript:fn_info('<%=unq %>','<%=name %>','<%=part %>','<%=info %>')" class="a_marketSell">
						<%=item_name %>
					</a>
					</td>
				<%
					cnt++;
				}
				if((cnt-1)%5!=0){
					for(int i=1;i<=5-(cnt-1)%5;i++){
					%>
						<td class="td_marketSell"></td>
					<%	
					}
				}
				%>
				</tr>
			</table>
			</div>
			<div id="rest_div" style="height:260px;width:55%;float:left;display:none;">
			<table style="margin-top:20px;margin-left:10px;width:550px;border-spacing:5px;">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<tr>
				<%
				cnt=1;
				while(rs_iteminfo_rest.next()){
					if(cnt%5==1&&cnt!=1){
						%>
							</tr>
							<tr>
						<%
					}
					int unq=rs_iteminfo_rest.getInt("unq");
					String item_name=rs_iteminfo_rest.getString("item_name");
					String item_part=rs_iteminfo_rest.getString("item_part");
					String item_info=rs_iteminfo_rest.getString("item_info");
					
					String name=item_name.replace("<br>","&nb");
					String part=item_part.replace("<br>","br");
					String info=item_info.replace("<br>","br");
					name=name.replace("%","/");
					part=part.replace("%","/");
					info=info.replace("%","/");
				%>
					<td class="td_marketSell">
					<a href="javascript:fn_info('<%=unq %>','<%=name %>','<%=part %>','<%=info %>')" class="a_marketSell">
						<%=item_name %>
					</a>
					</td>
				<%
					cnt++;
				}
				if((cnt-1)%5!=0){
					for(int i=1;i<=5-(cnt-1)%5;i++){
					%>
						<td class="td_marketSell"></td>
					<%	
					}
				}
				%>
				</tr>
			</table>
			</div>
			<div id="install_div" style="height:260px;width:55%;float:left;">
			<table style="margin-top:20px;margin-left:10px;width:550px;border-spacing:5px;">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<tr>
				<%
				cnt=1;
				while(rs_iteminfo_install.next()){
					if(cnt%5==1&&cnt!=1){
						%>
							</tr>
							<tr>
						<%
					}
					int unq=rs_iteminfo_install.getInt("unq");
					String item_name=rs_iteminfo_install.getString("item_name");
					String item_part=rs_iteminfo_install.getString("item_part");
					String item_info=rs_iteminfo_install.getString("item_info");
					
					String name=item_name.replace("<br>","&nb");
					String part=item_part.replace("<br>","br");
					String info=item_info.replace("<br>","br");
					name=name.replace("%","/");
					part=part.replace("%","/");
					info=info.replace("%","/");
				%>
					<td class="td_marketSell">
					<a href="javascript:fn_info('<%=unq %>','<%=name %>','<%=part %>','<%=info %>')" class="a_marketSell">
						<%=item_name %>
					</a>
					</td>
				<%
					cnt++;
				}
				if((cnt-1)%5!=0){
					for(int i=1;i<=5-(cnt-1)%5;i++){
					%>
						<td class="td_marketSell"></td>
					<%	
					}
				}
				%>
				</tr>
			</table>
			</div>
			<div id="cash_div" style="height:260px;width:55%;float:left;">
			<table style="margin-top:20px;margin-left:10px;width:550px;border-spacing:5px;">
				<colgroup>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<tr>
				<%
				cnt=1;
				while(rs_iteminfo_cash.next()){
					if(cnt%5==1&&cnt!=1){
						%>
							</tr>
							<tr>
						<%
					}
					int unq=rs_iteminfo_cash.getInt("unq");
					String item_name=rs_iteminfo_cash.getString("item_name");
					String item_part=rs_iteminfo_cash.getString("item_part");
					String item_info=rs_iteminfo_cash.getString("item_info");
					
					String name=item_name.replace("<br>","&nb");
					String part=item_part.replace("<br>","br");
					String info=item_info.replace("<br>","br");
					name=name.replace("%","/");
					part=part.replace("%","/");
					info=info.replace("%","/");
				%>
					<td class="td_marketSell">
					<a href="javascript:fn_info('<%=unq %>','<%=name %>','<%=part %>','<%=info %>')" class="a_marketSell">
						<%=item_name %>
					</a>
					</td>
				<%
					cnt++;
				}
				if((cnt-1)%5!=0){
					for(int i=1;i<=5-(cnt-1)%5;i++){
					%>
						<td class="td_marketSell"></td>
					<%	
					}
				}
				%>
				</tr>
			</table>
			</div>
			<div style="height:240px;margin-top:20px;border-radius:10px;color:#ccc;width:30%;background-color:#585858;float:left;">
				<form id="frm_register">
				<input type="hidden" name="insert_game_server" value="<%=search_game_server%>">
				<input type="hidden" name="unq" id="unq">
				<div style="width:80%;margin:0 auto;margin-top:10px;" id="item_name">
				아이템을 선택해주세요.
				</div>
				<div style="width:80%;margin:0 auto;margin-top:10px;">
					<div id="item_part" style="width:90%;height:25px;float:left;">
						
					</div>
					<div style="width:60%;float:left;height:170px;font-size:10px;" id="item_info">
						
					</div>
					
					<div id="sell_button" style="width:35%;float:left;margin-left:5px;">
						
					</div>
				</div>
				</form>
			</div>
			<div style="width:100%;margin-top:20px;float:left;">
			<div style="text-align:center;margin-top:10px;margin-bottom:10px;">
				<a href="javascript:fn_page('1')"><img src="../images/market_firstpage.PNG"></a>
				<a href="javascript:fn_page('<%=before_page%>')"><img src="../images/market_beforepage.PNG"></a>
				<%=pageNo %>/<%=total_page %>
				<a href="javascript:fn_page('<%=after_page%>')"><img src="../images/market_afterpage.PNG"></a>
				<a href="javascript:fn_page('<%=total_page%>')"><img src="../images/market_lastpage.PNG"></a>
			</div>
			<form id="frm_page" method="post" action="marketSell_maplestory.jsp">
				<input type="hidden" name="pageNo" id="pageNo" value="<%=pageNo%>">
				<input type="hidden" name="game_server" value="<%=search_game_server%>">
				<input type="hidden" name="char_name" value="<%=search_char_name%>">
			</form>
				<table class="table_marketSell">
					<tr>
						<th class="th_marketSell">아이템 이름</th>
						<th class="th_marketSell">가격</th>
						<th class="th_marketSell">남은시간</th>
					</tr>
					<%
					Calendar cal1=Calendar.getInstance();
					long now_unix=cal1.getTimeInMillis();
					
					while(rs_char_market.next()){
						String item_name=rs_char_market.getString("item_name");
						String item_price=rs_char_market.getString("item_allprice");
						String rdate=rs_char_market.getString("rdate");
						String[] ar1=rdate.split(" ");
						cal1.set(Integer.parseInt(ar1[0]),Integer.parseInt(ar1[1])-1,Integer.parseInt(ar1[2]),Integer.parseInt(ar1[3]),Integer.parseInt(ar1[4]),Integer.parseInt(ar1[5]));
						long rdate_unix=cal1.getTimeInMillis();
						long limitTime=((rdate_unix-now_unix)/(1000*60*60));
					%>	
						<tr>
						<th class="th_marketSell"><%=item_name %></th>
						<th class="th_marketSell"><%=item_price %></th>
						<th class="th_marketSell"><%=limitTime %>시간</th>
						</tr>
					<%	
					}
					%>
				</table>
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
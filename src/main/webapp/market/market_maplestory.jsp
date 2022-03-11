<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
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
/* 등록한 게임아이디가 보유한 서버목록 가져오기 S */
String sql_server="select DISTINCT(game_server) game_server from gamechar "
				+"where game_name='메이플스토리' and p_gameid=(select game_id from gameid "
				+"where p_userid='"+user_id+"' and game_name='메이플스토리')";
Statement stmt2=conn.createStatement();
ResultSet rs_server=stmt2.executeQuery(sql_server);
/* 등록한 게임아이디가 보유한 서버목록 가져오기 E */


%>
				
<%
/* 아이템 목록 검색 S */
String search_type=request.getParameter("search_type");
String search_job=request.getParameter("search_job");
String search_part=request.getParameter("search_part");
String search_smallpart=request.getParameter("search_smallpart");
String search_item_name=request.getParameter("search_item_name");
String search_item_lev1=request.getParameter("search_item_lev1");
String search_item_lev2=request.getParameter("search_item_lev2");
String search_item_price1=request.getParameter("search_item_price1");
String search_item_price2=request.getParameter("search_item_price2");
String search_game_server=request.getParameter("game_server");
String search_char_name=request.getParameter("char_name");
String search_str="";
if(search_char_name==null){
	search_char_name="";
}
if(search_item_name==null){
	search_item_name="";
}
if(search_type==null||search_type.trim().equals("")){
	if(search_item_name==null||search_item_name==""){
		search_str="";
	}
	else{
		search_str=" and item_name like '%"+search_item_name+"%'";
	}
}
else if(search_type.equals("방어구")){
	String search_price_str="";
	String search_lev_str="";
	if(search_item_price1!=null&&!search_item_price1.trim().equals("")&&
			search_item_price2!=null&&!search_item_price2.trim().equals("")){
		search_price_str="	and item_price between "+search_item_price1+" and "+search_item_price2;
	}
	if(search_item_lev1!=null&&!search_item_lev1.trim().equals("")&&
			search_item_lev2!=null&&!search_item_lev2.trim().equals("")){
		search_lev_str="	and substr(item_part,instr(item_part,':','1','2')+1) between "+search_item_lev1+" and "+search_item_lev2;
	}
	
	
	search_str="	and item_part like '%장비%' and"
				+"	item_part not like '%무기%' and"
				+"	item_part like '%"+search_job+"%' and"
				+"	item_part like '%"+search_part+"%' and"
				+"	item_part like '%"+search_smallpart+"%' and"
				+"	item_name like '%"+search_item_name+"%'"
				+search_lev_str
				+search_price_str;
}
else if(search_type.equals("무기")){
	
	String search_price_str="";
	String search_lev_str="";
	if(search_item_price1!=null&&!search_item_price1.trim().equals("")&&
			search_item_price2!=null&&!search_item_price2.trim().equals("")){
		search_price_str="	and item_price between "+search_item_price1+" and "+search_item_price2;
	}
	if(search_item_lev1!=null&&!search_item_lev1.trim().equals("")&&
			search_item_lev2!=null&&!search_item_lev2.trim().equals("")){
		search_lev_str="	and substr(item_part,instr(item_part,':','1','2')+1) between "+search_item_lev1+" and "+search_item_lev2;
	}
	
	search_str="	and item_part like '%장비%' and"
			+"	item_part like '%무기%' and"
			+"	item_part like '%"+search_part+"%' and"
			+"	item_part like '%"+search_smallpart+"%' and"
			+"	item_name like '%"+search_item_name+"%'"
			+search_lev_str
			+search_price_str;
}
else if(search_type.equals("소비")){
	
	String search_price_str="";
	if(search_item_price1!=null&&!search_item_price1.trim().equals("")&&
			search_item_price2!=null&&!search_item_price2.trim().equals("")){
		search_price_str="	and item_price between "+search_item_price1+" and "+search_item_price2;
	}
	
	search_str="	and item_part like '%소비%' and"
			+"	item_part like '%"+search_part+"%' and"
			+"	item_part like '%"+search_smallpart+"%' and"
			+"	item_name like '%"+search_item_name+"%'"
			+search_price_str;
}
else if(search_type.equals("기타")){
	
	String search_price_str="";
	if(search_item_price1!=null&&!search_item_price1.trim().equals("")&&
			search_item_price2!=null&&!search_item_price2.trim().equals("")){
		search_price_str="	and item_price between "+search_item_price1+" and "+search_item_price2;
	}
	
	search_str="	and item_part like '%기타%' and"
			+"	item_part like '%"+search_part+"%' and"
			+"	item_part like '%"+search_smallpart+"%' and"
			+"	item_name like '%"+search_item_name+"%'"
			+search_price_str;
}
/* 아이템 목록 검색 E */
%>

<%
/* 페이지 처리 S */
int unit=8;
String pageNo=request.getParameter("pageNo");
if(pageNo==null||pageNo.equals("")){
	pageNo="1";
}

int s_no=(Integer.parseInt(pageNo)-1)*unit+1;
int e_no=s_no+(unit-1);

String sql_total="select count(*) total from market_maplestory "
		+"	where sell='N' and sysdate<=rdate+2 and game_server='"+search_game_server+"' "
		+search_str;
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
/* 페이지 처리 E */

/* 선택한 서버의 캐릭터 정보 S */
String sql_char="select char_name from gamechar "
		+"where game_name='메이플스토리' and game_server='"+search_game_server+"' "
		+" and p_gameid=(select game_id from gameid "
		+"where p_userid='"+user_id+"' and game_name='메이플스토리')";
Statement stmt3=conn.createStatement();
ResultSet rs_char=stmt3.executeQuery(sql_char);
/* 선택한 서버의 캐릭터 정보 E */
/* 선택한 캐릭터 정보 S */
String sql_charinfo="select to_char(char_money,'FM999,999,999,999,999,999,999') char_money from gamechar where char_name='"+search_char_name+"'";
Statement stmt4=conn.createStatement();
ResultSet rs_charinfo=stmt4.executeQuery(sql_charinfo);
String char_money="";
if(rs_charinfo.next()){
	char_money=rs_charinfo.getString("char_money");
}
/* 선택한 캐릭터 정보 E */

/* 거래소 아이템 목록 S */
String sql="select b.* from"
			+"	(select rownum rn,a.* from "
			+"	(select unq,"
			+"	decode(item_volume,1,item_name,item_name||'('||item_volume||')') item_name,"
			+"	to_char(decode(item_volume,1,item_price,item_price*item_volume),'FM999,999,999,999,999,999,999') item_allprice,"
			+"	decode(item_volume,1,'-',to_char(item_price,'FM999,999,999,999,999,999,999')) item_price,"
			+"	to_char(rdate+2,'yyyy mm dd hh24 mi ss') rdate,"
			+"	replace(item_info,',','<br>') item_info,"
			+"	replace(substr(replace(item_part,',','<br>'),instr(item_part,'-')+1),'(','<br>(') item_part"
			+"	from market_maplestory "
			+"	where sell='N' and sysdate<=rdate+2 and game_server='"+search_game_server+"' "
			+search_str
			+"	) a) b "
			+"	where rn>="+s_no+" and rn<="+e_no;
ResultSet rs=stmt.executeQuery(sql);
/* 거래소 아이템 목록 E */



%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	 
<script>
if((navigator.userAgent).indexOf("Chrome")>-1){
	document.write("<link rel='stylesheet' href='../css/aside_chrome.css'>");
}
else{
	document.write("<link rel='stylesheet' href='../css/aside_ie.css'>");
}

$(function(){
		
		$("body").css("width",screen.width-30);
	    
		$( "#accordion" ).accordion();
		
		
		//방어구
		var armor=["전체","모자","상의","한벌옷","하의","신발","장갑","방패","망토"];
		var accessory=["전체","얼굴장식","눈장식","귀고리","반지","펜던트","벨트","훈장","어깨장식","포켓아이템","뱃지","엠블렘","파워소스"];
		//무기
		var onehandweapon=["전체","샤이닝로드","소울슈터","데스페라도","에너지소드","한손검","한손도끼","한손둔기","단검","케인","완드","스태프","ESP리미터","체인","매직 건틀렛","부채","튜너","브레스 슈터"];
		var twohandweapon=["전체","두손검","두손도끼","두손둔기","창","폴암","활","석궁","아대","너클","건","듀얼보우건","핸드캐논","건틀렛 리볼버","에인션트 보우"];
		var subweapon=["전체","메달","로자리오","쇠사슬","마도서","화살깃","활골무","단검용 검집","블레이드","부적","리스트밴드","조준기","화약통","보석","무게추","문서","오브","마법화살","카드","여우구슬","화살촉","컨트롤러","매그넘","노바의 정수","소울링","체스피스","장약","무기 전송장치","매직 윙","패스","렐릭","선추","브레이슬릿","포스실드","소울실드","웨폰벨트","노리개"];
		//소비
		var recovery=["전체","회복 아이템","상태 이상 회복"];
		var alchemy=["전체","회복","비약","버프"];
		var spell=["전체","방어구/악세서리","무기","장비강화/잠재","백의/혼돈의 주문서","환생의 불꽃","펫 주문서","기타 주문서"];
		var proskillspell=["전체","장비 레시피","장신구 레시피","연금술 레시피"];
		var skillbook=["전체"];
		//기타
		var chair=["전체"];
		var proskill=["전체"];
		
		
		var changeArr=["전체"];
		//방어구 s
		if($("#frm_armor #search_part>option:selected").val()==""){
			changeArr=["전체"];
		}
		else if($("#frm_armor #search_part>option:selected").val()=="방어구"){
			changeArr=armor;
		}
		else if($("#frm_armor #search_part>option:selected").val()=="장신구"){
			changeArr=accessory;
		}
		
		$("#frm_armor #search_smallpart").empty();
		for(var i=0;i<changeArr.length;i++){
			
			if(i==0){
				var option = $("<option value=''>"+changeArr[i]+"</option>");
				$('#frm_armor #search_smallpart').append(option);
			}
			else{
				if($("#search_smallpart_return").val()==changeArr[i]){
					var option = $("<option value='"+changeArr[i]+"' selected>"+changeArr[i]+"</option>");
					$('#frm_armor #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_armor #search_smallpart').append(option);
				}
			}
			
		}
		
		$("#frm_armor #search_part").change(function(){
			
			
			if($("#frm_armor #search_part").val()==""){
				changeArr=["전체"];
			}
			else if($("#frm_armor #search_part").val()=="방어구"){
				changeArr=armor;
			}
			else if($("#frm_armor #search_part").val()=="장신구"){
				changeArr=accessory;
			}
			
			$("#frm_armor #search_smallpart").empty();
			for(var i=0;i<changeArr.length;i++){
				
				if(i==0){
					var option = $("<option value=''>"+changeArr[i]+"</option>");
					$('#frm_armor #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_armor #search_smallpart').append(option);
					
				}
			}
		});
		// 방어구 e
		
		// 무기 s
		if($("#frm_weapon #search_part>option:selected").val()==""){
			changeArr=["전체"];
		}
		else if($("#frm_weapon #search_part>option:selected").val()=="한손무기"){
			changeArr=onehandweapon;
		}
		else if($("#frm_weapon #search_part>option:selected").val()=="두손무기"){
			changeArr=twohandweapon;
		}
		else if($("#frm_weapon #search_part>option:selected").val()=="보조무기"){
			changeArr=subweapon;
		}
		
		$("#frm_weapon #search_smallpart").empty();
		
		for(var i=0;i<changeArr.length;i++){
			if(i==0){
				var option = $("<option value=''>"+changeArr[i]+"</option>");
				$('#frm_weapon #search_smallpart').append(option);
			}
			else{
				if($("#search_smallpart_return").val()==changeArr[i]){
					var option = $("<option value='"+changeArr[i]+"' selected>"+changeArr[i]+"</option>");
					$('#frm_weapon #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_weapon #search_smallpart').append(option);
				}
			}
			
		}
		
		$("#frm_weapon #search_part").change(function(){
			
			if($("#frm_weapon #search_part").val()==""){
				changeArr=["전체"];
			}
			else if($("#frm_weapon #search_part").val()=="한손무기"){
				changeArr=onehandweapon;
			}
			else if($("#frm_weapon #search_part").val()=="두손무기"){
				changeArr=twohandweapon;
			}
			else if($("#frm_weapon #search_part").val()=="보조무기"){
				changeArr=subweapon;
			}
			
			$("#frm_weapon #search_smallpart").empty();
			for(var i=0;i<changeArr.length;i++){
				
				if(i==0){
					var option = $("<option value=''>"+changeArr[i]+"</option>");
					$('#frm_weapon #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_weapon #search_smallpart').append(option);
					
				}
			}
		});
		// 무기 e
		
		// 소비 s
		if($("#frm_consume #search_part>option:selected").val()==""){
			changeArr=["전체"];
		}
		else if($("#frm_consume #search_part>option:selected").val()=="회복 아이템"){
			changeArr=recovery;
		}
		else if($("#frm_consume #search_part>option:selected").val()=="연금술 아이템"){
			changeArr=alchemy;
		}
		else if($("#frm_consume #search_part>option:selected").val()=="주문서"){
			changeArr=spell;
		}
		else if($("#frm_consume #search_part>option:selected").val()=="전문기술 레시피"){
			changeArr=proskillspell;
		}
		else if($("#frm_consume #search_part>option:selected").val()=="스킬북"){
			changeArr=skillbook;
		}
		
		
		$("#frm_consume #search_smallpart").empty();
		
		for(var i=0;i<changeArr.length;i++){
			if(i==0){
				var option = $("<option value=''>"+changeArr[i]+"</option>");
				$('#frm_consume #search_smallpart').append(option);
			}
			else{
				if($("#search_smallpart_return").val()==changeArr[i]){
					var option = $("<option value='"+changeArr[i]+"' selected>"+changeArr[i]+"</option>");
					$('#frm_consume #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_consume #search_smallpart').append(option);
				}
			}
			
		}
		
		$("#frm_consume #search_part").change(function(){
			
			if($("#frm_consume #search_part").val()==""){
				changeArr=["전체"];
			}
			else if($("#frm_consume #search_part").val()=="회복 아이템"){
				changeArr=recovery;
			}
			else if($("#frm_consume #search_part").val()=="연금술 아이템"){
				changeArr=alchemy;
			}
			else if($("#frm_consume #search_part").val()=="주문서"){
				changeArr=spell;
			}
			else if($("#frm_consume #search_part").val()=="전문기술 레시피"){
				changeArr=proskillspell;
			}
			else if($("#frm_consume #search_part").val()=="스킬북"){
				changeArr=skillbook;
			}
			
			$("#frm_consume #search_smallpart").empty();
			for(var i=0;i<changeArr.length;i++){
				
				if(i==0){
					var option = $("<option value=''>"+changeArr[i]+"</option>");
					$('#frm_consume #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_consume #search_smallpart').append(option);
					
				}
			}
		});
		// 소비 e
		
		// 기타 s
		if($("#frm_rest #search_part>option:selected").val()==""){
			changeArr=["전체"];
		}
		else if($("#frm_rest #search_part>option:selected").val()=="의자"){
			changeArr=chair;
		}
		else if($("#frm_rest #search_part>option:selected").val()=="전문기술"){
			changeArr=proskill;
		}
		
		
		
		$("#frm_rest #search_smallpart").empty();
		
		for(var i=0;i<changeArr.length;i++){
			if(i==0){
				var option = $("<option value=''>"+changeArr[i]+"</option>");
				$('#frm_rest #search_smallpart').append(option);
			}
			else{
				if($("#search_smallpart_return").val()==changeArr[i]){
					var option = $("<option value='"+changeArr[i]+"' selected>"+changeArr[i]+"</option>");
					$('#frm_rest #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_rest #search_smallpart').append(option);
				}
			}
			
		}
		
		$("#frm_rest #search_part").change(function(){
			
			if($("#frm_rest #search_part").val()==""){
				changeArr=["전체"];
			}
			else if($("#frm_rest #search_part").val()=="의자"){
				changeArr=chair;
			}
			else if($("#frm_rest #search_part").val()=="전문기술"){
				changeArr=proskill;
			}
			
			$("#frm_rest #search_smallpart").empty();
			for(var i=0;i<changeArr.length;i++){
				
				if(i==0){
					var option = $("<option value=''>"+changeArr[i]+"</option>");
					$('#frm_rest #search_smallpart').append(option);
				}
				else{
					var option = $("<option value='"+changeArr[i]+"'>"+changeArr[i]+"</option>");
					$('#frm_rest #search_smallpart').append(option);
					
				}
			}
		});
		// 기타 e
});
function fn_search(){
	var search_item_name=$("#search_text").val();
	location="market_maplestory.jsp?search_item_name="+search_item_name;
}
function fn_page(no){
	$("#pageNo").val(no);
	$("#frm_page").submit();
}
function fn_buy(){
	if($("#volume").val()==""){
		alert("수량을 정해주세요.");
		$("#volume").focus();
		return;
	}
	var formdata=$("#frm_buy").serialize();
	
	$.ajax({
		
		type:"post",
		url:"marketBuy_maplestory.jsp",
		data:formdata,
		datatype:"text",
		success:function(data){
			data=$.trim(data);
			if(data=="ok"){
				alert("구매 완료!");
				location.reload();
			}
			else if(data=="volume_err"){
				alert("수량을 다시 입력해주세요");
			}
			else if(data=="money_err"){
				alert("메소가 부족합니다.");
			}
			else if(data=="insert_err"){
				alert("구매 실패!!");
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
function fn_info(unq,name,info,part,cnt){
	
	var tr=$(".table1_market tr:eq("+cnt+")");
	for(var i=1;i<$(".table1_market tr").length;i++){
		if(i!=cnt){
			$(".table1_market tr:eq("+i+")").css("background-color","#585858");
		}
		else{
			$(".table1_market tr:eq("+i+")").css("background-color","#2E64FE");
		}
	}
	$("#unq").val(unq);
	$("#div_info").html("<div style='float:left;'><div style='margin-top:20px;margin-left:40px;'>"+name+"</div><div style='width:80%;float:left;margin-top:20px;margin-left:40px;'>"+part+"</div></div><div style='float:left;font-size:10px;margin-top:20px;margin-left:40px;'>"+info+"</div><div style='float:left;margin-top:20px;margin-left:40px;'>수량<input type='text' name='volume' id='volume' value='1' style='width:40px;margin:10px;'><button type='button' style='margin:10px;'>찜하기</button><button type='button' onclick='fn_buy()'>구매하기</button></div>");
	
}
</script>
<%
if(search_type==null||search_type.equals("")||search_type.equals("방어구")){
%>
	
	<script>
		$(function(){
			
			$("#armor_field").click();
		});
	</script>
<%
}
else if(search_type.equals("무기")){
%>
	
	<script>
		$(function(){
			
			$("#weapon_field").click();
		});
	</script>
<%
}
else if(search_type.equals("소비")){
%>	
	<script>
		$(function(){
			
			$("#consume_field").click();
		});
	</script>
<%
}
else if(search_type.equals("기타")){
%>	
	<script>
		$(function(){
			
			$("#rest_field").click();
		});
	</script>
<%
}
%>
<script>
$(function(){
	$("#game_server").change(function(){
		
		$("#frm_server_char").submit();
		
	});
	
	$("#char_name").change(function(){
		
		$("#frm_server_char").submit();
	});
});
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
.table1_market{
	margin-left:10px;
	width:90%;
	border-collapse:collapse;
	border:1px solid #424242;
	color:#ccc;
	background-color:#585858;
	font-size:12px;
}
.th_market{
	border-top:1px solid #424242;
	padding:10px;
	
}
select{
	height:25px;
	border-radius:5px;
	background-color:#1C1C1C;
	border:1px solid #1c1c1c;
	color:#ccc;
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
			<form name="frm_server_char" id="frm_server_char" method="post" action="market_maplestory.jsp">
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
					<input type="text" id="search_item_name" name="search_item_name" value="<%if(search_type==null||search_type.equals("")){out.print(search_item_name);} %>">
				</div>
				</form>
				<div class="div3_market">
					<%=search_char_name %> 
					<input type="text" readonly name="my_money" id="my_money" value="<%=char_money%>">
				</div>
			</div>
			<%@ include file="../include/marketMenu_maplestory.jsp" %>
			<!-- 상세검색 s -->
			<input type="hidden" name="search_smallpart_return" id="search_smallpart_return" value="<%=search_smallpart%>">
			<div id="accordion" style="width:25%;border-radius:5px;margin-top:10px;float:left;margin-left:50px;">
				<h3 id="armor_field">방어구</h3>
				<div style="background-color:#585858;">
					<div style="color:#ccc;height:520px;">
						<form name="frm_armor" id="frm_armor" method="post" action="market_maplestory.jsp">
						<input type="hidden" name="game_server" id="game_server" value="<%=search_game_server%>">
						<input type="hidden" name="char_name" id="char_name" value="<%=search_char_name%>">
						<input type="hidden" name="search_type" id="search_type" value="방어구">
						<div>아이템분류</div>
						<select name="search_job" id="search_job" style="width:100%;margin-bottom:10px;margin-top:10px;">
							<option value="" <%if(search_job==null||search_job.equals("")){out.print("selected");} %>>전체</option>
							<option value="전사" <%if(search_job!=null&&search_job.equals("전사")){out.print("selected");} %>>전사</option>
							<option value="마법사" <%if(search_job!=null&&search_job.equals("마법사")){out.print("selected");} %>>마법사</option>
							<option value="궁수" <%if(search_job!=null&&search_job.equals("궁수")){out.print("selected");} %>>궁수</option>
							<option value="도적" <%if(search_job!=null&&search_job.equals("도적")){out.print("selected");} %>>도적</option>
						</select>
						<select name="search_part" id="search_part" style="width:46%;">
							<option value="" <%if(search_part==null||search_part.equals("")){out.print("selected");} %>>전체</option>
							<option value="방어구" <%if(search_part!=null&&search_part.equals("방어구")){out.print("selected");} %>>방어구</option>
							<option value="장신구" <%if(search_part!=null&&search_part.equals("장신구")){out.print("selected");} %>>장신구</option>
						</select>
						<select id="search_smallpart" name="search_smallpart" style="width:46%;margin-left:12px;">
							<option value="" <%if(search_smallpart==null||search_smallpart.equals("")){out.print("selected");} %>>전체</option>
						</select>
						<div style="margin-top:10px;">
						<hr style="border:1px dashed;">
						<div style="width:38%;float:left;margin-top:5px;">아이템이름</div>
						<input type="text" id="search_item_name" name="search_item_name" value="<%if(search_type!=null&&search_type.equals("방어구")){out.print(search_item_name);} %>" style="width:56%;margin-top:5px;">
						<div style="width:38%;float:left;margin-top:5px;">레벨범위</div>
						<input type="text" id="search_item_lev1" name="search_item_lev1" value="<%if(search_type!=null&&search_type.equals("방어구")){out.print(search_item_lev1);} %>" style="width:23%;margin-top:5px;">
						-
						<input type="text" id="search_item_lev2" name="search_item_lev2" value="<%if(search_type!=null&&search_type.equals("방어구")){out.print(search_item_lev2);} %>" style="width:23%;margin-top:5px;">
						<div style="width:38%;float:left;margin-top:5px;">가격</div>
						<input type="text" id="search_item_price1" name="search_item_price1" value="<%if(search_type!=null&&search_type.equals("방어구")){out.print(search_item_price1);} %>" style="width:23%;margin-top:5px;">
						-
						<input type="text" id="search_item_price2" name="search_item_price2" value="<%if(search_type!=null&&search_type.equals("방어구")){out.print(search_item_price2);} %>" style="width:23%;margin-top:5px;">
						</div>
						<div style="margin-top:10px;text-align:center;">
						<hr style="border:1px dashed;margin-bottom:10px;">
						<button type="reset" style="border-radius:5px;background-color:#848484;color:#ccc;">초기화</button>
						<button type="submit" style="border-radius:5px;background-color:#58FA58;color:#fff;">검색시작</button>
						</div>
						</form>
					</div>
				</div>
				<h3 id="weapon_field">무기</h3>
				<div style="background-color:#585858;" >
					<div style="color:#ccc;">
						<form id="frm_weapon" method="post" action="market_maplestory.jsp">
						<input type="hidden" name="game_server" id="game_server" value="<%=search_game_server%>">
						<input type="hidden" name="char_name" id="char_name" value="<%=search_char_name%>">
						<input type="hidden" name="search_type" id="search_type" value="무기">
						<div>아이템분류</div>
						<select id="search_part" name="search_part" style="width:46%;margin-top:10px;">
							<option value="" <%if(search_part==null||search_part.equals("")){out.print("selected");} %>>전체</option>
							<option value="한손무기" <%if(search_part!=null&&search_part.equals("한손무기")){out.print("selected");} %>>한손무기</option>
							<option value="두손무기" <%if(search_part!=null&&search_part.equals("두손무기")){out.print("selected");} %>>두손무기</option>
							<option value="보조무기" <%if(search_part!=null&&search_part.equals("보조무기")){out.print("selected");} %>>보조무기</option>
						</select>
						<select id="search_smallpart" name="search_smallpart" style="width:46%;margin-left:12px;margin-top:10px;">
							<option value="">전체</option>
						</select>
						<div style="margin-top:10px;">
						<hr style="border:1px dashed;">
						<div style="width:38%;float:left;margin-top:5px;">아이템이름</div>
						<input type="text" id="search_item_name" name="search_item_name"  value="<%if(search_type!=null&&search_type.equals("무기")){out.print(search_item_name);} %>" style="width:56%;margin-top:5px;">
						<div style="width:38%;float:left;margin-top:5px;">레벨범위</div>
						<input type="text" id="search_item_lev1" name="search_item_lev1" value="<%if(search_type!=null&&search_type.equals("무기")){out.print(search_item_lev1);} %>" style="width:23%;margin-top:5px;">
						-
						<input type="text" id="search_item_lev2" name="search_item_lev2" value="<%if(search_type!=null&&search_type.equals("무기")){out.print(search_item_lev2);} %>" style="width:23%;margin-top:5px;">
						<div style="width:38%;float:left;margin-top:5px;">가격</div>
						<input type="text" id="search_item_price1" name="search_item_price1" value="<%if(search_type!=null&&search_type.equals("무기")){out.print(search_item_price1);} %>" style="width:23%;margin-top:5px;">
						-
						<input type="text" id="search_item_price2" name="search_item_price2" value="<%if(search_type!=null&&search_type.equals("무기")){out.print(search_item_price2);} %>" style="width:23%;margin-top:5px;">
						</div>
						<div style="margin-top:10px;text-align:center;">
						<hr style="border:1px dashed;margin-bottom:10px;">
						<button type="reset" style="border-radius:5px;background-color:#848484;color:#ccc;">초기화</button>
						<button type="submit" style="border-radius:5px;background-color:#58FA58;color:#fff;">검색시작</button>
						</div>
						</form>
					</div>
				</div>
				<h3 id="consume_field">소비아이템</h3>
				<div style="background-color:#585858;">
					<div style="color:#ccc;">
						<form id="frm_consume" method="post" action="market_maplestory.jsp">
						<input type="hidden" name="game_server" id="game_server" value="<%=search_game_server%>">
						<input type="hidden" name="char_name" id="char_name" value="<%=search_char_name%>">
						<input type="hidden" name="search_type" id="search_type" value="소비">
						<div>아이템분류</div>
						<select id="search_part" name="search_part" style="width:100%;margin-bottom:10px;margin-top:10px;">
							<option value="" <%if(search_part==null||search_part.equals("")){out.print("selected");} %>>전체</option>
							<option value="회복 아이템" <%if(search_part!=null&&search_part.equals("회복 아이템")){out.print("selected");} %>>회복 아이템</option>
							<option value="연금술 아이템" <%if(search_part!=null&&search_part.equals("연금술 아이템")){out.print("selected");} %>>연금술 아이템</option>
							<option value="주문서" <%if(search_part!=null&&search_part.equals("주문서")){out.print("selected");} %>>주문서</option>
							<option value="전문기술 레시피" <%if(search_part!=null&&search_part.equals("전문기술 레시피")){out.print("selected");} %>>전문기술 레시피</option>
							<option value="스킬북" <%if(search_part!=null&&search_part.equals("스킬북")){out.print("selected");} %>>스킬북</option>
							<option value="기타" <%if(search_part!=null&&search_part.equals("기타")){out.print("selected");} %>>기타</option>
						</select>
						<div>세부검색</div>
						<select id="search_smallpart" name="seach_smallpart" style="width:100%;">
							<option value="">전체</option>
						</select>
						<div style="margin-top:10px;">
						<hr style="border:1px dashed;">
						<div style="width:38%;float:left;margin-top:5px;">아이템이름</div>
						<input type="text" id="search_item_name" name="search_item_name" value="<%if(search_type!=null&&search_type.equals("소비")){out.print(search_item_name);} %>" style="width:56%;margin-top:5px;">
						<div style="width:38%;float:left;margin-top:5px;">가격</div>
						<input type="text" id="search_item_price1" name="search_item_price1" value="<%if(search_type!=null&&search_type.equals("소비")){out.print(search_item_price1);} %>" style="width:23%;margin-top:5px;">
						-
						<input type="text" id="search_item_price2" name="search_item_price2" value="<%if(search_type!=null&&search_type.equals("소비")){out.print(search_item_price2);} %>" style="width:23%;margin-top:5px;">
						</div>
						<div style="margin-top:10px;text-align:center;">
						<hr style="border:1px dashed;margin-bottom:10px;">
						<button type="reset" style="border-radius:5px;background-color:#848484;color:#ccc;">초기화</button>
						<button type="submit" style="border-radius:5px;background-color:#58FA58;color:#fff;">검색시작</button>
						</div>
						</form>
					</div>
				</div>
				<h3 id="rest_field">기타아이템</h3>
				<div style="background-color:#585858;">
					<div style="color:#ccc;">
						<form id="frm_rest" method="post" action="market_maplestory.jsp">
						<input type="hidden" name="game_server" id="game_server" value="<%=search_game_server%>">
						<input type="hidden" name="char_name" id="char_name" value="<%=search_char_name%>">
						<input type="hidden" name="search_type" id="search_type" value="기타">
						<div>아이템분류</div>
						<select id="search_part" name="search_part" style="width:100%;margin-bottom:10px;margin-top:10px;">
							<option value="" <%if(search_part==null||search_part.equals("")){out.print("selected");} %>>전체</option>
							<option value="의자" <%if(search_part!=null&&search_part.equals("의자")){out.print("selected");} %>>의자</option>
							<option value="전문기술" <%if(search_part!=null&&search_part.equals("전문기술")){out.print("selected");} %>>전문기술</option>
						</select>
						<div>세부검색</div>
						<select id="search_smallpart" name="search_smallpart" style="width:100%;">
							<option value="">전체</option>
						</select>
						<div style="margin-top:10px;">
						<hr style="border:1px dashed;">
						<div style="width:38%;float:left;margin-top:5px;">아이템이름</div>
						<input type="text" id="search_item_name" name="search_item_name" value="<%if(search_type!=null&&search_type.equals("기타")){out.print(search_item_name);} %>" style="width:56%;margin-top:5px;">
						<div style="width:38%;float:left;margin-top:5px;">가격</div>
						<input type="text" id="search_item_price1" name="search_item_price1" value="<%if(search_type!=null&&search_type.equals("기타")){out.print(search_item_price1);} %>" style="width:23%;margin-top:5px;">
						-
						<input type="text" id="search_item_price2" name="search_item_price2" value="<%if(search_type!=null&&search_type.equals("기타")){out.print(search_item_price2);} %>" style="width:23%;margin-top:5px;">
						</div>
						<div style="margin-top:10px;text-align:center;">
						<hr style="border:1px dashed;margin-bottom:10px;">
						<button type="reset" style="border-radius:5px;background-color:#848484;color:#ccc;">초기화</button>
						<button type="submit" style="border-radius:5px;background-color:#58FA58;color:#fff;">검색시작</button>
						</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 상세검색 e -->
			<div style="width:70%;height:20px;margin-top:20px;">
				<div style="float:left;margin-left:10px;width:250px;">|검색결과</div> 
				<div>
					<a href="javascript:fn_page('1')"><img src="../images/market_firstpage.PNG"></a>
					<a href="javascript:fn_page('<%=before_page%>')"><img src="../images/market_beforepage.PNG"></a>
					<%=pageNo %>/<%=total_page %>
					<a href="javascript:fn_page('<%=after_page%>')"><img src="../images/market_afterpage.PNG"></a>
					<a href="javascript:fn_page('<%=total_page%>')"><img src="../images/market_lastpage.PNG"></a>
				</div> 
				<form id="frm_page" method="post" action="market_maplestory.jsp">
				<input type="hidden" name="pageNo" id="pageNo" value="<%=pageNo%>">
				<input type="hidden" name="game_server" value="<%=search_game_server%>">
				<input type="hidden" name="char_name" value="<%=search_char_name%>">
				<input type="hidden" name="search_type" value="<%=search_type%>">
				<input type="hidden" name="search_job" value="<%=search_job%>">
				<input type="hidden" name="search_part" value="<%=search_part%>">
				<input type="hidden" name="search_smallpart" value="<%=search_smallpart%>">
				<input type="hidden" name="search_item_name" value="<%=search_item_name%>">
				<input type="hidden" name="search_item_lev1" value="<%=search_item_lev1%>">
				<input type="hidden" name="search_item_lev2" value="<%=search_item_lev2%>">
				<input type="hidden" name="search_item_price1" value="<%=search_item_price1%>">
				<input type="hidden" name="search_item_price2" value="<%=search_item_price2%>">
			</form>
			</div>
			<div style="width:70%;float:left;">
				<table class="table1_market">
				<colgroup>
					<col width="35%">
					<col width="25%">
					<col width="25%">
					<col width="15%">
				</colgroup>
				<tr>
					<th class="th_market">아이템 이름</th>
					<th class="th_market">가격</th>
					<th class="th_market">개당 가격</th>
					<th class="th_market">남은시간</th>
				</tr>
				<%
				Calendar cal1=Calendar.getInstance();
				long now_unix=cal1.getTimeInMillis();
				int cnt=1;
				while(rs.next()){
					String unq=rs.getString("unq");
					String item_name=rs.getString("item_name");
					String item_allprice=rs.getString("item_allprice");
					String item_price=rs.getString("item_price");
					String rdate=rs.getString("rdate");
					String item_info=rs.getString("item_info");
					String item_part=rs.getString("item_part");
					String[] ar1=rdate.split(" ");
					cal1.set(Integer.parseInt(ar1[0]),Integer.parseInt(ar1[1])-1,Integer.parseInt(ar1[2]),Integer.parseInt(ar1[3]),Integer.parseInt(ar1[4]),Integer.parseInt(ar1[5]));
					long rdate_unix=cal1.getTimeInMillis();
					long limitTime=((rdate_unix-now_unix)/(1000*60*60));
				%>
				<tr style="cursor:pointer;" onclick="fn_info('<%=unq %>','<%=item_name%>','<%=item_info%>','<%=item_part%>','<%=cnt%>')">
					<td class="th_market"><%=item_name %></td>
					<th class="th_market" style="font-size:11px;"><%=item_allprice %></th>
					<th class="th_market"><%=item_price %></th>
					<th class="th_market"><%=limitTime%>시간</th>
				</tr>
				<%
					cnt++;
				}
				%>
				</table>
				<form id="frm_buy">
				<input type="hidden" name="unq" id="unq">
				<input type="hidden" name="game_server" value="<%=search_game_server%>">
				<input type="hidden" name="char_name" value="<%=search_char_name%>">
				<div id="div_info" style="color:#ccc;width:90%;height:200px;margin-bottom:20px;margin-top:10px;margin-left:10px;border:1px solid #424242;border-radius:5px;background-color:#086A87">
					
				</div>
				</form>
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
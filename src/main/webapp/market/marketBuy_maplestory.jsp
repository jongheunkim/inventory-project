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
String unq=request.getParameter("unq");
String volume=request.getParameter("volume");
String game_server=request.getParameter("game_server");
String char_name=request.getParameter("char_name");
String msg="ok";

String sql_item_info="select item_price,item_unq,item_volume,item_name,item_info,item_part,item_owner from market_maplestory where unq='"+unq+"'";
ResultSet rs_item_info=stmt.executeQuery(sql_item_info);
long item_price=0;
int item_volume=0;
int item_unq=0;
String item_name="";
String item_info="";
String item_part="";
String item_owner="";
if(rs_item_info.next()){
	item_price=rs_item_info.getLong("item_price");
	item_unq=rs_item_info.getInt("item_unq");
	item_volume=rs_item_info.getInt("item_volume");
	item_name=rs_item_info.getString("item_name");
	item_info=rs_item_info.getString("item_info");
	item_part=rs_item_info.getString("item_part");
	item_owner=rs_item_info.getString("item_owner");
}
else{
	msg="err";
%>
<%=msg %>
<%
	return;
}

if(item_volume<Integer.parseInt(volume)||Integer.parseInt(volume)<=0){
	msg="volume_err";
%>
<%=msg %>
<%
	return;
}

String sql_charinfo="select char_money from gamechar where char_name='"+char_name+"'";
Statement stmt4=conn.createStatement();
ResultSet rs_charinfo=stmt4.executeQuery(sql_charinfo);
long char_money=0;
if(rs_charinfo.next()){
	char_money=rs_charinfo.getLong("char_money");
}
long allprice=item_price*Integer.parseInt(volume);
if(allprice>char_money){
	msg="money_err";
%>
<%=msg %>
<%
	return;
}
String sql="";
String sql_new="";
if(item_volume==Integer.parseInt(volume)){
	sql="update market_maplestory set sell='Y',rdate=sysdate,item_owner='"+item_owner+"-판매' where unq='"+unq+"'";
	int rs=stmt.executeUpdate(sql);
	sql_new="insert into market_maplestory(unq,"
											+"game_server,"
											+"item_unq,"
											+"item_name,"
											+"item_info,"
											+"item_part,"
											+"item_owner,"
											+"item_price,"
											+"item_volume,"
											+"sell,"
											+"rdate) "
								+"	values(market_maplestory_seq.nextval,"
												+"'"+game_server+"',"
												+"'"+item_unq+"',"
												+"'"+item_name+"',"
												+"'"+item_info+"',"
												+"'"+item_part+"',"
												+"'"+char_name+"-구매',"
												+"'"+item_price+"',"
												+"'"+volume+"',"
												+"'Y',"
												+"sysdate)";
	int rs_new=stmt.executeUpdate(sql_new);
	if(rs!=1||rs_new!=1){
		msg="insert_err";
%>
<%=msg %>
<%
	return;
	}
}
else if(item_volume!=Integer.parseInt(volume)){
	int cnt=item_volume-Integer.parseInt(volume);
	sql="update market_maplestory set item_volume='"+cnt+"' where unq='"+unq+"'";
	int rs=stmt.executeUpdate(sql);
	sql_new="insert into market_maplestory(unq,"
										+"game_server,"
										+"item_unq,"
										+"item_name,"
										+"item_info,"
										+"item_part,"
										+"item_owner,"
										+"item_price,"
										+"item_volume,"
										+"sell,"
										+"rdate) "
							+"	values(market_maplestory_seq.nextval,"
											+"'"+game_server+"',"
											+"'"+item_unq+"',"
											+"'"+item_name+"',"
											+"'"+item_info+"',"
											+"'"+item_part+"',"
											+"'"+char_name+"-구매',"
											+"'"+item_price+"',"
											+"'"+volume+"',"
											+"'Y',"
											+"sysdate)";
	int rs_new=stmt.executeUpdate(sql_new);
	sql_new="insert into market_maplestory(unq,"
											+"game_server,"
											+"item_unq,"
											+"item_name,"
											+"item_info,"
											+"item_part,"
											+"item_owner,"
											+"item_price,"
											+"item_volume,"
											+"sell,"
											+"rdate) "
								+"	values(market_maplestory_seq.nextval,"
												+"'"+game_server+"',"
												+"'"+item_unq+"',"
												+"'"+item_name+"',"
												+"'"+item_info+"',"
												+"'"+item_part+"',"
												+"'"+item_owner+"-판매',"
												+"'"+item_price+"',"
												+"'"+volume+"',"
												+"'Y',"
												+"sysdate)";
	int rs_new2=stmt.executeUpdate(sql_new);
	if(rs!=1||rs_new!=1||rs_new2!=1){
		msg="insert_err";
%>
<%=msg %>
<%
		return;	
	}
}
long money=char_money-allprice;
String sql_charmoney="update gamechar set char_money='"+money+"' where char_name='"+char_name+"'";
int rs_charmoney=stmt.executeUpdate(sql_charmoney);
%>
<%=msg%>
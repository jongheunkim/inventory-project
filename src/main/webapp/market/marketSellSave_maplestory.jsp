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
String item_volume=request.getParameter("item_volume");
String item_price=request.getParameter("item_price");
String game_server=request.getParameter("insert_game_server");

String sql_item="select item_name,item_part,item_info,item_owner,item_volume"
				+"	from item_info_maplestory where unq='"+unq+"'";
ResultSet rs_item=stmt.executeQuery(sql_item);

String item_name_select="";
String item_part_select="";
String item_info_select="";
String item_owner_select="";
int item_volume_select=0;

String msg="ok";

if(rs_item.next()){
	item_name_select=rs_item.getString("item_name");
	item_part_select=rs_item.getString("item_part");
	item_info_select=rs_item.getString("item_info");
	item_owner_select=rs_item.getString("item_owner");
	item_volume_select=rs_item.getInt("item_volume");
}
else{
	msg="unexit_item";
%>
<%=msg %>
<%
	return;
}
if(Integer.parseInt(item_volume)>item_volume_select){
	msg="volume_err";
%>
<%=msg %>
<%
	return;
}

String sql="insert into market_maplestory(unq,"
									+"game_server,"
									+"item_unq,"
									+"item_name,"
									+"item_info,"
									+"item_part,"
									+"item_owner,"
									+"item_price,"
									+"item_volume,"
									+"rdate) "
						+"	values(market_maplestory_seq.nextval,"
										+"'"+game_server+"',"
										+"'"+unq+"',"
										+"'"+item_name_select+"',"
										+"'"+item_info_select+"',"
										+"'"+item_part_select+"',"
										+"'"+item_owner_select+"',"
										+"'"+item_price+"',"
										+"'"+item_volume+"',"
										+"sysdate)";
int rs=stmt.executeUpdate(sql);
if(rs==0){
	msg="insert_err";
}
else{
	int cnt=item_volume_select-Integer.parseInt(item_volume);
	String sql_update="update item_info_maplestory set item_volume='"+cnt+"' where unq='"+unq+"'";
	int rs_update=stmt.executeUpdate(sql_update);
}
%>
<%=msg %>
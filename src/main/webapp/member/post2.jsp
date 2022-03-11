<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- DB 연결 -->
<%@ include file="../include/dbcon.jsp" %>
<%@ page import="conn.ConOracle" %> 

<!-- 파라메터 값 받기 -->
<%
String dong = request.getParameter("dong");

if( dong == null || dong.trim().equals("") ) {
%>
		<script>
		alert("검색 단어를 입력해주세요.");
		history.back();
		</script>
<%
	return;
}
%>

<!-- 검색 단어를 이용한 SQL 작성, 적용 -->
<%
String sql2 = " select count(*) total from post "
			+ "	   where a4 like '%"+dong+"%' or a5 like '%"+dong+"%' ";
ResultSet rs2 = stmt.executeQuery(sql2);
rs2.next();
int total = rs2.getInt("total");

String sql = "select a1, a2||' '||a3||' '||a4||' '||a5||' '||a6||' '||a7||' '||a8 addr  from post "
			+ "	 where a4 like '%"+dong+"%' or a5 like '%"+dong+"%' ";
ResultSet rs = stmt.executeQuery(sql);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script>
function fn_action() {

	    //address = "137757 서울특별시 서초구 서초3동     아크리스빌딩";
		var address = document.frm.address.value;
		//address = address.replace("  "," ");
		//alert(address);
		
		// 우편번호, 주소 분리
		//var zipcode = address.substring(0,6);
		//var addr    = address.substring(7);
		
		var array   = address.split(" ");
		var zipcode = array[0];
		var addr    = address.replace(zipcode+" ","");
		
		// 우편번호 적용
		opener.document.frm.zipcode.value = zipcode;
		// 주소 적용
		opener.document.frm.addr1.value = addr;
		// 창 닫기
		document.frm.submit();
		self.close();
}
</script>


<body>

<div style="width:490px;
			height:250px;
			font-size:12px;
			font-family:'맑은 고딕';
			background-color:skyblue;
			text-align:center;">
		
		<p>&nbsp;</p>
		<p style="text-align:left;">&nbsp;&nbsp;검색결과 총 : <%=total %>건 </p>
		
		
		<%
		if( total > 0 ) {
		%>
		
			<form name="frm" method="post" action="">
			
			<select name="address">
			
			<%
			while( rs.next() ) {
				/*String a1 = rs.getString("a1");
				String a2 = rs.getString("a2");
				String a3 = rs.getString("a3");
				String a4 = rs.getString("a4");
				String a5 = rs.getString("a5");
				String a6 = rs.getString("a6");
				String a7 = rs.getString("a7");
				String a8 = rs.getString("a8");
				
				if( a5 == null ) a5 = "";
				if( a6 == null ) a6 = "";
				if( a7 == null ) a7 = "";
				if( a8 == null ) a8 = "";
				
				String addr = a2+" "+a3+" "+a4+" "+a5+" "+a6+" "+a7+" "+a8;
				*/
				String a1 = rs.getString("a1");
				String addr = rs.getString("addr");
			%>
				<option value="<%=a1 %> <%=addr %>">[<%=a1 %>] <%=addr %></option>
		
			<%
			}
			%>
				
			</select>
			
			<p style="text-align:center;">
				<button type="button" onclick="fn_action()">적용</button>
				<button type="button" onclick="self.close()">닫기</button>
			</p>	
		<%
		} else {
		%>
			<p style="margin-top:30px;">
				<%=dong %>(는)은 검색되지 않았습니다. <br><br>
				<button type="button" onclick="self.close()">닫기</button>
			</p>
		<%
		}
		%>

		</form>
</div>

</body>
</html>

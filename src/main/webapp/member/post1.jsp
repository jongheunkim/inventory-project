<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="width:490px;
			height:250px;
			font-size:12px;
			font-family:'맑은 고딕';
			background-color:skyblue;
			text-align:center;">
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		<p>
			찾으려는 동(읍/면/리)을 입력해주세요. <br>
			예: 서초동 검색은 [서초] 입력 후 검색 
		</p>
		<form name="frm" method="post" action="post2.jsp">
			<input type="text" name="dong">
			<button type="submit">검색</button>
		</form>
</div>

</body>
</html>


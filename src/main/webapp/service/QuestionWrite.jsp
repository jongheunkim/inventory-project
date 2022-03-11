<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function fn_submit(){
		
		document.frm.submit();
	}
</script>
<body>
<div style = "width:600px; margin:0 auto;">	
<form name="frm" method="post" action="QuestionWriteSave.jsp">
<table class="table1" align="center">
<caption class="caption1">공지사항 등록화면</caption>
	<colgroup>
		<col width="25%"/>
		<col width="*"/>
	</colgroup>
	<tr>
		<th class="th1">제목</th>
		<td class="td1" style="text-align:left;">
			<input type="text" name="title" class="input1">
		</td>
	</tr>
	<tr>
		<th class="th1">카테고리</th>
		<td class="td1" style="text-align:left;">
			<select name="category">
				<option value="일반">일반</option>
				<option value="마일리지">마일리지</option>
				<option value="물품판매">물품판매</option>
				<option value="물품구매">물품구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<th class="th1">내용</th>
		<td class="td1" style="text-align:left;">
			<textarea name="content" class="textarea1"></textarea>
		</td>
	</tr>
	<tr>
		<th colspan="2" height="40">
			<button type="submit" onclick="fn_submit();return false;" class="button1">저장</button>
			<button type="reset" class="button1">취소</button>
		</th>
	</tr>
</table>
</form>
</div>
</body>
</html>
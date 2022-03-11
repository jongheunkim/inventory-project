<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 	      
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
</head>
<style>
		

</style>
<script>
$(function(){
	$("#btn_submit").click(function(){	
		var name = $("#name").val();
		var pass = $("#pass").val();
		var phone = $("#phone").val();
		var title = $("#title").val();
		var content = $("#content").val();
		
		if( name == "" ){
			alert("이름을 입력해 주세요!");
			return false;
		}
		
		if( pass == "" ){
			alert("비밀번호를 입력해 주세요!");
			return false;
		}
		
		if( phone == "" ){
			alert("전화번호를 입력해 주세요!");
			return false;
		}
		
		if( title == "" ){
			alert("제목을 입력해 주세요!");
			return false;
		}
		
		if( content == "" ){
			alert("문의내용를 입력해 주세요!");
			return false;
		}
		
		var dataform = $("#frm").serialize();	
		$.ajax({
			type : "POST",
			data : dataform,
			url  : "oneononeWriteSave.jsp",
			
			datatype : "json", 
			success : function(data){		
				
				var datas = JSON.parse(data);
    			if( datas.result == "ok" ) {
    				alert("등록 완료");
    				location="oneonone.jsp";
    			} else if(datas.reault == "data_null") {
    				alert("데이터 오류");
    			} else if(datas.reault == "data_size") {
    				alert("데이터크기 오류");
    			} else{
    				alert("등록 실패");
    			}	
			},
			error : function(){
				alert("전송 오류!");				
			}			
		});			
	});	
});
</script>
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
			<div class="n_notice_logo">	
				<img src="../images/o_banner.png" alt="logo">
			</div>	
			<div class="c_customer_main">	
			<div style="margin-left:41px; padding-top:35px;">
			<form id="frm">
			<table class="one_table">						
					<colgroup>
						<col width="15%"/>
						<col width="*"/>
					</colgroup>				
					<tr>
						<th>▶등록인</th>
						<td class="one_td1">
							<input type="text" name="name" id="name" class="one_text" placeholder="*등록인">
						</td>
					</tr>
					<tr>
						<th>▶암호</th>
						<td class="one_td1">
							<input type="password" name="pass" id="pass" class="one_text" placeholder="*암호">
						</td>
					</tr>
					<tr>
						<th>▶휴대전화</th>
						<td class="one_td1">
							<input type="text" name="phone" id="phone" class="one_text" placeholder="*전화번호">
							<input type="checkbox"> <span class="one_span1">체크하시면 답변시 알람 SMS가 고객님께 발송됩니다.</span>
						</td>
					</tr>
					<tr>
						<th>▶제목</th>
						<td class="one_td1">
							<input type="text" name="title" id="title" class="one_text2" placeholder="*제목">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="one_td2">
							<textarea name="content" id="content" class="one_tarea"></textarea>
						</td>
					</tr>					
				</table>
				<div class="one_div1">
					<button type="button" class="n_btn03" id="btn_submit">작성하기</button>
					<button type="button" class="n_btn03" onclick="history.back();">돌아가기</button>
				</div>
				</form>	
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
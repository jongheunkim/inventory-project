<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	String type = "";
	String unq = request.getParameter("unq");
	type = request.getParameter("type");
	if(unq == null || unq.equals("")){
%>
	<script>
		alert("잘못된 접근입니다!!");
		location="oneonone.jsp";
	</script>
<%
	}
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

</script>
</head>
<style>
		.passbox{
			border:1px solid gray; background-color:#EAEAEA; width:320px;
			height:180px;
		    position:relative;
		    left:50%;
		    top:30%;
		    margin-left:-150px;
		    margin-top:-150px;text-align:center;
		}
		.pass_btn{ width:60px;height:30px; }
</style>
<script>
$(function(){
	$("#btn_submit").click(function(){	
		var unq = $("#unq").val();
		var pass = $("#pass").val();
		var type = $("#type").val();
		
		if( pass == "" ){
			alert("비밀번호를 입력해 주세요!");
			return false;
		}
		
		var url = "oneonone_passchk.jsp";
		
		$.ajax({
			type : "post",
			data : "unq="+unq+"&pass="+pass+"&type="+type,
			url  :  url,
			
			datatype : "json", 
			success : function(data){
				var datas = JSON.parse(data);
    			if( datas.result == "ok" ) {
    				alert("비밀번호 확인");
    				location="oneononeDetail.jsp?unq="+unq;
    			}else if(datas.result == "del_ok"){	
    				if(confirm("정말 삭제하시겠습니까?")){
    					location="oneononeDelete.jsp?unq="+unq;
    				}else{
    					history.back();
    				}
    			} else if(datas.result == "mod_ok"){
    				alert("잘못된 비밀번호 입니다.");
    			}else{
    				alert("잘못된 비밀번호 입니다.");
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
					<div class="passbox">
    					<div style="margin-top:30px;">
							<span style="color:red;">게시글 잠금</span><br>
							작성시 입력하신 비밀번호를 입력하여 주세요
						</div>
						<br><hr>
					<div style="margin-top:30px;">
							<input type="hidden" name="unq" id="unq" value="<%=unq %>">
							<input type="hidden" name="type" id="type" value="<%=type %>">
							비밀번호 <input type="password" name="pass" id="pass" placeholder="비밀번호" style="height:25px;"> 
						<button type="button" class="pass_btn" id="btn_submit">확인</button>
					</div>					
				</div>	
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
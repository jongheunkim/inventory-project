<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Calendar"%>
<%@ page import="conn.ConOracle" %>

<%@ include file="../include/dbcon.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입양식</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="../css/member.css">
	<link rel="stylesheet" href="../include/main.jsp">

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

function fn_post() {	
	var url = "post1.jsp";
	window.open(url,"post","width=500,height=300");
}

function fn_change() {		
	var y=document.frm.year.value;
	var m=document.frm.month.value;
   
	var lastDate = new Date(y, m, 0).getDate();
	
	var options = "";
	for(var i=1; i<=lastDate; i++) {
		options += "<option value='"+i+"'>"+i+"일</option>";
	}
	document.getElementById('day').innerHTML = options;
}

function fn_idcheck() {
	
	var userid = document.frm.userid.value;
	if( userid == "" ) {
		alert("아이디를 입력해주세요.");
		return false;
	}
	if( userid.length < 4 || userid.length > 12 ) {
		alert("아이디는 4자~12사이로 해주세요.");
		return false;
	}
	
	var w = window.screen.width/2 - 150;
	var h = window.screen.height/2 - 75;
	
	var url = "idcheck.jsp?userid="+userid;
	window.open(url,"idcheck","width=300,height=150,left="+w+",top="+h);
}

function fn_submit() {

	var f = document.frm;
	
	if( document.frm.userid.value == "" ) {
		alert("아이디를 입력해주세요.");
		f.userid.focus();
		return false;
	}
	if( document.frm.userpw.value == "" ) {
		alert("암호를 입력해주세요.");
		f.userpw.focus();
		return false;
	}
	if( document.frm.name.value == "" ) {
		alert("이름을 입력해주세요.");
		f.name.focus();
		return false;
	}
	if(	document.frm.hp1.value=="" || f.hp2.value=="" || f.hp3.value=="") {
		alert("핸드폰 번호를 입력해주세요.");
		f.hp2.focus();
		return false;
	}

	if(	document.frm.userpw.value !== document.frm.pwchk.value ) {
		alert("비밀번호가 다릅니다. 다시 한번 확인해주세요. ");
		f.userpw.focus();
		return false;
	}
	
	document.frm.submit();
	
}

</script>

</head>

<body></body>

<header>
	<%@ include file="../include/header.jsp" %>
</header>
<nav>
	<%@ include file="../include/nav.jsp" %>
</nav>

<section>
	<article>
	<form name="frm" action="memberWriteSave.jsp" method="post" onsubmit="return fn_submit()" >
		<div>
			<h1>회원가입</h1>
	        <table class="table">
	            <tr>
	                <td class="td1">아이디</td>
	                <td class="td2">
	                    <input type="text" name="userid" id="userid" size="20px" style="background-color:#dcdcdc">
	                    <input type="button" id="check" value="중복확인" onclick="fn_idcheck()">
	                </td>
	            </tr>
	            <tr>
	                <td class="td1">비밀번호</td>
	                <td class="td2">
	                    <input type="password" name="userpw" id="userpw" size="20px" style="background-color:#dcdcdc"> 
	                    *영문 대소문자/숫자/특수문자를 혼용하여 8자이상 12자이하로 입력하세요.
	                </td>
	            </tr>
	            <tr>
	                <td class="td1">비밀번호<br>확인</td>
	                <td class="td2">
	                    <input type="password" name="pwchk" id="pwchk" size="20px" style="background-color:#dcdcdc">
	                    *비밀번호를 다시 한번 입력해주세요.
	                </td>
	            </tr>
	            <tr>
	                <td class="td1">이름</td>
	                <td class="td2">
	                    <input type="text" name="name" id="name" size="20px" style="background-color:#dcdcdc">
	                    *실명으로 입력해주세요. 
	                </td>
	            </tr>
	            <tr>
	                <td class="td1">휴대전화</td>
	                <td class="td2">
	                    <select name="hp1" style="background-color:#dcdcdc">
	     	                <option value="010">010</option>
	                        <option value="011">011</option>
	                        <option value="019">019</option>
	                    </select>
	                    -
	                    <input type="text" name="hp2" id="hp2" size="10" style="background-color:#dcdcdc">-
	                    <input type="text" name="hp3" id="hp3" size="10" style="background-color:#dcdcdc">
	                    &nbsp; *SMS 수신동의
	                    <input type="checkbox" name="sms_yes" value="SMS 수신동의" checked>
	                    SMS 수신을 동의합니다.
	                </td>
	            </tr>
	             <tr>
	                <td class="td1">이메일</td>
	                <td class="td2">
	                    <input type="text" name="em1" id="em1" size="10" style="background-color:#dcdcdc">@   
	                    <input type="text" name="em2" id="em2" size="15" style="background-color:#dcdcdc">
	                    &nbsp; * 이메일 수신동의
	                    <input type="checkbox" name="email_yes" value="이메일 수신동의" checked>
	                    이메일 수신을 동의합니다.
	                </td>
	            </tr>
	            	<%
			Calendar cal = Calendar.getInstance();
			
			int yy = cal.get(Calendar.YEAR);
			
			int y_s = yy - 80;
			int y_e = yy - 1;
			
			int y_set = yy-20;
			int m_set = 1;
			
			int lastday = 31;
			
			%>
				<tr>
					<td class="td1">생일</td>
					<td class="td2">
					<!-- 1941 ~ 2020 ,  1942 ~ 2021 -->
						<select name="year" onchange="fn_change()" style="background-color:#dcdcdc">
						<%
						for(int i=y_s; i<=y_e; i++) {
						%>
							<option value="<%=i %>"  
								<%if(i==y_set) { out.print("selected");  } %> >
								<%=i %>년</option>
						<%
						}
						%>
						</select>
						<select name="month" onchange="fn_change()" style="background-color:#dcdcdc">
						<%
						for(int i=1; i<=12; i++) {
						%>
							<option value="<%=i %>" <%if(i==m_set){ out.print("selected"); } %> ><%=i %>월</option>
						<%
						}
						%>
						</select>
						<select name="day" id="day" style="background-color:#dcdcdc">
						<%
						for(int i=1; i<=31; i++) {
						%>
							<option value="<%=i %>"><%=i %>일</option>
						<%
						}
						%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="td1">성별</td>
					<td class="td2">
						<select name="gender" style="background-color:#dcdcdc">
							<option value="M">남</option>
							<option value="F">여</option>
						</select>
					</td>
				</tr>
	            <tr>
	                <td class="td1">우편번호</td>
	                <td class="td2">
		                <input type="text" name="zipcode" class="input1" value="<% %>" style="width:48px; maxlength:6; background-color:#dcdcdc;">
						<button type="button" onclick="fn_post()">우편번호 </button>
						<input type="text" name="addr1" class="input1" style="background-color:#dcdcdc">
						<input type="text" name="addr2" class="input1" style="background-color:#dcdcdc">
	                </td>
	            </tr>
	             <tr>
	                <td class="td1">은행</td>
	                <td class="td2">
	                    <select name="bank_type" id="bank_type" style="background-color:#dcdcdc">
	                        <option value="국민은행">국민은행</option>
	                        <option value="기업은행">기업은행</option>
	                        <option value="농협은행">농협은행</option>
	                        <option value="신한은행">신한은행</option>
	                        <option value="산업은행">산업은행</option>
	                        <option value="우리은행">우리은행</option>
	                        <option value="한국씨티은행">한국씨티은행</option>
	                        <option value="하나은행">하나은행</option>
	                        <option value="SC제일은행">SC제일은행</option>
	                        <option value="경남은행">경남은행</option>
	                        <option value="광주은행">광주은행</option>
	                        <option value="대구은행">대구은행</option>
	                        <option value="도이치은행">도이치은행</option>
	                        <option value="뱅크오브아메리카">뱅크오브아메리카</option>
	                        <option value="부산은행">부산은행</option>
	                        <option value="산림조합중앙회">산림조합중앙회</option>
	                        <option value="저축은행">저축은행</option>
	                        <option value="새마을금고">새마을금고</option>
	                        <option value="수협은행">수협은행</option>
	                        <option value="신협중앙회">신협중앙회</option>
	                        <option value="우체국">우체국</option>
	                        <option value="전북은행">전북은행</option>
	                        <option value="제주은행">제주은행</option>
	                        <option value="중국건설은행">중국건설은행</option>
	                        <option value="중국공상은행">중국공상은행</option>
	                        <option value="중국은행">중국은행</option>
	                        <option value="BNP파리바은행">BNP파리바은행</option>
	                        <option value="HSBC은행">HSBC은행</option>
	                        <option value="JP모간체이스은행">JP모간체이스은행</option>
	                        <option value="케이뱅크">케이뱅크</option>
	                        <option value="카카오뱅크">카카오뱅크</option>
	                        <option value="토스뱅크">토스뱅크</option>
	                    </select>
	                </td>
	            </tr>
	            <tr>
	                <td class="td1">계좌번호</td>
	                <td class="td2">
	                    <input type="text" name="bank_account_detail" id="bank_account_detail" size="40" style="background-color:#dcdcdc">
	                </td>
	            </tr>
	            <tr>
	                <td class="td1">예금주명</td>
	                <td class="td2">
	                   <input type="text" name="account_name" id="account_name" size="5" style="background-color:#dcdcdc">
	                   *예금주와 계좌번호가 일치하여야 출금이 가능하니 정확히 입력해주세요.               
	                </td>
	            </tr>
	            <tr>
	                <td class="td1">서비스<br>이용기간</td>
	                <td class="td2">
	                    <input type="checkbox" name="service" id="service" value="true" checked>
	                    개인정보를 파기 또는 분리 저장/관리하는 서비스 이용기간을 회원 탈퇴시까지로 요청합니다.<br>
	                    &nbsp; *다만 별도의 요청이 없을 경우 서비스 이용기간은 1년으로 합니다.
	                </td>
	            </tr> 
	            <tr>
	                <td class="td1">본인<br>확인번호</td>
	                <td class="td2">
	                   <input type="text" name="my_number" id="my_number" size="10" style="background-color:#dcdcdc">
	                   <br>*본인 확인 메세지는 회원님이 설정한 번호로 '인벤토리'에서 발송하는 메세지에 기재되며 본인확인번호가 다를 경우 허위문자, 사칭문자입니다. 
	                   <br>'인벤토리'는 고객님의 비밀번호, 본인확인번호를 절대 요구하지 않습니다.         
	                </td>
	            </tr>
	        </table>
   		</div>
   	
		<div class="btn" align="center">
			<button type="submit" style="align:center">전송</button>
			<input type="button" value="취소" style="align:center">
		</div>
	</form>
	</article>
	<aside>
		<%@ include file="../include/right_menu.jsp" %>
	</aside>
</section>

<footer>
	<%@ include file="../include/footer.jsp" %>
</footer>

</html>
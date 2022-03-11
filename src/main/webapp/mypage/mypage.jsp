<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="../css/layout.css">
	<link rel="stylesheet" href="../css/header_nav.css">
	<link rel="stylesheet" href="../css/footer.css">
	<link rel="stylesheet" href="../css/main.css">
	<link rel="stylesheet" href="../include/main.jsp">
	<link rel="stylesheet" href="../css/mypage.css">
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
<style>


</style>
</head>


<!--Start of Tawk.to Script-->
<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/61c7ce3bc82c976b71c3872f/1fnq7r6qb';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();
</script>
<!--End of Tawk.to Script-->

<body>

<header>
	<%@ include file="../include/header.jsp" %>
</header>
<nav>
	<%@ include file="../include/nav.jsp" %>
</nav>
<section>
  <script language="javascript">
function AllChkFunc()
{
    var all = $("#all").val();
    if (all == '0') {
        all = $("#all").val('1');
        $("input[type=checkbox]").prop("checked", true);
    } else {
        all = $("#all").val('0');
        $("input[type=checkbox]").prop("checked", false);
    }
}

function zzimDel(number)
{
	var SH_Stand = "";
    if (number != '') {
        SH_Stand = number;
    } else { 
        $("input[name=zzim_cart]:checked").each(function() {
            if (SH_Stand.length!==0)	SH_Stand += ",";
            SH_Stand += $(this).val();
        });
    }
    if (SH_Stand == "") {
        alert("삭제하실 관심물품을 하나라도 선택하셔야 합니다.");
        return;
    }
    if (!confirm("관심물품을 삭제하겠습니까?"))	return;
    loading(1);
	var str_url	= "/mypage/zzimdel";
	jQuery.ajax({
		type: "POST",
        data: {number:SH_Stand},
		url : str_url,
		success:function(data){
            if (data == "OK") {
                alert("삭제되었습니다.");
                location.reload();
            } else {
                alert(data);
                loading(2);
            }
		},
		error : function(request, status, error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

function viewopen(link,title) {
    colorboxiframe('1100','100%',link,title);;
 }
</script>
<body>
<aside>
		<%@ include file="../include/right_menu.jsp" %>
	</aside>
<!--좌측 퀵배너  -->
	<article>
		<div id="contents">
		<div style="width:1000px; margin:30px auto;" class="mypage_content">
			<table cellspacing="0" cellpadding="0" style="width:100%;">
			<tr>
				<td style="width:220px;" valign="top">
					<table cellspacing="0" cellpadding="0" style="width:100%;">
						<tr>
							<td><a href="happy_member.php?mode=mypage"><img src="../images/skin_icon_206_1.png" alt="마이페이지" title="마이페이지"></a></td>
						</tr>
						<tr>
							<td style="background:#4d4d4d;padding:13px 10px;">
							<table cellspacing="0" cellpadding="0" style="width:100%;">
								<tr>
									<td class="font_13" style="color:#ffffff;"><img src=../images/gray_icon_trust_77.gif border=0 alt='새싹' align='absmiddle'> <strong>김종흔</strong> 님</td>
									<td align="right"><a href="../mypage/mypagesave.jsp"><img src="../images/mypage_plus.png" alt="회원정보수정" title="회원정보수정"></a></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td style="background:#808080;">
								<table cellspacing="0" cellpadding="0" style="width:100%;" class="mypage_info_list">
								<tr>
									<td style="border-top:1px solid #aaa;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding:12px 0 12px 10px; color:#f7fa98;">채팅하기</td>
											<td align="right" class="font_12 " style="padding-right:10px; color:#ffffff;"><span onclick="window.open('happy_chating.php','happy_chating_mypage_qoqzzzz1','width=700,height=680,scrollbars=1');" style="cursor:pointer;">미확인<strong class="font_number"> 0</strong> 건</span></td>
										</tr>
										</table>
									</td>
								</tr>
				
								<tr style="display:">
									<td style="border-top:1px solid #aaa;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding:12px 0 12px 10px;; color:#ffffff;">총 마일리지</td>
											<td align="right" class="font_12" style="padding-right:10px; color:#ffffff;"><a href='/my_point_jangboo.php' style='color:#ffffff;'><strong class='font_number'>0</strong></a> 원</td>
										</tr>
                                                                                <tr>
                                                                                        <td class="font_12" style="padding:12px 0 12px 10px;; color:#ffffff;">구매전용 마일리지</td>
                                                                                        <td align="right" class="font_12" style="padding-right:10px; color:#ffffff;"><a href='/my_point_jangboo.php' style='color:#ffffff;'><strong class='font_number'>0</strong></a> 원</td>
                                                                                </tr>
										</table>
									</td>
								</tr>

							
							
							
									<td style="border-top:1px solid #aaa;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding:12px 0 12px 10px; color:#ffffff;">거래점수</td>
											<td align="right" class="font_12" style="padding-right:10px; color:#ffffff;"><img src=../images/gray_icon_trust_77.gif  border=0 alt='새싹' align='absmiddle'> <strong class="font_number">판매 : 0 // 구매 : 0</strong> 점</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>

						</tr>
						
						<tr>
							<td>
								<table cellspacing="0" cellpadding="0" style="width:100%; border:1px solid #cacaca; background:#f8f8f8; margin-top:10px;">
								
								<tr>
									<td style="padding:15px; border-bottom:1px solid #e6e6e8;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding-bottom:5px;">
											<table cellspacing="0" cellpadding="0" style="width:100%;">
												<tr>
													<td style="color:#353535"><strong class="font_15">유료 상품</strong></td>
													<!-- <td align="right"><a href="my_sell.php"><img src="../images/mypage_plus2.png" alt="더보기" title="더보기"></a></td> -->
												</tr>
											</table>
											</td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="/happy_member.php?mode=item" style="color:#747474">물품시세확인권</a></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="/happy_member.php?mode=item2" style="color:#747474">자동재등록권</a></td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td style="padding:15px; border-bottom:1px solid #e6e6e8;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding-bottom:5px;">
											<table cellspacing="0" cellpadding="0" style="width:100%;">
												<tr>
													<td style="color:#353535"><strong class="font_15">판매내역</strong></td>
													<!-- <td align="right"><a href="my_sell.php"><img src="/images/renew/mypage_plus2.png" alt="더보기" title="더보기"></a></td> -->
												</tr>
											</table>
											</td>
										</tr>

										
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="my_sell_view.php?stats=4" style="color:#747474">판매중 <span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;">(인계 해야 할 물품)</span></a></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="my_sell_view.php?stats=8" style="color:#747474">취소승인 대기중<span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;"></span></a></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="my_sell_view.php?stats=5" style="color:#747474">판매완료 <span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;">(정산 완료된 물품)</span></a></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="/my_selling_product.php" style="color:#747474">내가 등록한 물품 <span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;"></span></a></td>
										</tr>
										
										</table>
									</td>
								</tr>


								<tr>
									<td style="padding:15px; border-bottom:1px solid #e6e6e8;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding-bottom:5px;">
											<table cellspacing="0" cellpadding="0" style="width:100%;">
												<tr>
													<td style="color:#353535"><strong class="font_15">구매내역</strong></td>
													<!-- <td align="right"><a href="my_buy.php" ><img src="/images/renew/mypage_plus2.png" alt="더보기" title="더보기"></a></td> -->
												</tr>
											</table>
											</td>
										</tr>
										 
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="my_buy_view.php?stats=4" style="color:#747474">구매중 <span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;">(인수 해야 할 물품)</span></a></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="my_buy_view.php?stats=8" style="color:#747474">구매취소중 <span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;">(인수 해야 할 물품취소)</span></a></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="my_buy_view.php?stats=5" style="color:#747474">구매완료 <span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;">(인수 확인한 물품)</span></a></td>
										</tr>

                                                                                <tr>
                                                                                        <td class="font_12" style="padding:5px 0;"><a href="econtract_display.php" style="color:#747474">전자계약서 <span class="font_11" style="font-family:'돋움',Dotum,'굴림',Gulim; color:#9f9f9f;"></span></a></td>
                                                                                </tr>

										
										</table>
									</td>
								</tr>

								<tr style="display:">
									<td style="padding:15px 15px 10px 15px; border-bottom:1px solid #e6e6e8;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding-bottom:5px; color:#353535;"><strong class="font_15">마일리지 관리</strong></td>
										</tr>
										<tr style="display:">
											<td class="font_12" style="padding:5px 0;"><a href="my_point_jangboo.php" style="color:#747474">마일리지 내역</a></td>
										</tr>
										<tr style="display:">
											<td class="font_12" style="padding:5px 0;"><a href="javascript:void(0);" onclick="location.href='my_point_charge.php'" style="color:#747474;">마일리지 충전</a></td>
										</tr>
										<tr style="display:">
											<td class="font_12" style="padding:5px 0;"><a href="javascript:void(0);" onclick="location.href='happy_member.php?mode=get_coin_withdraw'" style="color:#747474;">출금신청</a></td>
										</tr>
										</table>
									</td>
								</tr>


							

								<tr>
									<td style="padding:15px 15px 10px 15px; border-bottom:1px solid #e6e6e8;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12" style="padding-bottom:5px; color:#353535;"><strong class="font_15">내 정보관리</strong></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="happy_member.php?mode=modify" style="color:#747474">회원정보수정</a></td>
										</tr>
										<tr>
											<td class="font_12" style="padding:5px 0;"><a href="html_file.php?file=member_out.html&mode=member_out" style="color:#747474">회원탈퇴</a></td>
										</tr>
										</table>
									</td>
								</tr>

								<tr>
									<td style="padding:15px 15px 10px 15px;">
										<table cellspacing="0" cellpadding="0" style="width:100%;">
										<tr>
											<td class="font_12 bullet_icon_11" style="padding:5px 0 5px 8px;"><span onclick="window.open('happy_chating.php?otherid=','happy_chating_mypage_qoqzzzz1','width=700,height=680');" style="cursor:pointer;font-size:14px;">대화(문의)내역 관리</span></td>
										</tr>
										<tr>
											<td class="font_12 bullet_icon_11" style="padding:5px 0 5px 8px;"><a href="my_zzim_view.php">스크랩한 물품</a></td>
										</tr>
										<!-- <tr>
											<td class="font_12 bullet_icon_11" style="padding:5px 0 5px 8px;"><a href="my_review_list.php">내가 쓴 구매후기 리스트</a></td>
										</tr> -->
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>

				<td style="padding-left:20px;" valign="top">
					
					<script type="text/javascript">

	function shin_msg()
	{
		alert('010-6430-6061 번으로 신분증 주민번호 뒷자리\n숫자 가린채로 보내주시면 인증됩니다.');
	
		
		<%@ include file="../include/right_menu.jsp" %>

</script>

<div class="mypagetitle">나의 인증 현황</div>
<table class="table5">
    <colgroup>
        <col class="wp_10">
        <col class="wp_40">
        <col class="wp_10">
        <col class="wp_40">
    </colgroup>
    <tr>
        <td>신분증</td>
        <td onclick="alertjs('shin','y');"><img src="../images/view_step2.gif"></td>
        <td>휴대폰</td>
        <td onclick="alertjs('hp','y');"><img src="../images/view_step2.gif"></td>
    </tr>
    <tr>
        <td>아이핀</td>
        <td onclick="alertjs('ipin','n');"><img src="../images/view_step2.gif" alt=""></td>
        <td>출금계좌</td>
        <td onclick="alertjs('bank','y');"><img src="../images/view_step2.gif"></td>
    </tr>
</table>
<table class="table5">
<div class="mypagetitle">나의 마일리지 현황</div>

    <colgroup>
        <col class="wp_10">
        <col class="wp_40">
        <col class="wp_10">
        <col class="wp_40">
    </colgroup>
    <tr>
        <td>보유 마일리지</td>
        <td onclick="alertjs('shin','y');"><a href='../mypage/mileage.jsp' style='color:#100719;'><strong class='font_number'>0</strong></a> 원</td>
        <td>구매 전용마일리지</td>
        <td onclick="alertjs('hp','y');"><a href='../mypage/mileage.jsp' style='color:#100719;'><strong class='font_number'>0</strong></a> 원</td>
    </tr>
    
    </table>
    
<div class="mypagetitle">내 전체 거래 현황</div>
<table class="table6">
    <colgroup>
        <col class="wp_15">
        <col span="4">
    </colgroup>
    <tr>
        <td class="deal">
            <div class="type">SELL</div>
            판매자
        </td>
        <td>
            <a href="../mypage/sellingproduct">
                <span class="step">STEP1</span><br>
                내가 등록한 물품<br>
                <b>0</b> 건
            </a>
            <img src="../images/arrow_icon_sell.png">
        </td>
        <td>
            <a href="/mypage/sellview/4">
                <span class="step">STEP2</span><br>
                판매중인 물품<br>
                <b>0</b> 건
            </a>
            <img src="../images/arrow_icon_sell.png">
        </td>
        <td>
            <a href="/mypage/sellview/8">
                <span class="step">STEP3</span><br>
                <span class="co_B">취소승인 대기중</span><br>
                <b>0</b> 건
            </a>
            <img src="../images/arrow_icon_sell.png">
        </td>
        <td>
            <a href="/mypage/sellview/5">
                <span class="step">STEP4</span><br>
                판매 종료 물품<br>
                <b>0</b> 건
            </a>
        </td>
    </tr>
</table>
<table class="table6 buy mt010">
    <colgroup>
        <col class="wp_15">
        <col span="3">
    </colgroup>
    <tr>
        <td class="deal">
            <div class="type">BUY</div>
            구매자
        </td>
        <td>
            <a href="/mypage/buyview/4">
                <span class="step">STEP2</span><br>
                구매중인 물품<br>
                <b>0</b> 건
            </a>
            <img src="../images/arrow_icon_sell.png">
        </td>
        <td>
            <a href="/mypage/buyview/8">
                <span class="step">STEP3</span><br>
                구매취소중<br>
                <b>0</b> 건
            </a>
            <img src="../images/arrow_icon_sell.png">
        </td>
        <td>
            <a href="/mypage/buyview/5">
                <span class="step">STEP4</span><br>
                구매 종료 물품<br>
                <b>0</b> 건
            </a>
        </td>
    </tr>
</table>
                   
<div class="mypagetitle">
    판매 물품
    <a href="/mypage/zzimlist" class="fr">
        <img src="../images/mypage_plus2.png" alt="더보기" title="더보기">
    </a>
</div>
<div class="zzim bg_e mtm10">
        <div class="list">
            <ul>
                
                    <a href="javascript:void(0);" onclick="viewopen('/product/view/5360039','71 세인트 영변/영탈,전날 컬렉42% 투력 2.85 팝니다. ')">
                        <img src="../images/1549530348-1.gif" class="w_240 h_185">
                    </a>
               
                <i>550,000원</i>
            </ul>
            <dl>
                <dd>[오딘: 발할라 라이징 > 프리스트]</dd>
                <dt>
                    <a href="javascript:void(0);" onclick="viewopen('/product/view/5360039','71 세인트 영변/영탈,전날 컬렉42% 투력 2.85 팝니다. ')">
                        71 세인트 영변/영탈,전날 컬렉42% 투력 2.85 팝니다.                     </a>
                </dt>
            </dl>
            <div>
                <a href="javascript:void(0);" onclick="viewopen('/product/view/5360039','71 세인트 영변/영탈,전날 컬렉42% 투력 2.85 팝니다. ')">
                    <img src="../images/btn_talent_info_move.jpg" alt="상세정보보기" title="상세정보보기">
                </a>
                <a href="javascript:;" onclick="zzimDel('1304184');">
                    <img src="../images/btn_scrap_delete.jpg" alt="스크랩삭제" title="스크랩삭제">
                </a>
            </div>
        </div>
                <div class="list">
            <ul>
             
                    <a href="javascript:void(0);" onclick="viewopen('/product/view/5609874','30디펜 ㅍ ㅍ 게스트')">
                        <img src="../images/1619673210-2958.gif" class="w_240 h_185">
                    </a>
                
                <i>200,000원</i>
            </ul>
            <dl>
                <dd>[오딘: 발할라 라이징 > 워리어]</dd>
                <dt>
                    <a href="javascript:void(0);" onclick="viewopen('/product/view/5609874','30디펜 ㅍ ㅍ 게스트')">
                        30디펜 ㅍ ㅍ 게스트                    </a>
                </dt>
            </dl>
            <div>
                <a href="javascript:void(0);" onclick="viewopen('/product/view/5609874','30디펜 ㅍ ㅍ 게스트')">
                    <img src="../images/btn_talent_info_move.jpg" alt="상세정보보기" title="상세정보보기">
                </a>
                <a href="javascript:;" onclick="zzimDel('1304183');">
                    <img src="../images/btn_scrap_delete.jpg" alt="스크랩삭제" title="스크랩삭제">
                </a>
            </div>
        </div>
                <div class="list">
            <ul>
              
                    <a href="javascript:void(0);" onclick="viewopen('/product/view/5322266','급처 현 90렙 35퍼 사신 몸 정리합니다 ')">
                        <img src="../images/1619673210-2958.gif" class="w_240 h_185">
                    </a>
                
                <i>350,000,000원</i>
            </ul>
            <dl>
                <dd>[리니지M > 사신]</dd>
                <dt>
                    <a href="javascript:void(0);" onclick="viewopen('/product/view/5322266','급처 현 90렙 35퍼 사신 몸 정리합니다 ')">
                        급처 현 90렙 35퍼 사신 몸 정리합니다                     </a>
                </dt>
            </dl>
            <div>
                <a href="javascript:void(0);" onclick="viewopen('/product/view/5322266','급처 현 90렙 35퍼 사신 몸 정리합니다 ')">
                    <img src="../images/btn_talent_info_move.jpg" alt="상세정보보기" title="상세정보보기">
                </a>
                <a href="javascript:;" onclick="zzimDel('1281815');">
                    <img src="../images/btn_scrap_delete.jpg" alt="스크랩삭제" title="스크랩삭제">
                </a>
            </div>
        </div>
        </div>
<div class="mypagetitle">
    <img src="../images/view_ico_warning.gif" alt="">
    대표이사 Email : inventory@gmail.com</div>
<div class="mtm15 style">
    <li class="co_R">인벤토리에서 혹시 불편을 느끼셨으면, 대표이사에게 Email로 고객님의 해당 내용을 전달 해 주시면, 반드시 시정 하겠습니다.</li>
    <li>인벤토리 고객센터(1666-1391)로 질문 및 문의 주시면 친절히 도움•설명 드리겠습니다.</li>
</div>

                        </div>
            </div>
                
            </div>    </div>

</td></tr></table>
	
	

</section>

<footer>
	<%@ include file="../include/footer.jsp" %>
</footer>
</body>
</html>
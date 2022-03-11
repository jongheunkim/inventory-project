<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>

    <head>
            <title>채팅하기</title>
    <meta name="description" content="바로템(계정,아이템 거래소)">
    <link rel="shortcut icon" href="/static/img/b.ico" />
    <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="/static/css/common.css?v=211110115634" />
    <link rel="stylesheet" type="text/css" href="/static/css/style.css?v=211110115634" />
    <link rel="stylesheet" type="text/css" href="/static/css/tool.css?v=211110115634" />
    <link rel="stylesheet" type="text/css" href="/static/css/chattingRemark.css?v=211110115634" />
    <script type="text/javascript" src="/static/js/jquery-1.11.3.min.js"></script>
    
    <script src="/static/js/webviewBridge.js?v=211110115634"></script>
    <script src="/static/js/ycommon.js?v=211110115634"></script>
    <script src="/static/js/contents.js?v=211110115634"></script>
    <script src="/static/js/webviewCustom.js?v=211110115634"></script>
    <script src="https://kit.fontawesome.com/c493f2cbe4.js" crossorigin="anonymous"></script>
            <script>
            var filter = "win16|win32|win64|mac|macintel";
            if ( navigator.platform ) { 
                if ( filter.indexOf( navigator.platform.toLowerCase() ) >= 0 ) { 
                    window.moveTo(0,0);
                    var H = "850",W = "850";
                    var windowWidth = opener.window.outerWidth;
                    var windowheight = opener.window.outerHeight + 50;
                    if (windowWidth < W) {
                        W = windowWidth;
                    } else if (windowWidth / 3 > W) {
                        W = windowWidth / 3;
                    }
                    H = windowheight;
                    window.onload = function()
                    {
                        window.resizeTo(W, H);
                    }

                 }
            }
        </script>
            <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-130444826-1"></script>
    </head>
    <body class="chatBody">
        <!--loading-->
<div class="image_process di_no" id="loading">
    <div class="image_process_text">
        <i class="loading"></i>
        <span>로딩중</span>
    </div>
</div>


<script type="text/javascript">
$(document).ready(function (){
    changeHeightContentArea ();
    $(window).resize(changeHeightContentArea);
});
$(window).load(function(){
    $('select[name=search_type] option:eq(0)').attr("selected","selected");
});
function changeHeightContentArea () {
    // var domHeight = Math.max(document.body.offsetHeight, document.body.scrollHeight);
    var windowHeight = $(window).height();
    var chatHeadHeight = $('section.chattingLayoutSection .chattingHeader').outerHeight(true);
    var pagingHeight = $('.chattingPaging').outerHeight(true);
    var searchHeight = $('section.chattingLayoutSection .bodyChatList .listSearch').outerHeight(true);
    var changeHeight = windowHeight - chatHeadHeight - pagingHeight - searchHeight;
    // console.log("changeHeight", changeHeight)
    $("ul.listChat").css("height", changeHeight);
}
</script>

<section class="chattingLayoutSection">
    <div class="chattingHeader">
        <div class="headerWelcome headerInline">
            <span>박상욱</span>님 안녕하세요.        </div>
        <div class="headerNotification headerInline">
            개인정보 보호 목적으로 <span>30일</span>까지 보관됩니다.
        </div>
        <div class="ct_banner">
                </div>
    </div><!-- .chattingHeader -->
    <div class="chattingBody">
        <article class="bodyChatList bodyInline">
            <form name="msglist" action="/chat/lists" method="get">
            <div class="listSearch">
                <input type="hidden" name="search_type" value="message" />
                <input type="text" class="searchInput searchInline search_word" placeholder="검색어를 입력해주세요." name="search_word" value="">
                <button type="submit" class="searchButton searchInline"><i class="fas fa-search"></i></button>
            </div>
            <ul class="listChat">
                                <li id="tabItem_38068810">
                    <a href="/chat/view/38068810" class="chatLink">
                        <div class="chatLeft">
                            <i class="fas fa-user-circle"></i>
                        </div>
                        <div class="chatRight">
                            <div class="chatPreview">
                                <span class="previewUser previewInline">ru*****</span>
                                <span class="previewDate previewInline">2021-10-28 17:20</span>
                            </div>
                            <div class="chatContent">
                                <p>[바로템 공지]바로템 어플출시, 어플설치 = 사기예방물품명 : ★...</p>
                                                            </div>
                        </div>
                    </a>
                </li>
                                <li id="tabItem_37364554">
                    <a href="/chat/view/37364554" class="chatLink">
                        <div class="chatLeft">
                            <i class="fas fa-user-circle"></i>
                        </div>
                        <div class="chatRight">
                            <div class="chatPreview">
                                <span class="previewUser previewInline">pa*****</span>
                                <span class="previewDate previewInline">2021-10-16 18:50</span>
                            </div>
                            <div class="chatContent">
                                <p>네 안녕하세요</p>
                                                            </div>
                        </div>
                    </a>
                </li>
                            </ul>
            </form>
        </article>
        <div class="chattingPaging">
<nav class='homePage' aria-label="Page navigation">
    <ul class="pagination">
    
            <li class="active">
            <a href="https://www.barotem.com/chat/lists?page=1">
                1            </a>
        </li>
    
        </ul>
</nav></div>
    </div><!-- .chattingBody -->
</section>


<!-- Global site tag (gtag.js) - Google Analytics -->
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());

gtag('config', 'UA-130444826-1');
</script>

    </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
   <div class="wrapper">
    <div class="user-container">
        <label for="nickname">대화명</label>
        <input type="text" id="nickname">
    </div>
    <div class="display-container">
        <ul class="chatting-list">
        </ul>
    </div>
    <div class="input-container">
        <input type="text" class="chatting-input">
        <button class="send-button">전송</button>
    </div>
   </div>


    <script src="/socket.io/socket.io.js"></script>
    <script src="js/chat.js"></script>
</body>
</html>
[출처] 자바스크립트(ES6)를 통한 카카오톡같은 채팅 앱만들기 프로젝트(feat.node.js)|작성자 문과개발자</html>
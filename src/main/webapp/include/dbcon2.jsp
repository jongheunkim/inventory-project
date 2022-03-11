<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
String url2="jdbc:oracle:thin:@//localhost:1521/xe";

String username2="inventory";
String userpass2="1234";

 /* 접속 드라이브 연결 */
 //Class.forName("com.mysql.jdbc.Driver"); 
Class.forName("oracle.jdbc.OracleDriver");
 /* 접속 정보 설정 및 적용 */
 Connection conn2=DriverManager.getConnection (url2,username2,userpass2);

 /* 접속 인스턴스 생성  */
 Statement stmt2 = conn2.createStatement(); 
 
 request.setCharacterEncoding("utf-8");
%>

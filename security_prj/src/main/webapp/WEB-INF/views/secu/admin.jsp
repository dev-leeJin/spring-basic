<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>  <!-- 새로 추가됌. 시큐리티를 쓰기 위해 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 앞으로 principal을 세션처럼 쓸 것임.  -->
	<h1>admin 주소</h1>
	<h2>다양한 페이지 정보</h2>
	
	<p>principal : <sec:authentication property="principal"/></p> <!-- 전체적인 총괄 데이터 -->
	<p>MemberVO : <sec:authentication property="principal.member"/></p> <!-- 우리가 쓰는 것은 principal.member에 다 들어있음. -->
	<p>사용자의 이름 : <sec:authentication property="principal.member.userName"/></p>
	<p>사용자의 아이디 : <sec:authentication property="principal.member.userId"/></p>
	<p>사용자 권한목록 : <sec:authentication property="principal.member.authList"/></p>
	
	<hr>
	<a href="/customLogout">로그아웃페이지 이동</a> <!-- get방식 (로그아웃로직이 작동은 안함) -->
</body>
</html>
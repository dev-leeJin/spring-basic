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
	<h1>member 주소</h1>
		
		<hr>
		<!-- 관리자권한이 있는 사람만 볼 수 있는 관리자 페이지가기 버튼 -->
		<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
			<!-- 제시한 권한이 있으면 true -->
			<a href="/secu/admin">관리자 페이지</a>
		</sec:authorize> <br/>
		
		<a href="/customLogout">로그아웃페이지 이동</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그아웃 처리 페이지</h1>
	<form action="/customLogout" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>  <!-- 보안적인 측면에서 넣어줌 -->
		<input type="submit" value="로그아웃" />
	</form>
</body>
</html>
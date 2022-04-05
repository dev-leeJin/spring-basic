<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="/userInfo" method="post">
		<input type="number" name="userNum" placeholder="유저번호"><br/>
		<input type="text" name="userId" placeholder="유저아이디"><br/>
		<input type="password" name="userPw" placeholder="유저비밀번호"><br/>
		<input type="text" name="userName" placeholder ="유저이름"><br/>
		<input type="number" name="userAge" placeholder ="유저나이"><br/>
		<input type="submit" value = "회원정보 제출" />
	</form>
</body>
</html>
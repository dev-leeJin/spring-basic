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
		<input type="number" name="userNum" placeholder="������ȣ"><br/>
		<input type="text" name="userId" placeholder="�������̵�"><br/>
		<input type="password" name="userPw" placeholder="������й�ȣ"><br/>
		<input type="text" name="userName" placeholder ="�����̸�"><br/>
		<input type="number" name="userAge" placeholder ="��������"><br/>
		<input type="submit" value = "ȸ������ ����" />
	</form>
</body>
</html>
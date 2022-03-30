<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- post방식은 get방식이랑 다르게 한글로 보내면 깨지게 된다.  -->
	<form action="/getData" method="post">
		<input type="text" name ="data1" placeholder="data1(문자)">
		<input type="number" name="data2" placeholder="data2(정수)" >
		<input type="submit" value ="제출">
	</form>
</body>
</html>
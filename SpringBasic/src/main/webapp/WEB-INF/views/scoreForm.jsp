<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%--/score라는 공통주소를 쓰되
	get, post접속으로 폼 접속인지, 결과 확인힌지 나뉩니다. 
	따라서 폼 접속을 이미 했다면 목적지는 공통주소인 /score가 되고
	post방식으로 전송하도록 하면 결과페이지에 도달할 수 있습니다.--%>
	<h1>성적 입력 창</h1>
	<form action="/score" method="post">
		
		<input type="submit" value="성적확인">
	</form>
</body>
</html>
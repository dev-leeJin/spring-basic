<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%--/score��� �����ּҸ� ����
	get, post�������� �� ��������, ��� Ȯ������ �����ϴ�. 
	���� �� ������ �̹� �ߴٸ� �������� �����ּ��� /score�� �ǰ�
	post������� �����ϵ��� �ϸ� ����������� ������ �� �ֽ��ϴ�.--%>
	<h1>���� �Է� â</h1>
	<form action="/score" method="post">
		���� : <input type="number" name="math" max="100" min="0"><br/>
		���� : <input type="number" name="eng" max="100" min="0"><br/>
		��� : <input type="number" name="lang" max="100" min="0"><br/>
		��Ž : <input type="number" name="social" max="100" min="0"><br/>
		��ǻ�� : <input type="number" name="computer" max="100" min="0"><br/>
		<input type="submit" value="����Ȯ��">
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- jsp����� ����Ϸ��� ����� �ּҸ� �Է��ؾ���.  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	${array } <hr/>
	<%-- �� array��
	c:forEach�� �̿���
	�ϳ��ϳ� �������ּ���. --%>
	<c:forEach var ="item" items="${array }">
		${item }<br/>
	</c:forEach>
</body>
</html>
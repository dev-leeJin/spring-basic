<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- jsp기능을 사용하려면 상단의 주소를 입력해야함.  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	${array } <hr/>
	<%-- 위 array를
	c:forEach를 이용해
	하나하나 나열해주세요. --%>
	<c:forEach var ="item" items="${array }">
		${item }<br/>
	</c:forEach>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
	<h1>게시물 목록</h1>
	<table border="1">
		<thead>
			<tr>
				<th>글번호</th>
				<th>글제목</th>
				<th>글쓴이</th>
				<th>쓴날짜</th>
				<th>수정날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="board" items="${boardList }">
				<tr>
					<th>${board.bno }</th>
					<th><a href="/boardDetail/${board.bno}">${board.title }</th>
					<th>${board.writer }</th>
					<th>${board.regdate }</th>
					<th>${board.updatedate }</th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="/boardInsert" class="btn btn-success">글쓰기</a>
	</div>
</body>
</html>
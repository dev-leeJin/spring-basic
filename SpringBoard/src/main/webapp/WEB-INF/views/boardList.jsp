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
	<h1>�Խù� ���</h1>
	<table border="1">
		<thead>
			<tr>
				<th>�۹�ȣ</th>
				<th>������</th>
				<th>�۾���</th>
				<th>����¥</th>
				<th>������¥</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="board" items="${boardList }">
				<tr>
					<th>${board.bno }</th>
					<th><a href="/boardDetail/${board.bno}?searchType=${pageMaker.cri.searchType }&keyword=${pageMaker.cri.keyword}">${board.title }</th>
					<th>${board.writer }</th>
					<th>${board.regdate }</th>
					<th>${board.updatedate }</th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<a href="/boardInsert" class="btn btn-success">�۾���</a> <br/>
	${pageMaker } <br/>
	
		<!-- ��ư �ڵ� -->	
			<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item">
		    
		    <c:if test="${pageMaker.prev }">
		      <a class="page-link" href="/boardList?pageNum=${pageMaker.startPage -1 }&searchType=${pageMaker.cri.searchType }&keyword=${pageMaker.cri.keyword}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </c:if>
		    
		    </li>
		    
		    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
		    <li class="page-item ${pageMaker.cri.pageNum eq idx ? 'active' : '' }">
		    	<a class="page-link" href="/boardList?pageNum=${idx}&searchType=${pageMaker.cri.searchType }&keyword=${pageMaker.cri.keyword}">${idx}</a></li>
		    </c:forEach>
		    
		    <li class="page-item">
		    
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
		      <a class="page-link" href="/boardList?pageNum=${pageMaker.endPage +1 }&searchType=${pageMaker.cri.searchType }&keyword=${pageMaker.cri.keyword}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		    </c:if>
		      </a>
		    </li>
		  </ul>
		</nav>
		<div class="row">
			<!-- �˻�â �κ� -->
			<form action="/boardList" method="get">
				<!-- select�±׸� �̿��� Ŭ���� �˻������� �����Ҽ��ֵ��� ó���մϴ�. -->
				<select name="searchType">
				<!-- �˻������� option�±׸� �̿��� ����ϴ�. -->
					<option value="n">-</option>
					<option value="t" ${pageMaker.cri.searchType eq 't' ? 'selected' : '' }>����</option>
					<option value="c" ${pageMaker.cri.searchType eq 'c' ? 'selected' : '' }>����</option>
					<option value="w" ${pageMaker.cri.searchType eq 'w' ? 'selected' : '' }>�۾���</option>
					<option value="tc" ${pageMaker.cri.searchType eq 'tc' ? 'selected' : '' }>����+����</option>
					<option value="cw" ${pageMaker.cri.searchType eq 'cw' ? 'selected' : '' }>����+�۾���</option>
					<option value="tcw" ${pageMaker.cri.searchType eq 'tcw' ? 'selected' : '' }>����+����+�۾���</option>
				</select>
				<input type="text" name="keyword" placeholder="�˻���" value="${pageMaker.cri.keyword }">
				<input type="submit" value="�˻��ϱ�">
			</form>
		</div>
	</div>
</body>
</html>
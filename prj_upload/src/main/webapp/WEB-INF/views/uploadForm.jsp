<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<form action="uploadFormAction" method="post" enctype="multipart/form-data">
		<input type="file" name="uploadFile" multiple> <!-- multiple이 걸려있기 때문에 2개이상 업로드 가능 -->
		<button>Submit</button>	<!-- 버튼만 만들어도 서브밋으로 간주 -->
	</form>
</body> 
</html>
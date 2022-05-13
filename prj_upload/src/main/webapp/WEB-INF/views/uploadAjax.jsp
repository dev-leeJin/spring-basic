<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>Upload With Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<button id= "uploadBtn">Upload</button>
	<!-- 실제로 아무일도 일어나지 않는 상태. -->
	
	<!-- https://jquery.com/ -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>﻿
	
	<!-- 자바스크립트 이벤트를 활용해 제이쿼리를 사용할 수 있게 만듬. -->
	<!-- input type의 file0번째를 선언 -->
	<!-- formData를 써서 폼 태그를 만든다. -> 여기다 파일을 하나하나 반복문을 사용해서 집어넣음.  -->
	<script> 
		$(document).ready(function(){
									//.(문자한개) *(갯수제한없음) \.(.을 아무문자1개가 아닌 .자체로 쓸때)
									// 정규표현식에서 이메일 검증을 ->"(.*?)@(.*?)\.)(com|net|)$"이런 식으로 작성함.
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize){
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}		
				return true;
			}	
			
			$('#uploadBtn').on("click", function(e){
				
				var formData = new FormData();
				
				var inputFile = $("input[name='uploadFile']");
				
				var files =  inputFile[0].files;
				
				console.log(files);
				
				//파일 데이터를 폼에 집어넣기
				for(var i = 0; i < files.length; i++){
					if(!checkExtension(files[i].name, files[i].size)){ //검중->파일 크기가 넘어가거나 확장자가 regex에 해당하면 거르기.
						return false;
					}
					formData.append("uploadFile",files[i]); //formData에 append를 해서 파일정보를 보냄.
				}
				
				$.ajax({
					url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					success: function(result){
						alert("Uploaded"); //성공했을 때 뜸 (업로드가 되어도 404에러이기 때문에 뜨지 않음.)
					}
				}); //ajax
			});
		});
	</script>
	
	
</body>
</html>
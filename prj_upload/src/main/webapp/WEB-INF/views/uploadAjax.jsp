<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.uploadResult{
		width:100%;
		background-color:gray;
	}
	.uploadResult ul{
		display:flex;
		flex-flow:row;
		justify-content:center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style:none;
		padding:10px;
	}
	.uploadResult ul li img{
		width:30px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>Upload With Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
		<ul>
			<!-- 업로드된 파일이 들어갈 자리 -->
			
		</ul>
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
			// 첨부가 안 된 상태의 .uploadDiv를 깊은 복사해서 첨부 완료 후에 안 된 시점의 uploadDiv로 덮어씌우기
			var cloneObj = $(".uploadDiv").clone();
			
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
					dataType:'json',
					success: function(result){
						console.log(result);
						
						showUploadedFile(result);
						
						// 업로드 성공시 미리 복사해둔 .uploadDiv로 덮어씌워서 첨부파일이 없는 상태로 되돌려놓기
						$(".uploadDiv").html(cloneObj.html()); //# 장전된 상태의 업로드 창을 비워있는 상태로 되돌리기.
						alert("Uploaded"); //성공했을 때 뜸 (업로드가 되어도 404에러이기 때문에 뜨지 않음.)
					}
				}); //ajax
			}); // onclick uploadBtn
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr){
				var str="";
				$(uploadResultArr).each(function(i, obj){

					if(!obj.image){ // 이미지가 아니라면 resources 내부에 첨부파일 이미지 띄우기.
						
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid +  "_" + obj.fileName);
						
						// a태그르 이용해 클릭시 다운로드되게 설정. + x를 만들어 ajax에 온클릭을 걸어 누르면 삭제되게 만듬
						str += "<li><a href='/download?fileName="+fileCallPath+"'>" + "<img src='/resources/attach.png'>"
						+ obj.fileName + "</a>" +"<span data-file=\'" + fileCallPath + "\' data-type='file'> X </span>" 
						+ "</li>";
					}else{
						//str += "<li>" + obj.fileName + "</li>";
						// 2022.05.18 수정
						
						// (이미지 파일이라면 이미지 썸네일이 뜨도록 설정 + fileName)
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid +  "_" + obj.fileName);
						
						// 썸네일이 아닌 오리지날 파일을 만들어 다운은 썸네일이 아닌 오리지날로 받게 생성.
						var fileCallOriginal = encodeURIComponent(obj.uploadPath + "/" + obj.uuid +  "_" + obj.fileName);
						
						// a태그르 이용해 클릭시 다운로드되게 설정. + x를 만들어 ajax에 온클릭을 걸어 누르면 삭제되게 만듬
						str += "<li><a href='/download?fileName="+fileCallOriginal +"'>" + "<img src='/display?fileName=" + fileCallPath
								+ "'>" + obj.fileName + "</a>" +"<span data-file=\'" + fileCallPath + "\' data-type='image'> X </span>" 
								+ "</li>";
					}
	
				});
				uploadResult.append(str);
			}// sjowUploadedfile
			
			// x클릭시 어떤 데이터를 삭제해야하는지 얻어옴.
			$(".uploadResult").on("click","span",function(e){
				var targetFile = $(this).data("file"); // 삭제될 데이터 가져오기
				var type = $(this).data("type"); // 일반파일이면 썸네일을 내리면 안되기 때문에 타입 확인
				
				var targetLi = $(this).closest("li");
				
				$.ajax({
					url : '/deleteFile',
					data : {fileName: targetFile, type:type}, //타입이 이미지면 썸네일도 삭제
					dataType: 'text',
					type: 'POST',
					success: function(result){
						alert(result);
						targetLi.remove(); // 타겟으로 잡히면 삭제하는 구문 집어넣기
					}
				}); //ajax
			}); // click span
			
		}); //document
	</script>
	
	
</body>
</html>
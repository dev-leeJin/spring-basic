<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.uploadResult{
		width:100%;
		background-color:orangered;
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
	<!-- /boardInsert 로 보내는 post방식 폼을 생성해주세요
	폼에서 보내는 요소와 name속성값은 쿼리문을 참조해서 만들어주세요.
	insert로직을 실행하는 컨트롤러도 생성해주시고 return값은 "";로 우선 두겠습니다. 
	vo를 살펴본 결과 title, content, writer 3개 요소를 보내면 됨 -->
	<form action="/board/boardInsert" method="post">
		제목 : <input type="text" name="title"><br/>
		글쓴이 : <input type="text" name="writer"><br/>
		본문 : <textarea name="content" rows="20" cols="100"></textarea><br/>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<input id="submitBth" type="submit" value="글쓰기"> <input type="reset" value="초기화">
	</form>
	
	<h3>첨부파일 영역</h3>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class="uploadResult">
		<ul>
			<!-- 업로드된 파일이 들어갈 자리 -->
			
		</ul>
	</div>
	
	<button id= "uploadBtn">Upload</button>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script>
		// 비동기 ajax에 토큰 적용을 위해 스크립트태그 최상단에 토큰 변수 선언 (토큰을 넣지 않으면 로직 실행이 안됌.)
		var csrfHeaderName = "${_csrf.headerName}"
		var csrfTokenValue="${_csrf.token}"
	
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
					beforeSend : function(xhr) {
						 xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
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
					// BoardAttachVO내부에서 이미지여부를 fileType변수에 저장하므로 obj.image => obj.fileType
					if(!obj.fileType){ // 이미지가 아니라면 resources 내부에 첨부파일 이미지 띄우기.
						
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid +  "_" + obj.fileName);
						
						// a태그르 이용해 클릭시 다운로드되게 설정. + x를 만들어 ajax에 온클릭을 걸어 누르면 삭제되게 만듬
						str += "<li "
							+ "data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid
							+ "' data-filename = '" + obj.fileName + "' data-type='" + obj.fileType
							+ "'><a href='/download?fileName=" + fileCallPath
							+ "'>" +  "<img src ='/resources/attach.png'>"
							+ obj.fileName + " 📎 </a>"
							+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> 🚫 </span>"
							+"</li>";
					}else{
						//str += "<li>" + obj.fileName + "</li>";
						// 2022.05.18 수정
						
						// (이미지 파일이라면 이미지 썸네일이 뜨도록 설정 + fileName)
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid +  "_" + obj.fileName);
						
						// 썸네일이 아닌 오리지날 파일을 만들어 다운은 썸네일이 아닌 오리지날로 받게 생성.
						var fileCallOriginal = encodeURIComponent(obj.uploadPath + "/" + obj.uuid +  "_" + obj.fileName);
						
						// a태그르 이용해 클릭시 다운로드되게 설정. + x를 만들어 ajax에 온클릭을 걸어 누르면 삭제되게 만듬
						str += "<li "
							+ "data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid
							+ "' data-filename = '" + obj.fileName + "' data-type='" + obj.fileType
							+ "'><a href='/download?fileName=" + fileCallOriginal
							+ "'>" +  "<img src ='/display?fileName=" + fileCallPath
							+ "'>" + obj.fileName + " 📎 </a>"
							+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> ✅ </span>"
							+"</li>";
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
					beforeSend : function(xhr) {
						 xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success: function(result){
						alert(result);
						targetLi.remove(); // 타겟으로 잡히면 삭제하는 구문 집어넣기
					}
				}); //ajax
			}); // click span
			
			//글쓰기버튼을 누를 경우, 첨부파일 정보를 폼에 추가해서 전달하는 코드
			$("#submitBth").on("click", function(e){
				// 1. 제출버튼을 눌렀을 때 바로 작동하지 않도록 기능막기
				e.preventDefault();
				
				// 2. var formObj = $("form"); 로 폼태그를 가져옵니다.
				var formObj = $("form");
				
				var str ="";
				
				// 3. 5.19 = 첨부파일 내에 들어있던 이미지 정보를 콘솔에 찍기만하고 종료
				$(".uploadResult ul li").each(function(i, obj){					
					var jobj = $(obj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName'"
						+ " value='" + jobj.data("filename") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].uuid'"
						+ " value='" + jobj.data("uuid") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].uploadPath'"
						+ " value='" + jobj.data("path") + "'>"
						+ "<input type='hidden' name='attachList[" + i + "].fileType'"
						+ " value='" + jobj.data("type") + "'>";
				});
				// 폼태그에 위의 str내부 태그를 추가해주는 명령어, .submit()을 추가로 넣으면 제출 완료
				formObj.append(str).submit();
			});
			
		}); //document
	</script>
	
</body>
</html>
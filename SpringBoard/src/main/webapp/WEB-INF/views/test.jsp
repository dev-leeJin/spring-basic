<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>Ajax 테스트</h2>
	
	<ul id = "replies">
	
	</ul>
	
	<ul id ="test"> <!-- jquery를 이해하기 위한 연습 코드 -->
		#test 사이에 daum.net으로 이동하는 a태그를 jquery를 이용해 넣어주세요.
	</ul>
	<button id = "testBtn">테스트</button>
	
	<!-- jquery cdn 로드 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 비동기 요청 부분 -->
	<script type="text/javascript">
		let bno = 327700;
	function getAllList(){	
		// $.getJSON은 입력한 주소에 get방식으로 요청을 넣는다. 
					//주소에 접속				//콜백함수() //주소 요청으로 얻어온 json을 어떻게 처리할지	
		$.getJSON("/replies/all/" + bno, function(data){
			// 문자열을 이용해 태그를 생성하거나 끼워넣을 수 있으므로
			// 빈 문자열을 만들어놓고 거기에 댓글정보를 저장해 화면에 전송
			let str = "";
			console.log(data); // 요청을 넣은 주소의 데이터를 얻어와 function을 이용해 어떻게 처리할지 정하기.(console에 찍기)(디버깅)
			
			// 들고 온 데이터를 반복해서 출력하기
			//$(JSON형식데이터).each => 내부 JSON을 향상된 for문 형식으로 처리합니다. 
			// 역시 내부에 콜백함수(로직이 실행되었을때 추가로 실행할 구문을 정의하기위해 파라미터로 넣는 함수)
			// 를 이용해 data를 하나하나 향상된 for문형식으로 처리할때 실행구문을 적을 수 있습니다. 
			$(data).each(function() { 
					// 하나하나 반복되는 각 데이터는 this라는 키워드로 표현됩니다. 
					// data-변수명=변수 를 사용해 나중에 수정이나 하나하나 관리할 때 사용
					str += "<li data-rno='" + this.rno + "' class='replyLi'>"
						+ this.rno + ":" + this.reply
						+ "</li>";
				});
			// #replies사이에 끼워넣을수있도록 console.log()로 디버깅
			console.log(str);
			
			$("#replies").html(str); //아이디replies의 html(str)을 화면에 표출 (문자도 표출가능)
			});
	}
	// 함수 호출 구문을 적어야 진짜 실행됨, 함수 선언부는 작성한다고 해서 바로 실행되지 않음.
	getAllList();
			
			// 비동기식이고 사용자가 버튼을 눌러 요청했을 때 데이터가 나오게 세팅
			// 버튼(testBtn)클릭시 발동되는 이벤트 (#testBtn을 click하면 function 57~64을 실행 )
			$("#testBtn").on("click",function(){
				// 1.#test에 넣어줄 문자를 생성
				let strTest = "<a href='https://www.daum.net'>다음으로 이동</a>";
				
				// 2. #test를 jquery로 잡고, 태그 내부에 strTest를 채워줌
				$("#test").html(strTest);
				
			});
	</script>
	
</body>
</html>
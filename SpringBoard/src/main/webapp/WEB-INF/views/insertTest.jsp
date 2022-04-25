<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h2>Ajax 댓글 등록 테스트</h2>
	
	<ul id = "replies"> <!-- test기능 가져옴 -->
	
	</ul>
	<!-- 댓글 작성 공간 -->
	<div>
		<div>
			댓글 글쓴이 <input type= "text" name ="replyer" id="newReplyWriter">
		</div>
		<div>
			댓글 내용 <input type="text" name="reply" id="newReplyText">
		</div>
		<button id="replyAddBtn">댓글 추가</button>
	</div>
	
	<!-- 위임 이해를 위한 코드(실제로는 필요 없는 코드) -->
	<button class="test">테스트1</button>
	<button class="test">테스트2</button>
	<button class="test">테스트3</button>
	<button class="test">테스트4</button>
	
	
	<!-- jquery cdn 가져오기 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<!-- 스크립트 태그로 자바스크립트 요청 확인 -->
	<script type="text/javascript">
		var bno = 327700;
		
		// 현재insertTest에는 getJSON을 정의하지 않아서 댓글목록을 볼 수 없다.
		// /test에서 코드를 복붙하고 ul태그 #replies도 가져와서 댓글목록과, 댓글쓰기 창이 
		// 한 화면에 보이도록 코드를 수정
		function getAllList(){	
				
			$.getJSON("/replies/all/" + bno, function(data){
				let str = "";
				console.log(data);
				$(data).each(function() { 
						str += "<li data-rno='" + this.rno + "' class='replyLi'>"
							+ this.rno + ":" + this.reply
							+ "<button>수정/삭제</button></li>";
					});
				console.log(str);
				$("#replies").html(str); 
				});
		}
		getAllList(); // 댓글 전체 들고와서 #replies에 심어주는 로직 실행
		
		// insert 구문
		$("#replyAddBtn").on("click", function(){
			
			// 폼이 없기때문에, input태그 내에 입력된 요소를 가져와야 합니다. 
			// 버튼을 누르는 시점에, 글쓴이와 내용 내부에 적힌 문자열을 변수에 저장합니다. 
			var replyer = $("#newReplyWriter").val();
			var reply = $("#newReplyText").val();
			
			// $.ajax({내용물}); 이 기본형태 
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					reply : reply
				}),
				success : function(result) {
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						
						getAllList();// 댓글 등록 성공시, 다시 목록 갱신 (새로고침 하지 않아도 바로 적용)
						// 댓글 작성 완료 후 폼 태그 비우기. 힌트: .val(넣을값);=갱신
						$("#newReplyWriter").val("");
						$("#newReplyText").val("");					
					}
				}
			});
		});
		
		// .test를 클릭하면 "테스트 클릭 감지"라는 alert를 띄우도록 이벤트를 걸어보세요.
		$(".test").on("click",function(){
			console.log(this); // this는 클릭 된 요소이다. 
			// 클릭요소와 텍스트까지 같이 띄워주세요.(ex : 테스트1 클릭 감지..)
			alert(this.html() + "클릭 감지");
		});
		
		// 이벤트 위임 (버튼 하나하나를 개별적으로 적용)
		$("#replies").on("click", ".replyLi button", function(){ //.reploes > replyLi :button형식으로 작동. 
			// 클릭한 요소가 this이고, 현재 button에 걸렸기 때문에
			// this는 button입니다. button의 부모가 바로 .replyLi입니다.
			// 즉, 클릭한 버튼과 연계된 li 태그를 replytag 변수에 저장합니다. 0
			var replytag = $(this).parent();
			console.log(replytag);
			
			// 클릭한 버튼과 연계된 li태그의 data-rno에 든 값 가져와 변수 rno에 저장하기
			var rno = replytag.attr("data-rno");
			console.log(rno);
			
			// rno뿐만 아니라 본문도 가져와야함
			var reply = replytag.text(); // 내부 text를 가져옴
			
			alert(rno + " : " + reply); // 내부 text와 댓글번호를 alert으로 띄움
		});
		
	</script>
</body>
</html>
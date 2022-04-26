<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#modDiv {
		width : 300px;
		height : 100px;
		background-color : green;
		position : absolute; 
		top : 50%;
		left : 50%;
		margin-top : -50px;
		margin-left : -150px;
		padding : 10px;
		z-index: 1000;
	}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!-- javaScript를 사용하기 위한 번들 주소 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
	
	<!-- 위임 이해를 위한 코드(실제로는 필요 없는 코드) 
	<button class="test">테스트1</button>
	<button class="test">테스트2</button>
	<button class="test">테스트3</button>
	<button class="test">테스트4</button> -->
	
	<!-- modal은 일종의 팝업입니다.
	단, 새 창을 띄우지는 않고 css를 이용해 특정 태그가 조건부로 보이거나 안 보이도록 처리해서
	마치 창이 새로 띄워지는것처럼 만듭니다
	따라서 눈에 보이지는 않아도 modal을 구성하는 태그 자체는 화면에 미리 적혀있어야 합니다. -->
	<!-- 위치는 스크립트 태그 위에다가 해야함.(스크립트 태그가 맨 마지막에 와야함) -->
	<div id="modDiv" style="display:none;"> <!-- div3개를 활용해 만드는게 일반적이지만 사실 맨 위에 div만 있어도 모달은 생성된다.  -->
		<div class="modal-title">
		</div>
		<div>
			<input type="text" id="reply">
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button> <!-- 수정 -->
			<button type="button" id="replyDelBtn">Delete</button> <!-- 삭제 -->
			<button type="button" id="closeBtn">Close</button> <!-- 닫기 -->
		</div>
	</div>
	
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
		//$(".test").on("click",function(){
		//	console.log(this); // this는 클릭 된 요소이다. 
			// 클릭요소와 텍스트까지 같이 띄워주세요.(ex : 테스트1 클릭 감지..)
		//	alert(this.html() + "클릭 감지");
		//});
		
		// 이벤트 위임 (버튼 하나하나를 개별적으로 적용)
		$("#replies").on("click", ".replyLi button", function(){ //.reploes > replyLi :button형식으로 작동. (.replyLi를 생략해서 적어도 되는데 가독성을 위해 적음.)
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
			
			//alert(rno + " : " + reply); // 내부 text와 댓글번호를 alert으로 띄움
			
			$(".modal-title").html(rno); //modal-title 부분에 글번호 입력
			$("#reply").val(reply); //reply 영역에 리플 내용을 기입(수정/삭제)
			$("#modDiv").show("slow"); //버튼 누르면 모달 열림
		});
		
		// 모달 창 닫기 이벤트
		$("#closeBtn").on("click", function(){ // #closeBtn 클릭시
			$("#modDiv").hide("slow"); // #modDiv를 닫습니다. //slow는 애니메이션 효과.
		});
		
		// 삭제버튼 작동 (삭제로직)
		$("#replyDelBtn").on("click",function(){
			let rno = $(".modal-title").html(); //modal-title내부에 있는 rno를 먼저 받아온다.
			
			$.ajax({ //제이슨 형식으로 요청을 넣기 때문에 ,(콤마)로 나열
				type : 'delete',
				url : '/replies/' + rno,
				header : {
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					console.log("result: " + result);
					if(result == 'SUCCESS') {
						alert("삭제 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList(); // 삭제된 댓글 반영한 새 댓글목록갱신
					}
				}
			});
		});
		
		// 수정버튼 작동 (수정로직)
		$("#replyModBtn").on("click",function(){ //수정로직은 제이슨에 대해 받아와야 하기 때문에 어플리케이션 제이슨을 기입
			var rno = $(".modal-title").html();
			var reply = $("#reply").val(); // data정보를 받아오기 위해 필요 (댓글내용을 가져와서 넣어줘야 수정 가능)
			
			$.ajax({
				type : 'patch', // type은 put을 사용해도 정상 작동함. 
				url : '/replies/' + rno,
				header : {
					"Content-Type" : "application/json", //rno만으로 돌아가는 delet와 달리 json자료를 추가로 입력받음
					"X-HTTP-Method-Override" : "PATCH"
				},
				contentType : "application/json",
				data : JSON.stringify({reply:reply}),
				dataType : 'text',
				success : function(result) {
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						$("#modDiv").hide("slow");
						getAllList(); // 수정 완료 후 반영한 새 댓글목록갱신
					}
				}
			});
		});
		
	</script>
</body>
</html>
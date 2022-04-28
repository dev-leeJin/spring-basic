<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	#modDiv {
		width : 500px;
		height : 100px;
		background-color : skyblue;
		border : blue solid 2px;
		position : absolute;  
		top : 50%;
		left : 50%;
		margin-top : -50px;
		margin-left : -150px;
		padding : 10px;
		z-index: 1000;
	}
	#reply{
		width : 450px;
	}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<h1 class= "text text-primary">${board.bno }번글 조회중</h1>
	<div class="row">
		<div class="col-md-9">
			<input type="text" class="form-control" value="제목 : ${board.title }">
		</div>
		<div class="col-md-3">
				<input type="text" class="form-control" value="글쓴이 : ${board.writer }" />
		</div>
	</div>
	<textarea rows="10" class="form-control">${board.content }</textarea>
	<div class="row">
		<div class="col-md-3">쓴날짜 :</div>
		<div class="col-md-3">${board.regdate }</div>
		<div class="col-md-3">수정날짜 :</div>
		<div class="col-md-3">${board.updatedate } </div>
	</div>
	<div class="row">
		<div class="col-md-4">
			<a href="/board/boardList?pageNum=${param.pageNum == null ? 1 : param.pageNum }&searchType=${param.searchType}&keyword=${param.keyword}" class="btn btn-success">글목록</a>
		</div>
		<div class="col-md-4">
			<form action="/board/boardUpdateForm" method="post">
				<input type="hidden" name="bno" value="${board.bno }" />
				<input type="hidden" name="pagdNum" value="${param.pageNum }" />
				<input type="hidden" name="searchType" value="${param.searchType}" />
				<input type="hidden" name="keyword" value="${param.keyword}" />
				<input type="submit" value="수정" class="btn btn-warning">
			</form>
		</div>
		<div class="col-md-4">
			<form action="/board/boardDelete" method="post">
				<input type="hidden" value="${board.bno }" name="bno"/>
				<input type="hidden" name="pagdNum" value="${param.pageNum }" />
				<input type="hidden" name="searchType" value="${param.searchType}" />
				<input type="hidden" name="keyword" value="${param.keyword}" />
				<input type="submit" value="삭제" class="btn btn-danger">
			</form>
		</div>
	</div>


	<!-- insertTest.jsp에서 댓글 기능 가져오기 -->

	<!-- 댓글 영역 -->
	<div class="row">
	<h2 class="text-primary">댓글</h2>
	<!-- -댓글이 추가될 공간 -->
		<div id = "replies">
		
		</div>
	</div>
	
	
	<!-- 댓글 작성 공간 -->
	<div class="row box-box-success">
		<div class="box-header">
			<h2 class="text-primary">댓글 작성</h2>
		</div><!-- header -->
		<div class="box-body">
			<strong>Writer</strong>
			<input type="text" id="newReplyWriter" placeholder="Replyer" class="form-control">
			<strong>ReplyText</strong>
			<input type="text" id="newReplyText" placeholder="ReplyText" class="form-control">
		</div> <!-- body -->
		<div class="box=footer">
			<button type="button" class="btn btn-success" id="replyAddBtn">Add Reply</button>
		</div> <!-- footer -->
	</div>
	
	</div>	<!--container -->
	
	<!-- 모달 -->
	<div id="modDiv" style="display:none;">
	<div class="modal-title">
	</div>
	<div>
		<input type="text" id="reply" >
	</div>
	<div>
		<button type="button" id="replyModBtn">Modify</button> <!-- 수정 -->
		<button type="button" id="replyDelBtn">Delete</button> <!-- 삭제 -->
		<button type="button" id="closeBtn">Close</button> <!-- 닫기 -->
	</div>
	</div>
	
	<!-- jquery cdn 가져오기 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<!-- 여기부터 댓글 비동기 처리 자바스크립트 처리 영역 -->
	<!-- boardDetail하단에 댓글 작성공간(modal), 댓글 추가공간(#replies),
	자바스크립트 코드들 부트스트랩 css와 부트스트랩js를 적절히 복붙해서 댓글이 표현되고, 쓰고, 삭제하는게 가능하도록 만들어주세요.  -->
	<script>
	let bno = ${board.bno};
	
	// 전체 댓글 가져오기
	function getAllList(){	
		
		$.getJSON("/replies/all/" + bno, function(data){
			let str = "";
			console.log(data);
			
			// 4.27 날짜 처리를 위해 자바스크립트의 Date 객체를 이용해 수정.
			$(data).each(function() { // getjson내부를 수정해서 댓글번호 표기 대신 @글쓴이-날짜 글내용으로 변경 (div형태로 수정)
				let timestamp = this.updateDate;
				let date = new Date(timestamp); // timestamp에 들어간 유닉스 시간 표시를 date에 넣어서 우리 시간으로 바꾸기.
				
				let formattedTime = "게시일 : " + date.getFullYear()
									+ "/"+ (date.getMonth()+1)
									+ "/"+ date.getDate()
									// 시분초도 추가
									+ "-" + date.getHours()
									+ ":" + date.getMinutes()
									+ ":" + date.getSeconds();
									
					str += "<div class='replyLi' data-rno ='" + this.rno + "'><strong>@"
						+ this.replyer + "</strong> - " + formattedTime + "<br>"
						+ "<div class='reply'>" + this.reply + "</div>"
						+ "<button type='button' class='btn btn-info'>수정/삭제</button>"
						+ "</div>";
				});
			console.log(str);
			$("#replies").html(str); 
			});
	}
	getAllList();
	
	// 댓글 작성
	$("#replyAddBtn").on("click", function(){
	 
		var replyer = $("#newReplyWriter").val();
		var reply = $("#newReplyText").val();

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
					
					getAllList();
					$("#newReplyWriter").val("");
					$("#newReplyText").val("");					
				}
			}
		});
	});
	
	// 이벤트 위임 (버튼 하나하나를 개별적으로 적용) (모달 창 열기)
	$("#replies").on("click", ".replyLi button", function(){
		
		var replytag = $(this).parent(); // -> 얘를 쓰던 변수를 변경할거임. 
		
		// 4.27수정 : this(button)의 부모(.replyLi)가 아닌
		// 형제 태그 .reply의 내용을 대신 가져올수 있도록
		// 변수 replyContent를 선언해 거기에 저장해주세요.
		// (hint : .siblings("요소명"); 으로 형제태그를 가져올수 있습니다. )
		//(방법은 많음.)
		//var replyContent = $(this).prev().text(); // button의 직전 태그인 .reply의 내용을 가져오기
		//var replyContent = $(this).parent().children(".reply").text();
		var replyContent = $(this).siblings(".reply").text(); // button의 형제 중 .reply의 내용을 가져오기
		
		console.log(replytag);

		var rno = replytag.attr("data-rno");
		console.log(rno);

		var reply = replytag.text();

		$(".modal-title").html(rno); 
		$("#reply").val(replyContent); // 본문 내용만 받아오기로 수정.
		//$("#reply").val(reply); 
		$("#modDiv").show("slow"); 
	});
	
	// 모달 창 닫기 이벤트
	$("#closeBtn").on("click", function(){ 
		$("#modDiv").hide("slow"); 
	});
	
	// 삭제버튼 작동 (삭제로직)
	$("#replyDelBtn").on("click",function(){
		let rno = $(".modal-title").html(); 
		
		$.ajax({ 
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
					getAllList(); 
				}
			}
		});
	});
	
	// 수정버튼 작동 (수정로직)
	$("#replyModBtn").on("click",function(){ 
		var rno = $(".modal-title").html();
		var reply = $("#reply").val();
		
		$.ajax({
			type : 'patch', 
			url : '/replies/' + rno,
			header : {
				"Content-Type" : "application/json", 
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
					getAllList(); 
				}
			}
		});
	});
	
	
	</script>
</body>
</html>
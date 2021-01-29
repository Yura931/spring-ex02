<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<script>
var appRoot = '${root}';
var bno = ${board.bno};
</script>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<script src="${root }/resources/js/reply.js"></script>
<script>
// 위의 script파일들은 순서대로 실행 됨
// script실행 이전에 javaScript로 변수 설정해두면 됨
// console.log(replyService.name);
// replyService.add("my reply"); //add함수를 실행시킨 것 , reply.js파일의 replyService의 add함수를 실행시킨 것 , add함수는 파라미터를 가짐, 이 안에 파라미터 값을 넣어준 것

/*

replyService.get(21, function(data) {
	console.log(data);
});
*/

/*
replyService.add({
	bno:300, 
	reply:"new reply 댓글", 
	replyer:"user00"
	}, function(result) {
		console.log(result);
	}, function(er) {
		console.log(er);	
	});
*/

/*
replyService.getList({
	bno:7,
	page:1
	}, function(data) {
		console.log(data); 
	}, function() {
		console.log("error");
});
*/

/*
replyService.remove(10, function(data, status){
		console.log(data);
		console.log(status);
	}, function(err) {
		console.log(err);
});
*/

/*
replyService.update({
	rno:37,
	reply:'또 수정된 본문',
	}, function(data, status){
		console.log(data);	
	}, function(err){
		console.log(err);
});
*/
<%--
$(document).ready(function() {
	
	var message = '${message}';
	
		checkModal2(message);
	
	history.replaceState({}, null, null);
	
		function checkModal2(message) {
			if (message && history.state == null) {
				$("#myModal .modal-body p").html(message);
				$("#myModal").modal("show");		
		}
	}
});	
--%>
</script>
<script>
$(document).ready(function() {
	// 날짜 형식
	function dateString(date) {
		var d = new Date(date);
		return d.toISOString().split("T")[0];
	}
	
	// 댓글 목록
	function showList() {
			
		replyService.getList({ 
			bno: ${board.bno} // script코드에 jsp코드가 추가된 것  
		}, function(list){
		// console.log(list);
			
			var replyUL = $("#reply-ul");
				replyUL.empty();
			for (var i = 0; i < list.length; i++) {
				var replyLI = '<li class="media" data-rno="'+ list[i].rno +'"><div class="media-body"><h5>'
				+ list[i].replyer + '<small class="float-right">' 
				+ dateString(list[i].replyDate) + "</small></h5>"
				+ list[i].reply + "<hr></div></li>";
				
				replyUL.append(replyLI);
			}
		});
	}	
	
	
	
	// 새 댓글 버튼 클릭 이벤트 처리
	$("#new-reply-button").click(function() {
		console.log("new reply button clicked....");
		$("#new-reply-modal").modal("show");
	});
	
	 // loding 된 다음 실행되도록
	
	// 새 댓글 등록 버튼 클릭 이벤트 처리
	$("#reply-submit-button").click(function() {
		
		
		// input 태그의 value 가져와 변수에 저장
		var reply = $("#reply-input").val();  
		var replyer = $("#replyer-input").val();
		
		var data = {bno:bno, reply:reply, replyer:replyer};
		
		replyService.add(data, 
			function() {
			 // $("#reply-ul").empty();
				showList();
				alert("댓글 등록에 성공하였습니다.");
		},	function() {
				alert("댓글 등록에 실패하였습니다.");
		});
		
		// 모달 창 닫기
		$("#new-reply-modal").modal("hide");
		
		// 모달 창 안에 있는 input 요소들 value를 초기화
		$("new-reply-modal input").val(""); 		
		});
	 
	 	// reply-ul 클릭 이벤트 처리
	 	$("#reply-ul").on("click","li",  function() {
	 	//	console.log("reply ul clicked....");	 	
	 		console.log($(this).attr("data-rno"));
	 		
	 		// 하나의 댓글 읽어오기
	 		var rno = $(this).attr("data-rno");
	 		
	 		replyService.get(rno, function(data) {	
	 			$("#rno-input2").val(rno);
	 			$("#reply-input2").val(data.reply);
	 			$("#replyer-input2").val(data.replyer);
	 			$("#reply-modify-modal").modal("show");
	 		});
		});  
	 	
	 	// 수정 버튼 이벤트 처리
	 	$("#reply-modify-button").click(function() {	 		
	 		var rno = $("#rno-input2").val();
	 		var reply = $("#reply-input2").val();
	 		var data = {rno:rno, reply:reply};
	 		
	 		replyService.update(data, function() {
	 			alert("댓글을 수정하였습니다.");
	 			$("#reply-modify-modal").modal("hide");
	 			showList();	 	
	 		}); 
	 			
	 	});
	 	
	 	// 삭제 버튼 이벤트 처리
	 	$("#reply-delete-button").click(function() {
	 		var rno = $("#rno-input2").val();
	 		replyService.remove(rno, function(){
	 			alert("댓글을 삭제하였습니다.");
	 			$("#reply-modify-modal").modal("hide");
	 			showList();
	 		})
	 	})
	 	showList();
 
});     
</script>

<title>Insert title here</title>
</head>
<body>

<u:navbar/>
	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				<h1>게시물 작성</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				
					<div class="form-group">						
						<label for="input3">번호</label> <input id="input3" readonly value='<c:out value="${board.bno }" />'
							class="form-control" >
					</div>
						
					<div class="form-group">	
						<label for="input1">제목</label> <input readonly value='<c:out value="${board.title }"/>' type="text"
							class="form-control" id="input1" >
					</div>

					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea readonly class="form-control" id="textarea1"
							rows="3"><c:out value="${board.content }"/></textarea>
					</div>

					<div class="form-group">
						<label for="input2">작성자</label> <input type="text"
							class="form-control" id="input2" readonly value='<c:out value="${board.writer }" />' >
					</div>
					
					<c:url value="/board/modify" var="modifyLink">
						<c:param name="bno" value="${board.bno }"></c:param>
						<c:param name="pageNum" value="${cri.pageNum }"></c:param>
						<c:param name="amount" value="${cri.amount }"></c:param>
						<c:param name="type" value="${cri.type }" ></c:param>
						<c:param name="keyword" value="${cri.keyword }" ></c:param>
					</c:url>
					<a href="${modifyLink }" class="btn btn-secondary">
						수정
					</a>
					
			</div>
		</div>
	</div>
	
	<div class="container-sm mt-3">
		<div class="row">
			<div class="col-12 col-lg-6 offset-lg-3">
				
				<div class="card">
					<div class="card-header d-flex justify-content-between align-items-center">
						<span>
						댓글 목록
						</span>
						<button class="btn btn-info" id="new-reply-button">댓글 쓰기</button>
					</div>
						
					<div class="card-body">
						
						<ul class="list-unstyled" id="reply-ul">
							
							<li class="media" data-rno="21"> <%--data- prefix사용--%>
								
								<div class="media-body">
									
									<h5>user00 <small>2021/01/29</small></h5>
										댓글 본문 ......
										<hr>
								</div>
								
							</li>
														
						</ul>
						
					</div>
					
				</div>
				
			</div>
			
		</div>
	</div>

<%-- modal 새 댓글 form --%>
	<div class="modal fade" id="new-reply-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						새 댓글
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="reply-input" class="col-form-label">
							댓글
						</label>
						<input type="text" class="form-control" id="reply-input">
					</div>
					<div class="form-group">
						<label for="replyer-input" class="col-form-label">
							작성자
						</label>
						<input type="text" class="form-control" id="replyer-input">
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="reply-submit-button">등록</button>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
	<%-- modal 수정 form --%>
		<div class="modal fade" id="reply-modify-modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						수정 / 삭제
					</h5>
					<button type="button" class="close" data-dismiss="modal">
						<span>&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input id="rno-input2" type="hidden">
					<div class="form-group">
						<label for="reply-input2" class="col-form-label">
							댓글
						</label>
						<input type="text" class="form-control" id="reply-input2">
					</div>
					<div class="form-group">
						<label for="replyer-input2" class="col-form-label">
							작성자
						</label>
						<input readonly type="text" class="form-control" id="replyer-input2">
					</div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-secondary" id="reply-modify-button">수정</button>
						<button type="button" class="btn btn-danger" id="reply-delete-button">삭제</button>
					</div>
					
				</div>
			</div>
		</div>
	</div>


</body>
</html>





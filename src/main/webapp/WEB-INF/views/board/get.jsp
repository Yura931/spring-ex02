<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
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
// console.log(replyService.name);
// replyService.add("my reply"); //add함수를 실행시킨 것 , reply.js파일의 replyService의 add함수를 실행시킨 것 , add함수는 파라미터를 가짐, 이 안에 파라미터 값을 넣어준 것



console.log(replyService.add);

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

<title>Insert title here</title>
</head>
<body>

<u:navbar/>
	<div class="container-sm">
		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
				<h1>게시물 작성</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-12 col-sm-6 offset-sm-3">
				
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
<%--
<div id="myModal" class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>처리가 완료되었습니다.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
 --%>

</body>
</html>





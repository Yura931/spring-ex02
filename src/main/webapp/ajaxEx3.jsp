<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(document).ready(function() {
	$("#btn-1").click(function() {
		$.ajax({
			type: "post",
			url: "/replies/new",
			contentType: "application/json",
			data: '{"bno":7, "reply":"새 댓글", "replyer":"user01"}',
			success: function(data, status, xhr) {
				console.log(data);
			}
		});
	});
	
	$("#btn-2").click(function() {
		$.ajax({
			type: "post",
			url: "/replies/new",
			contentType: "application/json",
			data: '{"reply":"새 댓글", "replyer":"user01"}',
			complete: function(jqXHR, status) { 
				console.log("complete");
				console.log(status);
			}
		});
	});
	
	$("#btn-3").click(function() {
		$.ajax({
			type: "post",
			url: "/replies/new",
			contentType: "application/json",
			data: '{"bno":7, "reply":"새 댓글", "replyer":"user00"}',
			success: function(data, status, xhr) { // settings의 적절한 프로퍼티를 넣어서 사용
				console.log("등록 성공");
				// console.log(jqXHR.responseText); // 응답 텍스트 보여주는 일, success일 때 함수의 파라미터 중 첫번째 파라미터가 responseText와 같은 일을 함
				console.log(data);
			},
			error: function() {
				console.log("등록 실패"); // success와 error함수 사용
			}
		});
	});
	
	$("#btn-4").click(function() {
		$.ajax({
			type: "get",
			url: "/replies/pages/7/1",
			success: function(data, status, xhr) {
				console.log(data);
			}
		});
	});
	
	$("#btn-5").click(function(){
		$.ajax({
			type: "delete",
			url: "/replies/35",
			success: function() { // 내부에서 사용하지 않을 시 파라미터 생략 가능
				console.log("삭제 성공");
			},
			error: function() {
				console.log("삭제 실패");
			}
		});
	});
	
	$("#btn-6").click(function() {
		$.ajax({
			type: "put",
			url: "/replies/37",
			data: '{"bno":7, "reply":"수정본~"}',
			contentType: "application/json;charset=utf-8", // 인코딩까지 하고싶으면 ; charset=utf-8추가
			success: function(data, status, xhr) {
				console.log("수정 됨");
				console.log(data);
			},
			error: function() {
				console.log("수정 안됨..");
			}
		});
	});
});
</script>
</head>
<body>
<h1>AJAX EX3</h1>
 
<div> 
<button id="btn-1">댓글 등록 성공</button>
<button id="btn-2">댓글 등록 실패</button>
<button id="btn-3">댓글 등록 성공 또는 실패</button>
<button id="btn-4">댓글 목록</button>
<button id="btn-5">댓글 삭제</button>
<button id="btn-6">댓글 수정</button>
</div>
</body>
</html>
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
			complete: function(jqXHR, status) { // 기능 , 곧 property의 값이 function()임
				console.log("complete");
				console.log(status);
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
			complete: function(jqXHR, status) {
				if (status === "success"){
					console.log("등록 성공");
					console.log(jqXHR.responseText);
				} else if (status === "error") {
					console.log("등록 실패");
				}				
			}
		});
	});
	
	$("#btn-4").click(function() {
		$.ajax({
			type: "get",
			url: "/replies/pages/7/1",
			complete: function(jqXHR, status) {
				if(status === "success") {
					console.log(jqXHR.responseText);
				}
			}
		});
	});
	
	$("#btn-5").click(function(){
		$.ajax({
			type: "delete",
			url: "/replies/35",
			complete: function(jqXHR, status) {
				if (status === "success") {
					console.log("삭제 성공");
				} else if (status === "error") {
					console.log("삭제 실패");
				}
			}
		});
	});
	
	$("#btn-6").click(function() {
		$.ajax({
			type: "put",
			url: "/replies/37",
			data: '{"bno":7, "reply":"수정본~"}',
			contentType: "application/json;charset=utf-8", // 인코딩까지 하고싶으면 ; charset=utf-8추가
			complete: function(jqXHR, status) { // 응답이 왔을 때 일어나는 일이 complete에서 실행 됨, 응답 받은 이후에 일을 함
				if(status === "success") {
					console.log("수정 됨");
					console.log("complete");
					console.log(jqXHR.responseText); // jqXHR ajax 객체라고 생각
				} else if(status === "error") {
					console.log("수정 안됨...");
				}
			}
		});
	});
});
</script>
</head>
<body>
<h1>AJAX EX2</h1>
 
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
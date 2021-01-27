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
<script type="text/javascript">
$(document).ready(function() {
	$("#btn-1").click(function() {
		$.ajax({
			method: "POST",
			url: "/replies/new",
			data: '{"bno":7, "reply":"new reply10", "replyer":"user00"}',
			contentType: "application/json"
			// 안쪽에 큰따옴표(")사용해야할 경우 바깥에 작은따옴표(')사용
		}); // javascript 객체 표현방식 {} 사용, settings가 들어간 것 
	});
	
	$("#btn-2").click(function() {
		$.ajax({
			method: "GET",
			url: "/replies/pages/7/1" // get방식 요청은 body가 필요없기 때문에 data함수 사용하지 않음
		});
	});
	
	$("#btn-3").click(function(){
		$.ajax({
			method: "PUT",
			url: "/replies/35",
			data: '{"bno":7, "reply":"modify reply", "replyer":"user01"}',
			contentType: "application/json"
		});
	});
	
	$("#btn-4").click(function(){
		$.ajax({
			method: "DELETE",
			url: "/replies/2"
		});
	});
	
	$("#btn-5").click(function(){
		$.ajax({
			method: "GET", // method -> type으로 써주어도 됨
			url: "/replies/37",
			contentType: "application/json",
			complete: function(jqXHR, status) {
				if (status === "success"){
				console.log(jqXHR.responseText);		
				console.log("complete");
				console.log(status);
				}
			}	
		});
	});
});
</script>
</head>
<body> 
<h1>AJAX ex1</h1>

<div>
<button id="btn-1">새 댓글</button>
<button id="btn-2">댓글 목록</button>
<button id="btn-3">수정</button>
<button id="btn-4">삭제</button>
<button id="btn-5">댓글</button>
</div>
</body>
</html>
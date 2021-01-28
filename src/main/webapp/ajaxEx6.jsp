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
		$.ajax("/replies/new", { // 첫번째 파라미터는 String url, 두번째 파라미터는 settings 객체, settings의 옵션들 사용
			type: "post",
			contentType: "application/json",
			data: '{"bno":7, "reply":"새 댓글", "replyer":"user01"}'
		}).done(function(data, status, xhr){
			console.log(data);
			console.log(status);
		});
	});
	
	$("#btn-2").click(function() {
		$.ajax("/replies/new", {
			type: "post",
			contentType: "application/json",
			data: '{"reply":"새 댓글", "replyer":"user01"}'
		}).fail(function(xhr, status) {
			console.log("complete");
			console.log(status);
		});
	});
	
	$("#btn-3").click(function() { // done, fail 사용
		$.ajax("/replies/new", {
			type: "post",
			contentType: "application/json",
			data: '{"bno":7, "reply":"새 댓글", "replyer":"user00"}'			
		}).done(function(data, status, xhr) {
			console.log("등록 성공")
			console.log(data);
		}).fail(function() {
				console.log("등록 실패");
		});    	// ajax메소드의 리턴값에 연결해서 사용하면 됨, ajax 함수가 끝나는 부분에 붙여 사용 가능
	});
	
	$("#btn-4").click(function() {
		$.get("/replies/pages/7/1", {

		}).done(function(data, status, xhr) {
			console.log(data);
		});
	});
	
	$("#btn-5").click(function(){
		$.ajax("/replies/35", {
			type: "delete",
		}).done(function() { 
			console.log("삭제 성공");
		}).fail(function() {
			console.log("삭제 실패");
		});
	});
	
	$("#btn-6").click(function() {
		$.ajax("/replies/37", {
			type: "put",
			data: '{"bno":7, "reply":"수정본~"}',
			contentType: "application/json;charset=utf-8"
		}).done(function(data, status, xhr) {
				console.log("수정 됨");
				console.log(data);
		}).fail(function() {
				console.log("수정 안됨..");
		});
	});
	
	// 7~ 하는 일 유사
	$("#btn-7").click(function() {
		$.get("/replies/37",  // settings의 type옵션 자동으로 get으로 설정됨 type:"get" 생략 가능
				{}).done(function(data, status, xhr) {
			console.log(data);
		});
	});
	
	$("#btn-8").click(function() {
		$.get("/replies/37", function(data, status, xhr) { // get메소드의 success파라미터값과 .done메소드의 하는일이 같음
			console.log(data)
		}); 
	});
	
	$("#btn-9").click(function() {
		$.get("/replies/37", function(data, status, xhr) { // ajax와 같은 일을 하는 get타입 메소드
			console.log(data);
			console.log(data.rno);
			console.log(data.bno);
			console.log(data.reply);
		}, "json"); // controller에 응답형식을 json으로 이미 설정해두었기 때문에 json형식으로 잘 응답해줌
	}); // json으로 받아서 자바스크립트 객체로 변환 해준 것 -> 객체를 반환한 것으로 프로퍼티를 가지고 있음
	
	$("#btn-10").click(function() {
		$.get("/replies/37", function(data) {
			console.log(data);
			console.log(data.rno); // undefined 뜸
			console.log(data.bno);
			console.log(data.reply);
		}, "text"); 
	}); // 객체로 변환 안 된 일반 텍스트로 응답받음, 일반 텍스트로 변환되었기 때문에 프로퍼티가 없음
	
	$("#btn-11").click(function() {
		$.getJSON("/replies/37", function(data, status, xhr) {
			console.log(data);
			console.log(data.rno);
			console.log(data.bno);
			console.log(data.reply);
		});
	});
});
</script>
</head>
<body>
<h1>AJAX EX6</h1>
 
<div> 
<button id="btn-1">댓글 등록 성공</button>
<button id="btn-2">댓글 등록 실패</button>
<button id="btn-3">댓글 등록 성공 또는 실패</button>
<button id="btn-4">댓글 목록</button>
<button id="btn-5">댓글 삭제</button>
<button id="btn-6">댓글 수정</button>
<button id="btn-7">댓글</button>
<button id="btn-8">댓글2</button>
<button id="btn-9">댓글3</button>
<button id="btn-10">댓글4</button>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	$(document).ready(function() {
		$("#outside").click(function() {
			$("#my-form").submit();
		}) 
		
		$("#inside").click(function() {
			e.preventDefault();
			
			
			console.log("인싸버튼클릭");
			
			$("#my-form")
		
		})
	})
</script>
<title>Insert title here</title>
</head>
<body>
<h1>SUBMIT 예제 페이지</h1>
<h1>name : ${param.name }</h1>
<form id="myform" action="">
	<input type="text" name="name" value="java" /> <br>
	<input type="submit" value="전송" />
	
	<button id="inside">또 다른 전송</button> <%--자동 서브밋 버튼--%>
</form>

<button id="outside">밖에 있는 버튼</button>
</body>
</html>
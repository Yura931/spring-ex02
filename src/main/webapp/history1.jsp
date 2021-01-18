<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	// history.state ==> null

	if (history.state != null) {
		console.log("state가 있다.");
	}
	history.replaceState({}, null, null); // 기본객체를 넣은 상태
	
	// history.state ==> {}
</script>
<title>Insert title here</title>
</head>
<body>
<h1>HISTORY 1</h1>
<a href="history2.jsp">history 2로 가기</a>
</body>
</html>
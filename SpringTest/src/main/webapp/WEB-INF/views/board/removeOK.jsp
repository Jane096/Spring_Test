<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirm</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function() {
	$('input[type="submit"]').on("click", function(e) {
	
			location.href='/board/remove?bno='+parseInt(${board.bno}); 
			return;
});
</script>
<body>
	<form action="/board/remove" method="post">
		<h5><c:out value="${board.bno}"/> 게시물을 삭제하시겠습니까?</h5>
		<input type="submit" class="btn btn-sm btn-primary" value="삭제">
		<input type="button" class="btn btn-sm btn-primary" value="취소" onclick="self.close();">
	</form>
</body>
</html>
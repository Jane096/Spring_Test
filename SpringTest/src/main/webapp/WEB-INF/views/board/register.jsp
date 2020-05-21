<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<title>Register page</title>
<%@ include file="../include/header.jsp" %>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="/resources/js/sb-admin-2.min.js"></script>
<style>
#input {
  width:200px;
  height:40px;
  font-size:20px;
}
#textarea {
	width: 600px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#submit").click(function(e){
		if($("#title").val() == "") {
			alert("제목을 채워주세요");
			$("#title").focus();
			return false;
			
		}else if($("#textarea").val() == "") {
			alert("내용을 입력하세요");
			$("#textarea").focus();
			return false;
			
		}else if($("#writer").val() == "") {
			alert("작성자를 입력하세요");
			$("#writer").focus();
			return false;			
		}
	});
});

</script>
 	<div class="row" style="padding-left: 20px;">
 		<div class="col-lg-12">
 			<h1 class="page-header">Board Register</h1>
 		</div>
 	</div>
 	
 	<div class="row" style="padding-left: 20px; padding-bottom: 20px;">
 		<div class="col-lg-12">
 			<div class="panel panel-default">
 				
 				<div class="panel-heading"><h4>Write your content!</h4></div>
 				<div class="panel-body">
 					<form role="form" action="/board/register" method="post">
 						<div class="form-group">
 							<label>Title</label>
 							<input id="title" class="form-control" name='title' >
 						</div>
 						
 						<div class="form-group">
 							<label>Text area</label>
 							<textarea id="textarea" class="form-control" rows="5" name='content'></textarea>
 						</div>
 						
 						<div class="form-group">
 							<label>Writer</label>
 							<input id="writer" class="form-control" name='writer'>
 						</div>
 						<button id="submit" type="submit" class="btn btn-default">Submit</button>
 						<button type="reset" class="btn btn-default" onclick="location.href='/board/list'">Back</button>
 					</form>
 				</div>
 			</div>
 		</div>
 	</div>
<%@ include file="../include/footer.jsp" %> 

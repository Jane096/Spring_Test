<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<title>Register page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
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

<%@ include file="../include/header.jsp" %>
 	<div class="row" style="padding-left: 20px;">
 		<div class="col-lg-12">
 			<h1 class="page-header">Board Register</h1>
 		</div>
 	</div>
 	
 	<div class="row" style="padding-left: 20px; padding-bottom: 20px;"">
 		<div class="col-lg-12">
 			<div class="panel panel-default">
 				
 				<div class="panel-heading"><h4>Write your content!</h4></div>
 				<div class="panel-body">
 					<form role="form" action="/board/register" method="post">
 						<div class="form-group">
 							<label>Title</label>
 							<input id="input" class="form-control" name='title' >
 						</div>
 						
 						<div class="form-group">
 							<label>Text area</label>
 							<textarea id="textarea" class="form-control" rows="5" name='content'></textarea>
 						</div>
 						
 						<div class="form-group">
 							<label>Writer</label>
 							<input id="input" class="form-control" name='writer'>
 						</div>
 						<button type="submit" class="btn btn-default">Submit</button>
 						<button type="reset" class="btn btn-default">Reset</button>
 					</form>
 				</div>
 			</div>
 		</div>
 	</div>
<%@ include file="../include/footer.jsp" %> 

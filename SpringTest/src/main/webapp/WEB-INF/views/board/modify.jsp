<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<title>Modify page</title>
<%@ include file="../include/header.jsp"%>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/resources/js/sb-admin-2.min.js"></script>
 <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
 <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script src="/resources/js/demo/datatables-demo.js"></script>
<style>
#input {
	width: 200px;
	height: 40px;
	font-size: 20px;
}

#textarea {
	width: 600px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var formobj = $("form");

		$('button').on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");
			console.log(operation);

			if (operation == 'list') {
				formobj.attr("action", "/board/list").attr("method", "get");
				formobj.empty();
			}
			formobj.submit();
		});
	});
</script>
<form role="form" action="/board/modify" method="post">
	<div class="row" style="padding-left: 20px;">
		<div class="col-lg-12">
			<h1 class="page-header">Board Modify</h1>
			<div class="form-group row" style="padding-left: 10px;">
				<label for="bno" class="col-form-label"
					style="font-size: 20pt; padding-right: 7px;">No.</label>
				<div class="col-sm-0">
					<input style="font-size: 20pt; outline: none; width: 50px;"
						readonly class="form-control-plaintext" name="bno" id="bno"
						value='<c:out value="${board.bno}" />'>
				</div>
				<label for="writer" class="col-form-label"
					style="font-size: 20pt; padding-right: 7px;">작성자: </label>
				<div class="col-sm-0">
					<input style="font-size: 20pt; outline: none;" name="writer"
						readonly class="form-control-plaintext" id="writer"
						value='<c:out value="${board.writer}" />'>
				</div>
			</div>
		</div>


		<div class="row" style="padding-left: 20px; padding-bottom: 20px;">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading" style="margin-bottom: 20px;"></div>
				</div>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label>Title</label> <input id="input" class="form-control"
						name='title' placeholder="${board.title}"
						onfocus="this.placeholder=''"
						onblur="this.placeholder='${board.title}'">
				</div>

				<div class="form-group">
					<label>Text area</label>
					<textarea id="textarea" class="form-control" rows="5"
						name='content' placeholder="${board.content}"
						onfocus="this.placeholder=''"
						onblur="this.placeholder='${board.content}'"></textarea>
				</div>

				<div class="form-group row" style="padding-left: 20px;">
					<label for="regdate"
						style="margin-right: 5pt; font-size: 14pt; outline: none;">Regdate:
					</label>
					<div class="col-sm-0">
						<input id="regdate" name="regdate"
							style="line-height: 10.5px; outline: none;"
							value='<fmt:formatDate pattern="yyyy/MM/dd"
								value="${board.regdate}"/>'
							readonly class="form-control-plaintext" />
					</div>
					<label for="updatedate"
						style="margin-right: 5pt; font-size: 14pt; outline: none;">Latest
						date: </label>
					<div class="col-sm-0">
						<input id="updatedate" name="updatedate"
							style="line-height: 10.5px; outline: none;"
							value='<fmt:formatDate pattern="yyyy/MM/dd"
								value="${board.updatedate}"/>'
							readonly class="form-control-plaintext" />
					</div>
				</div>

				<button class="btn btn-sm btn-primary" type="submit"
					data-oper="modify">Modify</button>
				<button type="submit" data-oper="list"
					class="btn btn-sm btn-primary">List</button>
			</div>
		</div>
	</div>
</form>
<%@ include file="../include/footer.jsp"%>

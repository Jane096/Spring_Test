<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<title>View Lists</title>
<%@ include file="../include/header.jsp" %>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="/resources/js/sb-admin-2.min.js"></script>
  <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script src="/resources/js/demo/datatables-demo.js"></script>
 
<script type="text/javascript">
	$(document).ready(function() {
		var result = "<c:out value='${result}'/>";

		checkModal(result);

		function checkModal(result) {
			if (result == '') {
				return;
			}
			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다");
			}
			$("#exampleModal").modal("show");
		}
		
		$('#close').on("click"), function(){
			self.close();
		}

		$("#regBtn").on("click", function() {
			self.location = "/board/register";
		});
	});
</script>

<body id="page-top">

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">Tables</h1>
		<p class="mb-4">
			DataTables is a third party plugin that is used to generate the demo
			table below. For more information about DataTables, please visit the
			<a target="_blank" href="https://datatables.net">official
				DataTables documentation</a>.
		</p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<div class="panel-heading">
					Board List Page
					<button id="regBtn" type="button" class="btn btn-xs pull-right">Register
						New Board</button>
				</div>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th>Number</th>
								<th>Title</th>
								<th>Writer</th>
								<th>RegDate</th>
								<th>UpdateDate</th>
							</tr>
						</thead>
						<c:forEach items="${list}" var="board">
							<tr>
								<td><c:out value="${board.bno }" /></td>
								<td><c:out value="${board.title }" /></td>
								<td><c:out value="${board.writer }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regdate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.updatedate}" /></td>
							</tr>
						</c:forEach>
					</table>
					<!-- Modal -->
					<div class="modal fade" id="exampleModal" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Completed!</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body"></div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal" id="close">Close</button>
									<button type="button" class="btn btn-primary">Save
										changes</button>
								</div>
							</div>
						</div>
					</div>
					<!--End Modal-->
				</div>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->
      </div>
      <!-- End of Main Content -->
      
     <%@ include file="../include/footer.jsp" %>   

  <!-- Bootstrap core JavaScript-->
</body>

</html>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<title>board</title>
<style>
.board_title {
	font-weight: 700;
	font-size: 22pt;
	margin: 20pt;
	padding-top: 20px;
}

.board_info_box {
	color: #6B6B6B;
	margin: 20pt;
}

.board_author {
	font-size: 10pt;
	margin-right: 10pt;
	padding-bottom: 30px;
}

.board_date {
	font-size: 10pt;
}

.board_content {
	color: #444343;
	font-size: 12pt;
	margin: 20pt;
	padding-bottom: 30px;
}
</style>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModalLabel">Add Comment</h5>
        <input type="submit" class="close" data-dismiss="modal" aria-label="Close" value="close">
          <span aria-hidden="true">&times;</span>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <label for="reply" class="col-form-label">Reply</label>
            <input type="text" class="form-control" id="reply" name="reply">
          </div>
          <div class="form-group">
            <label for="replyer" class="col-form-label">Replyer</label>
            <input type="text" class="form-control" id="replyer" name="replyer">
          </div>
          <div class="form-group">
            <label for="replyDate" class="col-form-label">ReplyDate</label>
            <input type="text" class="form-control" id="replyDate" name="replyDate">
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="modalModBtn" class="btn btn-secondary" data-dismiss="modal" value="Modify">Modify</button>
        <button type="button" id="modalRemoveBtn" class="btn btn-primary" value="Remove">Remove</button>
		<button type="button" id="modalRegisterBtn" class="btn btn-primary" value="Add">Add</button>
		<button type="button" id="modalCloseBtn" class="btn btn-primary" value="Close">Close</button>
      </div>
    </div>
  </div>
</div>
<%@ include file="../include/header.jsp"%>
<link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="/resources/js/sb-admin-2.min.js"></script>
  <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script src="/resources/js/demo/datatables-demo.js"></script>
  
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
$(document).ready(function(){
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) {
		
		replyService.getList({bno:bnoValue, page:page||1}, function(list){
			var str="";
			
			if(list == null || list.length == 0) {
				replyUL.html("");
				return;
			}
			for(var i=0, len = list.length || 0; i<len; i++) {
				str += "<li data-rno='"+list[i].rno+"' style='list-style:none;'>";
				str += "<div><div class='header'  style='padding-bottom:10px;'><strong class='primary-font' style='padding-right: 200px;'>"+list[i].replyer+"</strong>";
				str += "<small>"+replyService.displayTime(list[i].replyDate)+"</small>"
				str += "<p>"+list[i].reply+"</p></div></li>";
			}
			replyUL.html(str);
		});
	}//end showlist
	
	var modal = $(".modal");
	var modalInputReply = $(".modal").find("input[name='reply']");
	var modalInputReplyer = $(".modal").find("input[name='replyer']");
	var modalInputReplyDate = $(".modal").find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(e){
		$(".modal").find("input").val("");
		$(".modal").find("input[name='replyDate']").closest("div").hide();
		$(".modal").find("button[id = 'modalModBtn']").hide();
		$(".modal").find("button[id = 'modalRemoveBtn']").hide();
		$(".modal").find("button[id = 'modalRegisterBtn']").hide();
		
		modalRegisterBtn.show();
		$("#myModal").modal("show");
	});
	
	modalRegisterBtn.on("click", function(e){ //새로운 댓글 추가 처리
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
		};
		replyService.add(reply, function(result){
			alert(result);
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(1);
		});
	});
	$('.chat').on("click", "li", function(e){
		
		var rno = $(this).data("rno");
		console.log(rno);
		
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$("#myModal").modal("show");
		});
	});
	
	modalModBtn.on("click", function(e){
		var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
		
		replyService.update(reply, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
	
	modalRemoveBtn.on("click", function(e){
		var rno = modal.data("rno");
		
		replyService.remove(rno, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});
});
	
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var formobj = $("form");
		
		$('#btn').on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");
			console.log(operation);
			
			if (operation == "remove") {
				var chk = confirm("정말 삭제하시겠습니까?");
				
				if(chk) {
					location.href='/board/remove?bno='+parseInt(${board.bno})+":"+1; 
					return;
				}
				
			} /* else if (operation == 'list') {
				formobj.attr("action", "/board/list").attr("method", "get");
				formobj.empty();
			} */
			formobj.submit();
		});
		
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.attr("action", "/board/list")
			operForm.submit();
		});
	});
</script>

<body>
	<article style="padding-bottom: 40px;">
		<div class="container" role="main">
			<form role="form" action="/board/modify" method="post">
				<div class="bg-white rounded shadow-sm">
					<div class="board_title">
						<c:out value="${board.title}" />
					</div>
					<div class="board_info_box">
						<div class="row" style="padding-left: 10px;">
							<label for="bno" class="col-form-label" style="font-size: 15pt;">No.</label>
							<div class="col-sm-0">
								<input style="font-size: 15pt; outline: none; width: 50px;"
									readonly class="form-control-plaintext" name="bno" id="bno"
									value='<c:out value="${board.bno}" />'>
							</div>
						</div>

						<span class="board_author">작성자: <c:out
								value="${board.writer}" /></span> <span class="board_author"><fmt:formatDate
								pattern="yyyy-MM-dd" value="${board.regdate}" /></span> <span
							class="board_date">Latest Update: <fmt:formatDate
								pattern="yyyy-MM-dd" value="${board.updatedate}" /></span>
					</div>
					<div class="board_content">
						<c:out value="${board.content}" />
					</div>
				</div>
				<div style="margin-top: 20px; margin-bottom: 40pt;">
					<button data-oper="modify" type="button"
						class="btn btn-sm btn-primary" id="btn">수정</button>
					<button data-oper="remove" type="button"
						class="btn btn-sm btn-primary" id="btn" onclick="location.href='/board/remove?bno='+parseInt(${board.bno})">삭제</button>
					<button id="golist" data-oper="list" type="button"
						class="btn btn-sm btn-primary" id="btn" onclick="location.href=/board/list">목록</button>
				</div>
			</form>
			
			<form id="operForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
				<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
			</form> 
		<div class="Default Panel" style="margin-bottom: 20pt;">
	<div class="row bg-white rounded shadow-sm">
		<div class="col-lg-12">
			<div class="">
				<div class="panel-heading" style="margin-bottom: 20px;">
					<i class="fa fa-comments fa-fw" style="font-size: 15pt; padding-bottom:15px; padding-top:15px;"></i><span style="font-size: 15pt;">Reply</span>
					<button id='addReplyBtn' class="btn btn-primary btn-xs float-right" style="margin-top:15px;">
					Add Comment</button>
				</div>
				
				<div class="panel-body" style="border-bottom: thin dotted;">
					<ul class="chat" style="padding-left: 0">
						<li data-rno="" style="list-style:none;">
							<div>
								<div class="header" style="padding-bottom:10px;">
									<strong class="primary-font" style="padding-right: 200px;"></strong>
									<small></small>
								</div>
								<p></p>			
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	</div>
		</div>		
	</article>
	
	
<%@ include file="../include/footer.jsp"%>
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

<%@ include file="../include/header.jsp"%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModalLabel">New message</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="reply" class="col-form-label">Reply</label>
            <input type="text" class="form-control" id="reply" name="reply">
          </div>
          <div class="form-group">
            <label for="replyer" class="col-form-label">Replyer</label>
            <textarea class="form-control" id="replyer" name="replyer"></textarea>
          </div>
          <div class="form-group">
            <label for="replyDate" class="col-form-label">ReplyDate</label>
            <textarea class="form-control" id="replyeDate" name="replyeDate"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" id="modalModBtn" class="btn btn-secondary" data-dismiss="modal">Modify</button>
        <button type="button" id="modalRemoveBtn" class="btn btn-primary">Remove</button>
		<button type="button" id="modalRegisterBtn" class="btn btn-primary">Add</button>
		<button type="button" id="modalCloseBtn" class="btn btn-primary">close</button>
      </div>
    </div>
  </div>
</div>

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
				str += "<li data-rno='"+list[i].rno+"'>";
				str += "<div><div class='header'  style='padding-bottom:10px;'><strong class='primary-font' style='padding-right: 200px;'>"+list[i].replyer+"</strong>";
				str += "<small>"+replyService.displayTime(list[i].replyDate)+"</small>"
				str += "<p>"+list[i].reply+"</p></div></li>";
			}
			replyUL.html(str);
		});
	}//end showlist
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = S("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
	});
});
	
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var formobj = $("form");
		
		$('button').on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");
			console.log(operation);
			
			if (operation == "remove") {
				var chk = confirm("정말 삭제하시겠습니까?");
				
				if(chk) {
					location.href='/board/remove?bno='+parseInt(${board.bno}); 
					return;
				}
				
			} else if (operation == 'list') {
				formobj.attr("action", "/board/list").attr("method", "get");
				formobj.empty();
			}
			formobj.submit();
		});
		
		/* var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.attr("action", "/board/list")
			operForm.submit();
		}); */
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
						class="btn btn-sm btn-primary" id="btnUpdate">수정</button>
					<button data-oper="remove" type="button"
						class="btn btn-sm btn-primary" id="btnList">삭제</button>
					<button data-oper="list" type="button"
						class="btn btn-sm btn-primary" id="btnList">목록</button>
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
					<button id='addReplyBtn' class="btn btn-primary btn-xs float-right">
					Add Comment</button>
				</div>
				
				<div class="panel-body" style="border-bottom: thin dotted;">
					<ul class="chat" style="padding-left: 0">
						<li data-rno="12" style="list-style:none;">
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
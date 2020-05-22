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
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
	console.log("==========");
	console.log("JS test");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	replyService.add(
		{reply:"JS test", replyer:"testerJS", bno:bnoValue},
		function(result) {
			alert("result: " + result);
		}
	});
	
	replyService.getList({bno:bnoValue, page:1}, function(list){
		for(var i=0, len=list.length||0; i<len; i++) {
			console.log(list[i]);
		}
	});
	
	replyService.remove(25, function(count){
		console.log(count);
		
		if(count === "success") {
			alert("removed!");
		}
	}, function(err) {
		alert("Error!");
	});
	
	replyService.update({
		rno:22,
		bno : bnoValue,
		reply : "Reply Modified!"
	}, function(result){
		alert("댓글이 수정되었습니다!");
	});
	
	replyService.get(25, function(data){
		console.log(data);
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
				<div style="margin-top: 20px">
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
		</div>
		
	</article>

	<%@ include file="../include/footer.jsp"%>
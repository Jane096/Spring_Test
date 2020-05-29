<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
	
<title>board</title>
<%@ include file="../include/header.jsp"%>
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
<!--         <input type="submit" class="close" data-dismiss="modal" aria-label="Close" value="close">
           <span aria-hidden="true">&times;</span> -->
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
		<button type="button" id="modalCloseBtn" class="btn btn-primary" data-dismiss="modal" aria-label="Close">Close</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>
$(document).ready(function(){
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	//var pageNum = 1;
	
	showList(1);
	
	function showList(page) {
		
		console.log("showList: " + page);
		
		replyService.getList({bno:bnoValue, page:page||1}, function(list){
			//console.log("replyCnt: " + replyCnt);
			console.log("list: " + list);
			console.log(list);
			
			if(page == -1) { // showList(-1)이 호출되면 우선 전체 댓글의 숫자를 파악, 이후에 다시 마지막페이지를 호출해서 이동하는 방식
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str="";
			
			if(list == null || list.length == 0) {
				return;
			}
			
			for(var i=0, len = list.length || 0; i<len; i++) {
				str += "<li data-rno='"+list[i].rno+"' style='list-style:none;'>";
				str += "<div><div class='header'  style='padding-bottom:10px;'><strong class='primary-font' style='padding-right: 200px;'>"+list[i].replyer+"</strong>";
				str += "<small>"+replyService.displayTime(list[i].replyDate)+"</small>"
				str += "<p>"+list[i].reply+"</p></div></li>";
			}
			replyUL.html(str);
			//showReplyPage(replyCnt);
		});
	}//end showlist
	
	/* var pageNum = 1;
		var replyPageFooter = $(".panel-footer_bar");
	    
	    function showReplyPage(replyCnt){
	      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      var str="";
	      str = "<div class='dataTables_paginate paging_simple_numbers' id='dataTable_paginate";
	      str += "<ul class='pagination float-right'>";
	      
	      if(prev){
	        str+= "<li class='paginate_button page-item previous disabled' id='dataTable_previous'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){ 
	        var active = pageNum == i? "active":"";
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul></div>";
	      console.log(str);
	      replyPageFooter.html(str);
	    }
 */ 
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
		
		/* $("button[data-oper='remove']").on("click", function(e) {
			//e.preventDefault();

			var operation = $(this).data("oper");
			console.log(operation);
			
			if (operation == "remove") { 
				var chk = confirm("정말 삭제하시겠습니까?");
				
				if(chk) {
					"location.href='/board/remove?bno='"+parseInt(${board.bno}); 
					return;
				
				}else if (operation == 'list') {
					formobj.attr("action", "/board/list").attr("method", "get");
					formobj.empty();
			} 
			formobj.submit();
		}
	}); */
		
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.attr("action", "/board/list")
			operForm.submit();
		});
		
		$("button[data-oper='remove']").on("click", function(e) {
			e.preventDefault();
			
			var operation = $(this).data("oper");
			console.log(operation);
			
			if (operation == "remove") { 
				var chk = confirm("정말 삭제하시겠습니까?");
				
				if(chk) {
					operForm.attr("action", "/board/remove").submit();		
				}
			}
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function(){
		(function(){
			var bno = '<c:out value="${board.bno}"/>';
			
			$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
		        
			       console.log(arr);			       
			       var str = "";
			       
			       $(arr).each(function(i, attach){
			       
			         //image type
			         if(attach.fileType){
			           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
			           
			           str += "<li style='padding-bottom: 30px;' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
			           str += "<img src='/display?fileName="+fileCallPath+"'>";
			           str += "</div>";
			           str +"</li>";
			           
			         }else{		             
			           str += "<li style='padding-bottom: 30px;' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
			           str += "<span> "+ attach.fileName+"</span><br/>";
			           str += "<img src='/resources/img/attach.png'></a>";
			           str += "</div>";
			           str +"</li>";
			         }
			       });		       
			       $(".uploadResult ul").html(str);	
			       
			     });//end getjson
			  })();//end function
			  
		$(".uploadResult").on("click","li", function(e){
		      
		    console.log("view image");	    
		    var liObj = $(this);		    
		    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
		    
		    if(liObj.data("type")){
		      showImage(path.replace(new RegExp(/\\/g),"/"));
		      
		    }else {
		      //download 
		      self.location ="/download?fileName="+path
		    }		    
		  });	  
			  
		  function showImage(fileCallPath){		    
		    alert(fileCallPath);
		    
		    $(".bigPictureWrapper").css("display","flex").show();
		    
		    $(".bigPicture")
		    .html("<img src='/display?fileName="+fileCallPath+"' >")
		    .animate({width:'100%', height: '100%'}, 1000);
		    
		  }
		  
		  $(".bigPictureWrapper").on("click", function(e){
			    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
			    setTimeout(function(){
			      $('.bigPictureWrapper').hide();
			    }, 1000);
		  });
	});
</script>

<body>
	<article style="padding-bottom: 40px;">
		<div class="container" role="main">
			
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
						
						<i class="far fa-user"></i>
						<span class="board_author"  style="padding-right: 20px;">작성자: <c:out
								value="${board.writer}" /></span> 
								
						<i class="far fa-edit"></i>
								<span class="board_author" style="padding-right: 20px;"><fmt:formatDate
								pattern="yyyy-MM-dd" value="${board.regdate}" /></span> 
								
								<i class="far fa-clock"></i>		
								<span class="board_date">Latest Update: <fmt:formatDate
								pattern="yyyy-MM-dd" value="${board.updatedate}" /></span>
					</div>
					<div class="board_content">
						<c:out value="${board.content}" />
					</div>
				</div>
				<div style="margin-top: 20px; margin-bottom: 40pt;">
			<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer}">
					<button data-oper="modify" class="btn btn-sm btn-primary">수정</button>					
					</c:if> 
				</sec:authorize>
 					<button type="submit" data-oper='remove' class="btn btn-sm btn-primary">삭제</button>
 					<button id="golist" data-oper="list" type="button"
						class="btn btn-sm btn-primary">목록</button>
				</div>
			
			<form id="operForm" action="/board/modify" method="get">
				<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
				<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
			</form> 
			
			<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<style>
.uploadResult {
  width:100%;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  /* justify-content: center; */
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
 /*  justify-content: center; */
  padding-left: 30px;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img {
  width:600px;
}

</style>

<div class="row ">
  <div class="col-lg-12" style="margin-bottom: 15pt;">
    <div class="bg-white rounded shadow-sm">

      <div class="panel-heading" style="font-size:15pt; padding-left:20px; padding-top:15px; padding-bottom:15px;">Files</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        
        <div class='uploadResult'> 
          <ul>
          </ul>
        </div>
      </div>
      <!--  end panel-body -->
    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->

		<div class="Default Panel" style="margin-bottom: 20pt;">
	<div class="row bg-white rounded shadow-sm">
		<div class="col-lg-12">
			<div class="">
				<div class="panel-heading" style="margin-bottom: 20px;">
					<i class="fa fa-comments fa-fw" style="font-size: 15pt; padding-bottom:15px; padding-top:15px;"></i><span style="font-size: 15pt; padding-left:8px;">Comments</span>
					<sec:authorize access="isAuthenticated()">
					<button id='addReplyBtn' class="btn btn-primary btn-xs float-right" style="margin-top:15px;">
					Add Comment</button>
					</sec:authorize>
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
				<div class="panel-footer_bar">
					
				</div>
			</div>
		</div>
	</div>
	</div>
		</div>		
	</article>
	
	
<%@ include file="../include/footer.jsp"%>
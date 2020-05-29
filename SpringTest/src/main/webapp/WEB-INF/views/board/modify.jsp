<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

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

		$('#golist').on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");
			console.log(operation);

			if (operation == 'list') {
				$("form").attr("action", "/board/list").attr("method", "get");
				$("form").empty();
			}
			$("form").submit();
		});
		
		$("#done").click(function(e){
			if($("#title").val() == "") {
				alert("제목을 채워주세요");
				$("#title").focus();
				return false;
				
			}else if($("#textarea").val() == "") {
				alert("내용을 입력하세요");
				$("#textarea").focus();
				return false;	
				
			}else {
				//e.preventDefault(); 	    
			    var operation = $(this).data("oper");	    
			    console.log(operation);
			    
			    if(operation === 'remove'){
			    	$("form").attr("action", "/board/remove").attr("method", "post");
			    	//return;
			      
			    }else if(operation === 'list'){
			      //move to list
			      $("form").attr("action", "/board/list").attr("method","get");
			      
			      var pageNumTag = $("input[name='pageNum']").clone();
			      var amountTag = $("input[name='amount']").clone();
			          
			      
			      $("form").empty();
			      
			      $("form").append(pageNumTag);
			      $("form").append(amountTag);	  
			      
			    }else if(operation === 'modify'){	        
			        console.log("submit clicked");	        
			        var str = "";
			        
			        $(".uploadResult ul li").each(function(i, obj){          
			          var jobj = $(obj);          
			          console.dir(jobj);
			          
			          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			          str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
			          
			        });
			        $("form").append(str).submit();
		        }  
			    $("form").submit();
			}
		});
	});
</script>
<form role="form" action="/board/modify" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

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
					<label>Title</label> <input id="title" class="form-control"
						name='title' placeholder="${board.title}"
						onfocus="this.placeholder=''"
						onblur="this.placeholder='${board.title}'"
						value='<c:out value="${board.title }"/>'>
				</div>

				<div class="form-group">
					<label>Text area</label>
					<textarea id="textarea" class="form-control" rows="5"
						name='content' placeholder="${board.content}"
						onfocus="this.placeholder=''"
						onblur="this.placeholder='${board.content}'"><c:out
							value="${board.content}" /></textarea>
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
						Update: </label>
					<div class="col-sm-0">
						<input id="updatedate" name="updatedate"
							style="line-height: 10.5px; outline: none;"
							value='<fmt:formatDate pattern="yyyy/MM/dd"
								value="${board.updatedate}"/>'
							readonly class="form-control-plaintext" />
					</div>
				</div>
				<!-- <button id="done" class="btn btn-sm btn-primary" type="submit"
					data-oper="modify">수정</button>
				<button data-oper="remove" class="btn btn-sm btn-primary">삭제</button>
				<button id="golist" type="submit" data-oper="list"
					class="btn btn-sm btn-primary">목록</button> -->
				<sec:authentication property="principal" var="pinfo" />

				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq board.writer}">
						<button id="done" type="submit" data-oper='modify'
							class="btn btn-sm btn-primary">Modify</button>	
						<!-- <button type="button" data-oper='remove' class="btn btn-sm btn-primary">삭제</button>
						 -->				
					</c:if>
				</sec:authorize>
				<button id="golist" type="submit" data-oper='list'
					class="btn btn-sm btn-primary">List</button>
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
<script type="text/javascript">
$(document).ready(function() {
	  (function(){
	    
	    var bno = '<c:out value="${board.bno}"/>';	    
	    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){    
	      console.log(arr);	      
	      var str = "";
	      
	      $(arr).each(function(i, attach){          
	          //image type
	          if(attach.fileType){
	            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
	            
	            str += "<li style='list-style:none; padding-bottom: 40px;' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
	            str +=" data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	            str += "<span> "+ attach.fileName+"</span>";
	            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
	            str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
	            str += "<img src='/display?fileName="+fileCallPath+"'>";
	            str += "</div>";
	            str +"</li>";
	          }else{
	              
	            str += "<li style='list-style:none; padding-bottom: 40px;' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
	            str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	            str += "<span> "+ attach.fileName+"</span><br/>";
	            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
	            str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
	            str += "<img src='/resources/img/attach.png'></a>";
	            str += "</div>";
	            str +"</li>";
	          }
	       });	      
	      $(".uploadResult ul").html(str);
	      
	    });//end getjson
	 })();//end function
	 
	  $(".uploadResult").on("click", "button", function(e){		    
		    console.log("delete file");
		      
		    if(confirm("Remove this file? ")){	    
		      var targetLi = $(this).closest("li");
		      targetLi.remove();
		    }
		  });  
		  
		  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		  var maxSize = 5242880; //5MB
		  
		  function checkExtension(fileName, fileSize){		    
		    if(fileSize >= maxSize){
		      alert("파일 사이즈 초과");
		      return false;
		    }
		    
		    if(regex.test(fileName)){
		      alert("해당 종류의 파일은 업로드할 수 없습니다.");
		      return false;
		    }
		    return true;
		  }
		  
		  $("input[type='file']").change(function(e){
		    var formData = new FormData();		    
		    var inputFile = $("input[name='uploadFile']");		    
		    var files = inputFile[0].files;
		    
		    for(var i = 0; i < files.length; i++){
		      if(!checkExtension(files[i].name, files[i].size) ){
		        return false;
		      }
		      formData.append("uploadFile", files[i]);	      
		    }
		    
		    $.ajax({
		      url: '/uploadAjaxAction',
		      processData: false, 
		      contentType: false,data: 
		      formData,type: 'POST',
		      dataType:'json',
		        success: function(result){
		          console.log(result); 
				  showUploadResult(result); //업로드 결과 처리 함수 

		      }
		    }); //$.ajax		    
		  });    

		  function showUploadResult(uploadResultArr){			    
		    if(!uploadResultArr || uploadResultArr.length == 0){ return; }	    
		    var uploadUL = $(".uploadResult ul");		    
		    var str ="";
		    
		    $(uploadResultArr).each(function(i, obj){			
				if(obj.image){
					var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					str += "<li style='list-style:none; padding-bottom: 40px;' data-path='"+obj.uploadPath+"'";
					str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
					str +" ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str +"</li>";
				}else{
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
				    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				      
					str += "<li "
					str += "style='list-style:none; padding-bottom: 40px;' data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
				}
		    });		    
		    uploadUL.append(str);
		  }
});
</script>

<div class="row" style="padding-left:40px;">
  <div class="col-lg-12" style="margin-bottom: 15pt;">
    <div class="bg-white rounded shadow-sm">

      <div class="panel-heading" style="font-size:15pt; padding-left:20px; padding-top:15px; padding-bottom:15px;">Change your files</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
      	<div class="form-group uploadDiv" style="margin-bottom:20px;">
			<input style="margin-bottom:5px; margin-left:20px;" type="file" class="btn btn-sm default" name="uploadFile" multiple="multiple">
		</div>
        
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
	</div>
</form>
<%@ include file="../include/footer.jsp"%>

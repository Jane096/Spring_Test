<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<title>Register page</title>
<%@ include file="../include/header.jsp" %>
  
<style>
#writer, #title {
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
	
	var formObj = $("form[role='form']");
	$("button[type='submit']").on("click", function(e){ 
		//e.preventDefault();	
		
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
			
		}else{  
			    console.log("submit clicked");    
			    var str = "";
			    
			    $(".uploadResult ul li").each(function(i, obj){	      
			      var jobj = $(obj);
			      
			      console.dir(jobj);
			      console.log("-------------------------");
			      console.log(jobj.data("filename"));
			            
			      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
			      
			    });
			    
			    console.log(str);
			    $("form[role='form']").append(str).submit();
		}		
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 7242880; //5MB
	  
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
					str += "<li style='list-style:none;'data-path='"+obj.uploadPath+"'";
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
					str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
				}
		}); 
		    $(".uploadResult ul").append(str);
	}
	    $(".uploadResult").on("click", "button", function(e){
		    
	        console.log("delete file");
	          
	        var targetFile = $(this).data("file");
	        var type = $(this).data("type");
	        
	        var targetLi = $(this).closest("li");
	        
	        $.ajax({
	          url: '/deleteFile',
	          data: {fileName: targetFile, type:type},
	          dataType:'text',
	          type: 'POST',
	            success: function(result){
	               alert(result);
	               
	               targetLi.remove();
	             }
	       });
	    }); //$.ajax
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
 					<form role='form' action="/board/register" method="post">
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

<div class="form-group uploadDiv" style="margin-bottom:20px;">
	<input style="margin-bottom:5px; margin-left:20px;" type="file" class="btn btn-sm default" name="uploadFile" multiple>
</div>
<div class="uploadResult">
	<ul></ul>
</div>
<%@ include file="../include/footer.jsp"%>

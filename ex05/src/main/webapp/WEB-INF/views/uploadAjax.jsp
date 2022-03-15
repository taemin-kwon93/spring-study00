<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style>
	.uploadResult {
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
	}
	
	.uploadResult ul li img {
		width: 100px;
	}
	</style>
	
	<style>
	.bigPictureWrapper {
	  position: absolute;
	  display: none;
	  justify-content: center;
	  align-items: center;
	  top:0%;
	  width:100%;
	  height:100%;
	  background-color: gray; 
	  z-index: 100;
	}
	
	.bigPicture {
	  position: relative;
	  display:flex;
	  justify-content: center;
	  align-items: center;
	}
	</style>
	
</head>

<body>
<h1>Upload with Ajax</h1>

<div class="uploadDiv">
	<input type="file" name="uploadFile" multiple>
</div>
<button id="uploadBtn">Upload</button>

<div class="uploadResult">
	<ul>
		
	</ul>
</div>

</body>

<!-- jQuery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
<script>
$(document).ready(function(){
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 52428800;//50MB
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일의 크기가 너무 큽니다.");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}//func checkExtension
	
	var cloneObj = $(".uploadDiv").clone();
	
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size) ){
				return false;//
			}
			formData.append("uploadFile", files[i]);
		}
		
	var uploadResult = $(".uploadResult ul");
		
	function showUploadedFile(uploadResultArr) {
		var str = "";
		
		$(uploadResultArr).each(function(i, obj) {
			if(!obj.image){
				str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>"
			} else {
				//str += "<li>" + obj.fileName + "</li>";
				var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_"+obj.uuid+"_"+obj.fileName);
		        
		        str += "<li><img src='/display?fileName="+fileCallPath+"'><li>";
			}
		});
		
		uploadResult.append(str);
	}
		
		
	$.ajax({
		url: '/uploadAjaxAction',
		processData: false,
		contentType: false,
		data: formData,
		type: 'POST',
		dataType: 'json', 
		success: function(result){
			console.log(result);
			showUploadedFile(result);
			$(".uploadDiv").html(cloneObj.html());
		}
	});//$.ajax
	
	});
});

</script>		
</html>
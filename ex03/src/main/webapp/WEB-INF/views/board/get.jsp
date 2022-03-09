<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- Board게시글 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
					<div class="form-group">
						<label>Bno</label><input class="form-control" name="bno"
							value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
						<label>Title</label><input class="form-control" name="title"
							value='<c:out value="${board.title}"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content"
							 readonly="readonly"><c:out value="${board.content}"/></textarea>
					</div>
					
					<div class="form-group">
						<label>Writer</label><input class="form-control" name="writer"
							value='<c:out value="${board.writer}"/>' readonly="readonly">
					</div>
					<button data-oper='modify' class="btn btn-default"
						onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
					<button data-oper='list' class="btn btn-info"
						onclick="location.href='/board/list'">List</button>
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">							
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>"> 
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
					<input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
				</form>
			</div>
			<!-- end panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- Reply 댓글 목록 -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
			</div>
			<!-- /.panel-heading -->
			
			<div class="panel-body">
				<ul class="chat">

				</ul>
				<!-- end chat -->
			</div>
			<!-- /.panel-body -->
			<div class="panel-footer"></div>
		</div>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelldby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label>
						<input class="form-control" name='reply' value='NewReply'>
					</div>
					<div class="form-group">
						<label>Replyer</label>
						<input	class="form-control" name='replyer' value='replyer'>
					</div>
					<div class="form-group">
						<label>Reply Date</label>
						<input class="form-control" name='replyDate' value=''>
					</div>
				</div>
		<div class="modal-footer">
			<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
			<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
			<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
			<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss='modal'>Close</button>
		</div>
		</div><!-- <div class="modal-content"> -->
		</div><!-- <div class="modal-dialog"> -->
		</div><!-- <div class="modal fade">  -->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
$(document).ready(function(){
	console.log("==========");		
	console.log("JS TEST2");	
	
	
	var bnoValue ='<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) {
		console.log("show list page : " + page);
		//R 댓글 가져오기
		replyService.getList({bno:bnoValue, page: page || 1}, 
			function(replyCnt, list){
			
			console.log("replyCnt: " + replyCnt);
			console.log("list: " + list);
			
			if(page == -1) {
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			
			if(list == null || list.length == 0) { 
				return;
			}
			
			for (var i = 0,  len = list.length || 0; i < len; i++ ){
				str +="<li class='left clearfix' data-rno='" + list[i].rno + "'>";
				str +="  <div><div class='header'><strong class='primary-font'>["
			    	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
				str +="		<small class='pull-right text-muted'>"
					+replyService.displayTime(list[i].replyDate)+"</small></div>";
				str +="		<p>"+list[i].reply+"</p></div></li>";
		  	}

		     replyUL.html(str);
		     
		     showReplyPage(replyCnt);
			
		});//end replyService.getList 
	}//end showList(page) 

    
    var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
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
      
      var str = "<ul class='pagination pull-right'>";
      
      if(prev){
        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
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
     
    replyPageFooter.on("click","li a", function(e){
       e.preventDefault();
       console.log("page click");
       
       var targetPageNum = $(this).attr("href");
       
       console.log("targetPageNum: " + targetPageNum);
       
       pageNum = targetPageNum;
       
       showList(pageNum);
     });     
	
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id !='modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		$(".modal").modal("show");
	});
	
	modalRegisterBtn.on("click", function(e) {
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
		};
		
		replyService.add(reply, function(result) {
			alert(result);
				
			modal.find("input").val("");
			modal.find("hide");
			//showList(1);
			showList(-1);
		});
		
	});
	
	$(".chat").on("click", "li", function(e) {
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply) {
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
			.attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id !='modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
	});//$(".chat").on
	
	modalModBtn.on("click", function(e) {
		var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
		replyService.update(reply, function(result) {
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	modalRemoveBtn.on("click", function(e) {
		var rno = modal.data("rno");
		replyService.remove(rno, function(result) {
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
});//$(document).ready
</script>

<script>
/*
	<!-- C 댓글 추가 확인 -->
	replyService.add(
	{reply:"JS TEST4", replyer:"tester4", bno:bnoValue}
	,
		function(result) {
			alert("Result: " + result);	
		}
	)

	//D 댓글 삭제 확인 
	replyService.remove(26, function(conut) {
		console.log("Removed...");
		console.log(count);
		
		if (count === "success") {
			alert("Removed");
		}
	}, function(err) {
		alert("Error");
	});
		
	replyService.update({
		rno : 20,
		bno : bnoValue,
		reply : "Modified..."
		}, 
		function(result){
			alert("수정완료");		
		});
	
	replyService.get(10, function(data) { 
		console.log(data);
	});
 
 */
</script>

<script>
	$(document).ready(function(){
		
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();
		});
	});
</script>

<%@ include file="../includes/footer.jsp" %>
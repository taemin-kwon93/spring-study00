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
			</div>
			
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
					<!-- Start Reply -->
					<li class="left clearfix" data-rno="12">
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2022-03-07 18:50</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
					<!-- end reply list -->
				</ul>
				<!-- end chat -->
			</div>
			<!-- /.panel-body -->
		</div>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<!-- Reply 댓글 목록 -->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
$(document).ready(function(){
	console.log("==========");		
	console.log("JS TEST2");	
	
	
	var bnoValue ='<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) {
		//R 댓글 가져오기
		replyService.getList({bno:bnoValue, page:1}, function(list){
			var str = "";
			
			if(list == null || list.length == 0) { 
				replyUL.html("");
				return;
			}
			
			for(var i = 0,  len = list.length || 0; i < len; i++ ){
			    console.log(list[i]);
				str +="<li class='left clearfix' data-rno='" + list[i].rno + "'>";
				str +="		<div><div class='header'><strong class='primary-font'>" + list[i].replyer + "</strong>";
				str +="		<small class='pull-right text-muted'>" +replyService.displayTime(list[i].replyDate)+ "</small></div>";
				str +="		<p>"+list[i].reply+"</p></div></li>";
		  	}
		
			replyUL.html(str);
		
		});//end replyService.getList 
	}//end showList(page) 
	
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
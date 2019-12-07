<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div class="row">
		<div class="col-xs-12">
			<h4 class="page-header">자유게시판</h4>
		</div>
	</div>

		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-default">

					<div class="panel-heading" style="height: 80px">

						<div class="col-xs-6 col-xs-4"></div>
						<div class="col-xs-6 col-xs-4 text-center board-title">
							<c:out value="${board.title }"/>
						</div>
						<div class="col-xs-6 col-xs-4 text-right">
							<fmt:formatDate pattern="yyyy-MM-dd hh:mm "
								value="${board.regdate}" />
							<br> <i class="fa fa-user"> <c:out
									value="${board.writer }" /></i>
							<br>
								<i class="fa fa-eye pull-right"> 1425</i>
						</div>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<div class="content-form">
							${board.content }
							</div>
						</div>
						<form id="operForm" action="/freeBoard/modify" method="get">
							<input type="hidden" name="bno" id="bno" value='<c:out value="${board.bno }"/>'>
							<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
							<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
							<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
							<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
						</form>
						
						<div class="text-center">
							<!-- <button data-oper="좋아용" class="btn btn-outline btn-success" style="height:34px"><i class="fa fa-thumbs-o-up pull-right"> 1425</i></button> -->
							<button data-oper="list" class="btn btn-outline btn-info">목록</button>
							<button data-oper="modify" class="btn btn-outline btn-danger">수정</button>
						</div>		
						<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> --%>
					</div>
				</div>
			</div>
		</div>
		<!--                      -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i>댓글
						<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글작성</button>
					</div>
					
					<div class="panel-body">
						<ul class="chat">
							<li class="left clearfix" data-rno="12">
								<div>
									<div class="header">
										<strong class="primary-font">user00</strong>
										<small class="pull-right text-muted">2018-01-01 13:13</small>
									</div>
									<p>good job!</p>
								</div>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">댓글 작성</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label>댓글</label> <input class="form-control" name='reply'
								value='New Reply!!!!'>
						</div>
						<div class="form-group">
							<label>작성자</label> <input class="form-control" name='replyer'
								value='replyer'>
						</div>
						<div class="form-group">
							<label>작성일</label> <input class="form-control"
								name='replyDate' value='2018-01-01 13:13'>
						</div>
		
					</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
						<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
						<button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
						<button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
		<!-- /.modal-dialog -->
		</div>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click",function(e){
			console.log("modify click...");
			operForm.attr("action","/freeBoard/modify").submit();
		});
		
		$("button[data-oper='list']").on("click",function(e){
			operForm.find("#bno").remove();
			operForm.attr("action","/freeBoard/list");
			operForm.submit();
		});
	


	  var bnoValue = '<c:out value="${board.bno}"/>';
	  var replyUL = $(".chat");
	  	
	    console.log("before");
	    showList(1);
	   
	    
	    function showList(page){
	    	
	    	console.log("show list " + page);
	        
	        replyService.getList({bno:bnoValue,page: page|| 1 }, function(list) {

	         var str="";
	         
	         if(list == null || list.length == 0){
	           replyUL.html("");
	           return;
	         }
	         
	         for (var i = 0, len = list.length || 0; i < len; i++) {
	           str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
	           str +="  <div><div class='header'><strong class='primary-font'>["
	        	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
	           str +="    <small class='pull-right text-muted'>"
	               +replyService.displayTime(list[i].replyDate)+"</small></div>";
	           str +="    <p>"+list[i].reply+"</p></div></li>";
	         }
	         
	         replyUL.html(str);
	     }); //end function;
	    } //end showList
	    
	    var modal = $(".modal");
	    var modalInputReply = modal.find("input[name='reply']");
	    var modalInputReplyer = modal.find("input[name='replyer']");
	    var modalInputReplyDate = modal.find("input[name='replyDate']");
	    
	    var modalModBtn = $("#modalModBtn");
	    var modalRemoveBtn = $("#modalRemoveBtn");
	    var modalRegisterBtn = $("#modalRegisterBtn");
    
	    $("#addReplyBtn").on("click", function(e){
	        
	    	console.log("버튼클릭");
	        modal.find("input").val("");
	        modalInputReplyDate.closest("div").hide();
	        modal.find("button[id !='modalCloseBtn']").hide();
	        
	        modalRegisterBtn.show();
	        
	        $(".modal").modal("show");
	        
	     });
	    
	
}); 
</script>



</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

body>
	<div class="wrapper-custom">
		<div class="row">
			<div class="col-xs-12">
				<h4 class="page-header">자유게시판</h4>
			</div>
		</div>
	
		<!-- 게시글정보 -->
		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading" style="height: 70px; background-color:white;">
						<div class="col-xs-6 text-left">
							<div class="subtitle">
								<i class="fa fa-user"></i> <c:out value="${board.writer}" />
							</div>
							<div class="text-muted">
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}" />
							</div>
						</div>
						<div class="col-xs-6 text-right">
							<i class="fa fa-comments fa-fw"></i> <c:out value="${board.replyCnt }" />
							<i class="fa fa-eye paddingleft"></i> <c:out value="${board.views}" />
						</div>
					</div>
					
					<div class="panel-heading" style="height: 110px; background-color:white;">
						<div class="col-xs-6 text-left">
							<div class="text-muted">
								# <c:out value="${board.bno }"/>
								<button class="btn btn-info btn-xs" id="listbtn"><i class="fa fa-list"> 자유게시판</i></button>
							</div>
							<div class="boardtitle"><c:out value="${board.title }" /></div>
						</div>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div class="form-group">
							<div class="content-form">${board.content}</div>
						</div>
						<div class="text-center">
							<sec:authentication property="principal" var="pinfo" />
							<sec:authorize access="isAuthenticated()">
								<c:if test="${pinfo.username eq board.writer}">
									<button data-oper="modify" class="btn btn-outline btn-warning">
										<i class="fa fa-edit"> 수정</i>
									</button>
								</c:if>
							</sec:authorize>
							<button id="heart" class="btn btn-danger heartBtn">
								<i id="heartBtn" class="fa fa-heart"> ${board.likes}</i>
							</button>
							<button data-oper="list" class="btn btn-outline btn-info">
								<i class="fa fa-list"> 목록</i>
							</button>
						</div>
					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel-default -->
			</div>
		</div>
	
		<!-- 첨부파일 div -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading" style="background-color:white">
						<i class="fa fa-paperclip"></i> <label> 파일</label>
					</div>
					<div class="panel-body">
						<div class="uploadResult">
							<ul>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<!-- 댓글 div -->
		<div class="row" style="padding-top:5px;">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading" style="background-color:white">
						<i class="fa fa-comments fa-fw"></i> <label> 댓글 <c:out value="${board.replyCnt }" /></label>
						<sec:authorize access="isAuthenticated()">
							<button id="addReplyBtn" class="btn btn-outline btn-primary btn-xs pull-right">댓글작성</button>
						</sec:authorize>
					</div>
					<div class="panel-body">
						<ul class="chat">	
						</ul>
					</div>
					<div class="text-center">
						<div class="replyfooter">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.wrapper-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
										 aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">댓글 작성</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>댓글</label> 
						<input class="form-control" name="reply" value="New Reply">
					</div>
					<div class="form-group">
						<label>작성자</label> 
						<input class="form-control" name="replyer" value="replyer">
					</div>
					<div class="form-group">
						<label>작성일</label> 
						<input class="form-control" name="replyDate" value="2000-00-00 00:00">
					</div>
				</div>
				<!-- /.modal-body -->
				<div class="modal-footer">
					<button id="modalModBtn" type="button" class="btn btn-warning">수정</button>
					<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
					<button id="modalRegisterBtn" type="button" class="btn btn-primary">등록</button>
					<button id="modalCloseBtn" type="button" class="btn btn-default">닫기</button>
				</div>
				<!-- /.modal-footer -->
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
		<form id="operForm" action="/freeBoard/modify" method="get">
			<input type="hidden" name="bno" id="bno" value='<c:out value="${board.bno }"/>'> 
			<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'> 
			<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'> 
			<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
			<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
			<input type="hidden" name="userid" value='<c:out value="${pinfo.username }"/>'>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		</form>
		
	<script src="/resources/js/board/board_reply.js"></script>
	<script src="/resources/js/board/board_get.js"></script>
</body>
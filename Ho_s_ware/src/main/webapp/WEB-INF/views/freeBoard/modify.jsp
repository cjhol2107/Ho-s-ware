<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/board/board.css" rel="stylesheet"></head>

<body>
	<div class="row">
		<div class="col-lg-12">
			<h4 class="page-header">게시글 수정</h4>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<form role="form" id="form" action="/freeBoard/modify" method="post">
					
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
						<input type="hidden" name="writer" value='<c:out value="${board.writer }"/>'>
						<input type="hidden" name="bno" value='<c:out value="${board.bno }"/>'>
						<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
						<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
						<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
						<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
						
						<div class="form-group">
							<label>제목</label> 
							<input class="form-control" name="title" value='<c:out value="${board.title }"/>'>						
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="input-content" name="content" id="content">
								<c:out value="${board.content }"/>
							</textarea>
						</div>
						<div class="text-center">
							<button type="submit" data-oper="list" class="btn btn-outline btn-info"><i class="fa fa-list"> 목록</i></button>
								<sec:authentication property="principal" var="pinfo"/>
								<sec:authorize access="isAuthenticated()">
										<c:if test="${pinfo.username eq board.writer }">
											<button type="submit" data-oper="remove" class="btn btn-outline btn-danger"><i class="fa fa-trash-o"> 삭제</i></button>
											<button type="submit" id="modify" class="btn btn-outline btn-warning"><i class="fa fa-edit"> 수정</i></button>
										</c:if>
								</sec:authorize>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 파일div -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading file"><i class="fa fa-paperclip"></i> 
					<label> 파일</label>
				</div>
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name="uploadFile" multiple>
					</div>
					<div class="uploadResult">
						<ul>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/resources/js/board/board_fileEdit.js"></script>
	<script src="/resources/js/board/board_edit.js"></script>
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
							<textarea name="content" id="content" style="width: 100%; height: 400px;">
								<c:out value="${board.content }"/>
							</textarea>
						</div>
				
						<div class="text-center">
							<button type="submit" data-oper="list" class="btn btn-outline btn-info">목록</button>
								<sec:authentication property="principal" var="pinfo"/>
									<sec:authorize access="isAuthenticated()">
											<c:if test="${pinfo.username eq board.writer }">
												<button type="submit" data-oper="remove" class="btn btn-outline btn-danger">삭제</button>
												<button type="submit" id="modify" class="btn btn-outline btn-warning">수정</button>
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
				<div class="panel-heading" style="background-color:white"><i class="fa fa-paperclip"></i> 
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
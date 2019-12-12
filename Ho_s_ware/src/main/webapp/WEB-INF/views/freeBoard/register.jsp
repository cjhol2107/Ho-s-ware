<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/board/board.css" rel="stylesheet"></head>

<body>
	<div class="wrapper-custom">
		<div class="row">
			<div class="col-lg-12">
				<h4 class="page-header">게시글 등록</h4>
			</div>
		</div>
	
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<form role="form" action="/freeBoard/register" method="post" id="frm">
							<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> 
							<input type="hidden" name="writer" value='<sec:authentication property="principal.username"/>'>
							<div class="form-group">
								<label>제목</label> 
								<input class="form-control" name='title' id='title'>
							</div>
							<div class="form-group">
								<label>내용</label>
								<textarea class="reg_content" name="content" id="content"></textarea>
							</div>
							<div class="text-center">
								<button type="submit" id="savebutton" name="savebutton" class="btn btn-outline btn-primary">등록</button>
								<button type="reset" class="btn btn-outline btn-danger">취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading file">
						<i class="fa fa-paperclip"></i> 
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
	</div>
	
	<script src="/resources/js/board/board_fileEdit.js"></script>
	<script src="/resources/js/board/board_register.js"></script>
</body>
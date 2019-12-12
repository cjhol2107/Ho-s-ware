<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/board/board.css" rel="stylesheet"></head>

<body>
	<div class="row">
		<div class="col-lg-12">
			<h4 class="page-header">자유게시판</h4>
			<b><fmt:formatNumber value="${totalCnt }" type="number"/></b> 개의 글
		</div>
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="col-xs-6 text-left search">
				<form id='searchForm' action="/freeBoard/list" method='get'>
					<div class="form-group input-group">
						 <select class="form-control" name="type">
							  <option value=""
							  <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
							  <option value="T"
								  <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
							  <option value="C"
								  <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
							  <option value="W"
								  <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
							  <option value="TC"
								  <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목or내용</option>
							  <option value="TW"
								  <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목or작성자</option>
							  <option value="TWC"
								  <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목or내용or작성자</option>
						 </select>			
							 <span class="input-group-btn listBtnSpan">
	                             <input class="form-control" type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
	                             <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
	                             <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
							  	 <button class='btn btn-default'><i class="fa fa-search"></i></button>
		                     </span>  
		            </div>
				</form>
			</div>
									
	    	<div class="col-xs-6 text-right addbtn">
		    	<button id='writeBtn' type="button" class="btn btn-outline btn-primary">
					<i class="fa fa-pencil"> 글쓰기</i>								
				</button>
	    	</div>
		</div>
		
		<div class="col-lg-12">
			<table class="table table-hover" id="dataTables-example">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th class="text-center">작성자</th>
						<th class="text-center">작성일</th>
						<th class="text-center">조회</th>
						<th class="text-center">추천</th>
					</tr>
				</thead>

				<c:forEach items="${list}" var="board">
					<tr>
						<td><c:out value="${board.bno }" /></td>
						<td>
							<a class="move" href='<c:out value="${board.bno }"/>'><c:out value="${board.title }" /></a> 
							<i class="fa fa-comments fa-fw"></i><c:out value="${board.replyCnt}"/>
						</td>
						<td class="text-center"><c:out value="${board.writer }" /></td>
						<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" /></td>
						<td class="text-center"><c:out value="${board.views }" /></td>
						<td class="text-center"><c:out value="${board.likes }" /></td>
					</tr>
				</c:forEach>
			</table>
			
			<!--페이징-->
			<div class='text-center'>
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
						<a href="${pageMaker.startPage -1 }"><i class="fa fa-arrow-left"></i></a></li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
						<li class="paginate_button ${pageMaker.cri.pageNum==num?"active":""}">
							<a href="${num }">${num }</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next }">
						<li class="paginate_button next">
							<a href="${pageMaker.endPage+1 }"><i class="fa fa-arrow-right"></i></a>
						</li>
					</c:if>
				</ul>
			</div>
			<!-- 모달div -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">알림</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>	
		</div>
	</div>

	<form id='actionForm' action="/freeBoard/list" name="board" method='get'>
		<input type='hidden' name='result' value='<c:out value="${result}"/>'> 
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'> 
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'> 
		<input type='hidden' name='type' value='${pageMaker.cri.type }'>
		<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<script src="/resources/js/list.js"></script>
	<script src="/resources/js/board/board_list.js"></script>
</body>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/board/board.css" rel="stylesheet"></head>

<body>
	<div class="row">
		<div class="col-lg-12">
			<sec:authorize access="isAuthenticated()">
	        <sec:authentication property="principal.username" var="user_id"/>
			<h4 class="page-header">내 게시글 - ${user_id}</h4>
			<b><fmt:formatNumber value="${totalCnt }" type="number"/></b> 개의 글
			</sec:authorize>
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
				<button class="btn btn-outline btn-danger" id="deleteSelected_btn">
					<i class="fa fa-trash-o"> 삭제</i>
				</button> 
				<button id='writeBtn' type="button" class="btn btn-outline btn-primary">
					<i class="fa fa-pencil"> 글쓰기</i>								
				</button>
			</div>	
		</div>
		<div class="col-lg-12">
			<table class="table table-hover" id="dataTables-example">
				<thead>
					<tr>
						<th>선택</th>
						<th>글번호</th>
						<th>제목</th>
						<th class="text-center">작성일</th>
						<th class="text-center">조회</th>
						<th class="text-center">추천</th>
					</tr>
				</thead>
				<c:forEach items="${list}" var="board">
					<tr>
						<td>
							<input type="checkbox" name="chBox" class="chBox" value='<c:out value="${board.bno }"/>'>
						</td>
						<td><c:out value="${board.bno }" /></td>
						<td>
							<a class="move" href='<c:out value="${board.bno }"/>'><c:out value="${board.title }" /></a> 
							<i class="fa fa-comments fa-fw"></i><c:out value="${board.replyCnt}"/>
						</td>
						<td class="text-center">
							<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" />
						</td>
						<td class="text-center"><c:out value="${board.views }" /></td>
						<td class="text-center"><c:out value="${board.likes }" /></td>
					</tr>
				</c:forEach>
			</table>			
			<div class="allCheck">
				<div class="text-left">
					<div class="form-group input-group">
						<input type="checkbox" name="allCheck" id="allCheck"> 전체선택
                    </div>
				</div> 	
			</div>
			<!-- 페이징div -->
			<div class='text-center'>
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
						<a href="${pageMaker.startPage -1 }"><i class="fa fa-arrow-left"></i></a></li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
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
		</div>
	</div>
				
	<form id='actionForm' action="/freeBoard/myPage" name="board" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'> 
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'> 
		<input type='hidden' name='type' value='${pageMaker.cri.type }'>
		<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<script src="/resources/js/board/board_edit.js"></script>
	<script src="/resources/js/list.js"></script>
	<script src="/resources/js/board/board_list.js"></script>
</body>
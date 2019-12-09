<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
	<link rel="stylesheet" href="/resources/vendor/jquery/jquery-ui.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
	<script src="/resources/vendor/jquery/jquery-ui.min.js"></script>
	<head><link href="/resources/css/admin/admin.css?1.0" rel="stylesheet"></head>
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<h4 class="page-header">사원관리</h4>
			<b><fmt:formatNumber value="${totalCnt }" type="number"/></b> 명
		</div>
	</div>
	<!-- /.row -->
	<div class="row">
		
		<div class="col-lg-12">
			<div class="col-xs-6 text-left search">
				<form id='searchForm' action="/admin/memberList" method='get'>
					<div class="form-group input-group">
						 <select class="form-control" name="type">
							  <option value=""
							  <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
							  <option value="N"
								  <c:out value="${pageMaker.cri.type eq 'N'?'selected':'' }"/>>이름</option>
							  <option value="D"
								  <c:out value="${pageMaker.cri.type eq 'D'?'selected':'' }"/>>부서</option>
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
		    	<button id='registerBtn' type="button" class="btn btn-default">
					<i class="fa fa-pencil"> 사원등록</i>								
				</button>
		    	<button id='removeBtn' type="button" class="btn btn-default">
					<i class="fa fa-trash-o"> 삭제</i>								
				</button>
	    	</div>
		</div>
		
		<div class="col-lg-12">
			<table class="table table-hover" id="dataTables-example">
				<thead>
					<tr style="background-color: #f5f5f5">
						<th style="width:100px">선택</th>
						<th style="width:200px">이름</th>
						<th style="width:220px">부서</th>
						<th style="width:220px">직위</th>
						<th class="text-center" style="width:200px">휴대폰번호</th>
						<th class="text-center" style="width:200px">내선번호</th>
						<th class="text-center" style="width:200px">이메일</th>
					</tr>
				</thead>
				
				<c:forEach items="${list}" var="member">
					<tr class="memberRow" data-enum='<c:out value="${member.emp_num }" />'>
						<td style="width:50px; padding-left:17px">
							<input type="checkbox" id="chBoxval" name="chBox" class="chBox" value='<c:out value="${member.emp_num }" />'>
						</td>
						<td><c:out value="${member.userName }" /></td>
						<td class="contentxdiv"><c:out value="${member.depName }" /></td>
						<td class="contentxdiv"><c:out value="${member.member_position }" /></td>
						<td class="contentxdiv text-center"><c:out value="${member.phoneNumber }" /></td>
						<td class="contentxdiv text-center"><c:out value="${member.extensionNumber }" /></td>
						<td class="contentxdiv text-center"><c:out value="${member.email }" /></td>
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

	<form id='actionForm' action="/admin/memberList" name="admin" method='get'>
		<input type='hidden' name='result' value='<c:out value="${result}"/>'> 
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'> 
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'> 
		<input type='hidden' name='type' value='${pageMaker.cri.type }'>
		<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<script src="/resources/js/list.js"></script>
	<script src="/resources/js/admin/admin_memberList.js"></script>
</body>

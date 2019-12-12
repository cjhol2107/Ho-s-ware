<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/approval/approval.css" rel="stylesheet"></head>

<body>
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">전자결재 
				<c:choose>
					<c:when test="${kinds eq '미결재'}"><span> - 미결재</span></c:when>
					<c:when test="${kinds eq '승인(최종)'}"><span> - 승인</span></c:when>
					<c:when test="${kinds eq '중간'}"><span> - 진행중</span></c:when>
					<c:when test="${kinds eq '반려'}"><span> - 반려</span></c:when>
				</c:choose>
			</h3>
			<b><fmt:formatNumber value="${totalCnt }" type="number"/></b> 건
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="col-xs-6 text-left search">
				<form id='searchForm' action="/approval/approvalList" method='get'>
					<div class="form-group input-group">
						 <select class="form-control" name="type">
							 <option value=""
							 <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
							 <option value="T"
							 	 <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
							 <option value="K"
								 <c:out value="${pageMaker.cri.type eq 'K'?'selected':'' }"/>>결재구분</option>
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
		    	<button id="approvalAddBtn" type="button" class="btn btn-outline btn-primary">
					<i class="fa fa-pencil"> 결재등록</i>								
				</button>
		    	<button id="approvalRemoveBtn" type="button" class="btn btn-outline btn-danger">
					<i class="fa fa-trash-o"> 결재삭제</i>								
				</button>
	    	</div>
		</div>
		<div class="col-lg-12" >
			<table class="table table-hover" id="dataTables-example">
				<thead>
					<tr>
						<th style="width:50px">선택</th>
						<th style="width:100px">결재번호</th>
						<th style="width:180px">결재구분</th>
						<th style="width:450px">제목</th>
						<th class="text-center">부서/등록자</th>
						<th class="text-center">등록일</th>
						<c:if test="${kinds eq '승인(최종)' or kinds eq '반려(최종)'}">
							<th class="text-center">최종결재일</th>
						</c:if>
						<th class="text-center" style="width:100px">결재현황</th>
					</tr>
				</thead>
				<c:forEach items="${list}" var="apv">
					<tr>
						<td class="customtd chktd">
							<input type="checkbox" name="chBox" class="chBox" value='<c:out value="${apv.apv_ano }"/>'>
						</td>
						<td><c:out value="${apv.apv_ano }" /></td>
						<td><c:out value="${apv.apv_kinds }" /></td>
						<td>
							<a class="move customfont" href='<c:out value="${apv.apv_ano }"/>'>
								<c:out value="${apv.apv_title }" />
							</a> 
						</td>
						<td class="text-center">
							<c:out value="${apv.apv_dep_name }" />
						    <c:out value="${apv.apv_username }" />
						</td>
						<td class="text-center"><fmt:formatDate
								pattern="yyyy-MM-dd HH:mm" value="${apv.apv_regdate }" /></td>
						<c:if test="${kinds eq '승인(최종)' or kinds eq '반려(최종)'}">
							<td class="text-center"><fmt:formatDate
								pattern="yyyy-MM-dd HH:mm" value="${apv.apv_fnlsigndate }" /></td>
						</c:if>
						<c:choose>
							<c:when test="${kinds eq '미결재'}">
								<td class="text-center" style="color:orange">
							</c:when>
							<c:when test="${kinds eq '승인(중간)'}">
								<td class="text-center" style="color:blue">
							</c:when>
							<c:when test="${kinds eq '승인(최종)'}">
								<td class="text-center" style="color:green">
							</c:when>
							<c:when test="${kinds eq '반려' or kinds eq '반려(최종)' or kinds eq '반려(중간)'}">
								<td class="text-center" style="color:red">
							</c:when>
						</c:choose>
							<label><c:out value="${apv.apv_status }" /></label></td>
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
			<div class="col-xs-12 text-center pagenavi">
         			<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage -1 }">
								<i class="fa fa-arrow-left"></i></a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum==num?"active":""}">
								<a href="${num }">${num }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage+1 }"><i class="fa fa-arrow-right"></i></a>
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
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">알림</h4>
						</div>
						<div class="modal-body">처리가 완료되었습니다.</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
	<form id="actionForm" name="approval" action="/approval/approvalList" method="get">
		<input type='hidden' id="auth" name='auth' value='${pageMaker.cri.auth }'>
		<input type="hidden" id="listKinds" name="listKinds" value="${kinds }">
		<input type='hidden' name="result" value='<c:out value="${result}"/>'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'> 
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'> 
		<input type='hidden' name='type' value='${pageMaker.cri.type }'>
		<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<script src="/resources/js/list.js"></script>
	<script src="/resources/js/approval/approval_list.js"></script>

</body>
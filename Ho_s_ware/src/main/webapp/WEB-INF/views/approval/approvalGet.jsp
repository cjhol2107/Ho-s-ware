<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/approval/approval.css" rel="stylesheet"></head>

<body>
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">결재 상세</h3>
		</div>
	</div>
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="panel-custom">
					<div class="col-lg-12 get-titlewrap">
						<div class="col-xs-6 text-left get-title">
							<div class="form-group customdivider">
								<div class="get-head text-left">제목 │ 
									<span class="get-sub"> 
										<c:out value="${apv.apv_title }"/>
									</span>
								</div> 
							</div>
						</div>
						<div class="col-xs-6">
							<div class="get-head text-left">소속 / 이름 │ 
								<span class="get-sub"> 
									<sec:authentication property="principal" var="pinfo" />
								<c:out value="${apv.apv_dep_name} / ${apv.apv_username}"/>
								</span>
							</div> 
						</div>
					</div>

					<div class="col-lg-12 get-titlewrap">
						<div class="col-xs-6 text-left get-title">
							<div class="form-group customdivider">
								<div class="get-head text-left">결재분류 │ 
									<span class="get-sub"> 
										<c:out value="${apv.apv_kinds }"/>
									</span>
							</div> 
							</div>
						</div>
						
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
							<c:when test="${kinds eq '반려'}">
								<td class="text-center" style="color:red">
							</c:when>
						</c:choose>
						
						<div class="col-xs-6 ">
							<div class="get-head text-left">결재상태 │ 
								<span class="get-sub status"> 
									<c:out value="${apv.apv_status }"/>
								</span>
							</div> 
						</div>
					</div>
					<div class="form-group customdivider divider">
					<div class="get-head get-apvlineTitle">결재라인</div>
						<table class="table signTable">
							<thead>
								<tr>
									<th class="text-left">구분</th>
									<th class="text-center" style="width:30%">작성자</th>
									<th class="text-center" style="width:30%">중간결재자</th>
									<th class="text-center" style="width:30%">최종결재자</th>								
								</tr>
							</thead>
							<tbody>
								<tr class="text-center">
									<td class="text-left"><b>부서</b></td>
									<td>${apv.apv_dep_name}</td>
									<td>${midapv.apv_mid_depname}</td>
									<td>경영지원부</td>
								</tr>
								<tr class="text-center">
									<td class="text-left"><b>직위</b></td>
									<td>${apv.apv_position}</td>
									<td>${midapv.apv_mid_position}</td>
									<td>대표이사</td>
								</tr>
								<tr class="text-center">
									<td class="text-left"><b>성명</b></td>
									<td>${apv.apv_username}</td>
									<td>${midapv.apv_mid_name }</td>
									<td>김철수</td>
								</tr>
								<tr class="text-center">
									<td class="text-left"><b>결재일자</b></td>
									<td style="font-size:13px"><fmt:formatDate value="${apv.apv_mysigndate }" pattern="yyyy-MM-dd HH:mm"/></td>
									<td style="font-size:13px"><fmt:formatDate value="${apv.apv_midsigndate }" pattern="yyyy-MM-dd HH:mm"/></td>
									<td style="font-size:13px"><fmt:formatDate value="${apv.apv_fnlsigndate }" pattern="yyyy-MM-dd HH:mm"/></td>
								</tr>
								<tr class="sign text-center">
									<td class="text-left"><b>서명</b></td>
									<td><div class="mysign"></div></td>
									<td><div class="midsign"></div></td>
									<td><div class="fnlsign"></div></td>
								</tr>
							</tbody>
						</table>
					</div>
	
					<div class="uploadResult customdivider">
						<div class="get-head get-divider">결재파일</div>
						<ul>
						</ul>						
					</div>
						
					<div class="form-group customdivider">
						<div class="get-head">등록의견</div>
						<input type="text" name="reg_comments"
							class="form-control add-commentInput" value="${apv.reg_comments}" readonly="readonly">
					</div>
					
					<div class="form-group">
						<c:if test="${not empty apv.apv_comments}">
							<div class="get-head get-divider10">결재의견</div>
							<input type="text" name="apv_comments"
								class="form-control" style="height:40px; background-color:white;" value="${apv.apv_comments}" readonly="readonly">
						</c:if>
					</div>
					
					<div class="text-center">
						<button type="submit" id="list" class="btn btn-default"><i class="fa fa-list"> 목록</i></button>
						<button type="submit" id="remove" class="btn btn-default"><i class="fa fa-trash-o"> 삭제</i></button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<form id="actionForm" action="/approval/approvalList" method="get">	
		<input type="hidden" id="ano" name="apv_ano" value="${apv.apv_ano}">
		<input type="hidden" id="listKinds" name="listKinds" value="${apv.apv_status}">
		<input type='hidden' name='pageNum' value='${cri.pageNum }'>
		<input type='hidden' name='amount' value='${cri.amount }'>
		<input type='hidden' name='type' value='${cri.type }'>
		<input type='hidden' name='keyword' value='${cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
		<input type="hidden" id="status" value="${apv.apv_status}" />
	</form>
	
	<script src="/resources/js/approval/approval_get.js"></script>
</body>
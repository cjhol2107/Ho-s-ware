<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.uploadResult ul {
	padding-inline-start: 0px;
}
.uploadResult ul li {
	list-style: none;
	padding-inline-start: 0px;
	padding-right:0px;
	width:100%;
}
</style>

<body>
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">결재 상세</h3>
		</div>
	</div>
	<div class="row">
		<div class="panel panel-default">
			<div class="panle-body" style="height: 100%;">
				<div class="panel-custom">
					<div class="col-lg-12" style="padding-left:0px; padding-bottom:20px;">
						<div class="col-xs-6 text-left" style="padding-left:0px; width:350px;">
							<div class="form-group customdivider">
								<div class="get-head text-left">제목 │ 
									<span class="get-sub"> 
										<c:out value="${apv.apv_title }"/>
									</span>
								</div> 
							</div>
						</div>
						<div class="col-xs-6 ">
							<div class="get-head text-left">소속 / 이름 │ 
								<span class="get-sub"> 
									<sec:authentication property="principal" var="pinfo" />
								<c:out value="${apv.apv_dep_name} / ${apv.apv_username}"/>
								</span>
							</div> 
						</div>
					</div>
					
					<div class="col-lg-12" style="padding-left:0px; padding-bottom:20px;">
						<div class="col-xs-6 text-left" style="padding-left:0px; width:350px;">
							<div class="form-group customdivider">
								<div class="get-head text-left">결재분류 │ 
									<span class="get-sub"> 
										<c:out value="${apv.apv_kinds }"/>
									</span>
								</div> 
							</div>
						</div>
						<div class="col-xs-6 ">
							<div class="get-head text-left">결재상태 │ 
								<span class="get-sub status"> 
									<c:out value="${apv.apv_status }"/>
								</span>
							</div> 
						</div>
					</div>
					<div class="form-group customdivider" style="padding-top:20px;">
					<div class="get-head" style="padding-bottom:10px">결재라인</div>
						<table class="table">
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
								
								<tr class="sign text-center">
									<td class="text-left"><b>서명</b></td>
									<td><div class="mysigndiv"></div></td>
									<td><div class="midsigndiv"></div></td>
									<td>
										<div class="fnlsigndiv"></div>
										<button id="signBtn" class="btn btn-default btn-xs">결재하기</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
	
					<div class="uploadResult customdivider">
						<div class="get-head" style="padding-bottom:10px;">결재파일</div>
						<ul></ul>						
					</div>
					
					<div class="form-group customdivider" style="padding-top:20px;">
						<div class="get-head" style="padding-bottom:10px">등록의견</div>
						<input type="text" name="reg_comments"
							class="form-control" style="height:40px; background-color:white;" value="${apv.reg_comments}" readonly="readonly">
					</div>
					
					<div class="form-group customdivider" style="padding-top:20px;">
					
						<div class="get-head" style="padding-bottom:10px">중간결재의견</div>
						<input type="text" name="apv_comments"
							class="form-control" style="height:40px; background-color:white;" value="${apv.apv_comments}" readonly="readonly">
					</div>
						
					<div class="text-center">
						<button type="submit" id="list" class="btn btn-outline btn-info"><i class="fa fa-list"> 목록</i></button>
						<button type="submit" id="approval" class="btn btn-outline btn-success"><i class="fa fa-edit"> 결재하기</i></button>
					</div>
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
					<h4 class="modal-title"><span id="myModalLabel">결재의견</span></h4>
				</div>
				<div class="modal-body">
					<div class="form-group customdivider">
					<label>결재자</label> <input class="form-control" name='approver'
						value="approver" style="background-color:white">
					</div>
					<div class="form-group">
						<label>의견</label> <input class="form-control" name='comments'
							value='comments'>
					</div>
				</div>
				<div class="modal-footer">
					<button id='modalRegisterBtn' type="button" class="btn btn-outline btn-success"><i class="fa fa-check"> 승인</i></button>
					<button id='modalReturnBtn' type="button" class="btn btn-outline btn-danger"><i class="fa fa-share"> 반려</i></button>
					<button id='modalCloseBtn' type="button" class="btn btn-outline btn-primary"><i class="fa fa-times"> 닫기</i></button>
				</div>
			</div>
		</div>
	</div>

	<form id="actionForm" action="/approval/approvalList" method="get">
		<input type="hidden" id="listKinds" name="listKinds" value="${apv.apv_status}">
		<input type='hidden' name='pageNum' value='${cri.pageNum }'>
		<input type='hidden' name='amount' value='${cri.amount }'>
		<input type='hidden' name='type' value='${cri.type }'>
		<input type='hidden' name='keyword' value='${cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	</form>
	
	<form action="/approval/fnlapproval" method="post" id="frm">
		<input type="hidden" name="approverAuth" value="fnlapprover"/>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		<input type='hidden' name='apv_ano' value='${apv.apv_ano }'/>
		<input type='hidden' name='finalapprover' value='${apv.finalapprover }'/>
		<input type="hidden" id="status" value="${apv.apv_status}" />
	</form>
	
	<script src="/resources/js/approval/approval_approvalProc.js"></script>
	<script src="/resources/js/approval/approval_fnlapproval.js"></script>
</body>
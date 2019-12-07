<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/approval/approval.css" rel="stylesheet"></head>

<body>
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">결재등록</h3>
		</div>
	</div>
	<div class="row">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="pagewrap">
					<form action="/approval/approvalAdd" method="post" id="approvalForm" onsubmit="return checkForm()">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
						<div class="form-group customdivider">
							<label>제목</label> 
							<input type="text" name="apv_title" class="form-control" placeholder="제목">
						</div>
						<div class="form-group customdivider">
							<label>결재분류</label> 
							<select class="form-control" name="apv_kinds">
								<option value="--">--</option>
								<option value="업무">업무</option>
								<option value="출장">출장</option>
								<option value="지출결의">지출결의</option>
								<option value="초과근무">초과근무</option>
								<option value="휴가">휴가</option>
							</select>
						</div>
						<div class="form-group customdivider">
						<sec:authentication property="principal" var="pinfo" />
							<label>소속 / 이름</label>
							<input type="text"
								class="form-control" readonly="readonly"
								value="${pinfo.member.userName} / ${pinfo.member.depName}">
							<input type="hidden" name="apv_userid" value="${pinfo.username}">
							<input type="hidden" name="apv_username" value="${pinfo.member.userName}">
							<input type="hidden" name="apv_dep_name" value="${pinfo.member.depName }">
							<input type="hidden" name="apv_position" value="${pinfo.member.member_position }">
						</div>
	
						<div class="form-group customdivider">
							<label>중간승인자</label> 
							<c:choose>
								<c:when test="${pinfo.member.depName eq '개발1팀'}">
									<input type="text" class="form-control" readonly="readonly" 
									value="개발1팀 / manager80">
									<input type="hidden" name="midapprover" value="manager80">
								</c:when>
								<c:when test="${pinfo.member.depName eq '개발2팀'}">
									<input type="text" class="form-control" readonly="readonly" 
									value="개발2팀 / manager81">
									<input type="hidden" name="midapprover" value="manager81">
								</c:when>
							</c:choose>
						</div>
			
						<div class="form-group add-fileInputDiv">
							<label>결재파일첨부</label>
							<input type="file" name="uploadFile" id="inputFile">
						</div>
											
						<div class="uploadResult">
							<ul>
							</ul>						
						</div>
						
						<div class="form-group add-commentDiv">
							<label>등록의견</label>
							<input type="text" name="reg_comments" class="form-control add-commentInput">
						</div>
						
						<label>결재라인</label>
						<table class="table">
								<thead>
									<tr>
										<th style="width:19%">구분</th>
										<th style="width:30.3%">작성자</th>
										<th style="width:30.3%">중간결재자</th>
										<th style="width:30.3%">최종결재자</th>									
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><b>부서</b></td>
										<td>${pinfo.member.depName}</td>
										<td>${midapv.depName}</td>
										<td>경영지원부</td>
									</tr>
									<tr>
										<td><b>직위</b></td>
										<td>${pinfo.member.member_position}</td>
										<td>${midapv.member_position}</td>
										<td>대표이사</td>
									</tr>
									<tr>
										<td><b>성명</b></td>
										<td>${pinfo.member.userName}</td>
										<td>${midapv.userName }</td>
										<td>김철수</td>
									</tr>
									
									<tr class="sign">
										<td><b>서명</b></td>
										<td id="mysign">
											<button id="signBtn" class="btn btn-default btn-xs">결재하기</button>
											<div class="signdiv"></div>
										</td>
										<td></td>
										<td></td>
									</tr>
								</tbody>
							</table>
							<div class="text-center">
								<button type="button" id="approvalRegisterBtn" class="btn btn-info apvaddbtn">결재등록</button>
							</div>
						</form>
						</div>
					
				</div>
			</div>
		</div>
		
	<form id="actionForm" action="/approval/approvalList" method="get">
		<input type="hidden" id="listKinds" name="listKinds" value="미결재">
		<input type="hidden" name="approverAuth" value="registrant"/>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
		<input type='hidden' name='type' value='${pageMaker.cri.type }'>
		<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	</form>
	
	<script src="/resources/js/approval/approval_approvalProc.js"></script>
	<script src="/resources/js/approval/approval_add.js"></script>
</body>
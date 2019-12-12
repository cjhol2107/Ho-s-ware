<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
	<link href="/resources/css/admin/admin.css" rel="stylesheet">
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">상세 조회</h3>
		</div>
	</div>
	<div class="row">
		<div class="text-right btndiv">
			<button class="btn btn-outline btn-info" id="memberListBtn"><i class="fa fa-list"></i> 목록</button>
			<button class="btn btn-outline btn-warning" id="memberEditBtn"><i class="fa fa-edit"></i> 수정</button>
			<button class="btn btn-outline btn-danger" id="memberDelBtn"><i class="fa fa-trash-o"></i> 삭제</button>
		</div>
		<div class="panel panel-default">
			<div class="panle-body">
				<div class="pagewrap">
					<div class="col-lg-12">
						<div class="col-lg-3">
							<div class="photodiv">
							</div>
						</div>
						<div class="col-lg-9">
							<div class="col-lg-4">
								<div class="get-head get-first-box">이름 |
								<span class="get-sub">
									<c:out value="${member.userName }"/>
								</span>
								</div>
								<div class="get-head get-first-box">부서 |
								<span class="get-sub">
									<c:out value="${member.depName }"/>
								</span>
								</div>
							</div>
							<div class="col-lg-5">
								<div class="get-head get-first-box">입사일 |
								<span class="get-sub">
									<fmt:formatDate value="${member.realRegDate }" pattern="yyyy-MM-dd"/>
								</span>
								</div>
								<div class="get-head get-first-box">직위 |
								<span class="get-sub">
									<c:out value="${member.member_position }"/>
								</span>
								</div>
							</div>
						</div>		
					</div>
					
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panle-body" style="padding-bottom:50px">
				<div class="pagewrap">
					<div class="col-lg-12">
						<div class="col-lg-6">
							<div class="get-head get-first-box">아이디 |
							<span class="get-sub">
								<c:out value="${member.userid }"/>
							</span>
							</div>
							<div class="get-head get-first-box">휴대폰번호 |
							<span class="get-sub">
								<c:out value="${member.phoneNumber }"/>
							</span>
							</div>
							<div class="get-head get-first-box">내선번호 |
							<span class="get-sub">
								<c:out value="${member.extensionNumber }"/>
							</span>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="get-head get-first-box">사원번호 |
							<span class="get-sub">
								<c:out value="${member.emp_num }"/>
							</span>
							</div>
							<div class="get-head get-first-box">주소 |
							<span class="get-sub">
								<c:out value="${member.address }"/>
							</span>
							</div>
							<div class="get-head get-first-box">이메일 |
							<span class="get-sub">
								<c:out value="${member.email }"/>
							</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<form id="actionForm" name="admin" action="/admin/memberList" method="get">	
		<input type='hidden' name='userid' value='${member.userid }'>
		<input type='hidden' name='emp_num' value='${member.emp_num }'>
		<input type='hidden' name='pageNum' value='${cri.pageNum }'> 
		<input type='hidden' name='amount' value='${cri.amount }'> 
		<input type='hidden' name='type' value='${cri.type }'>
		<input type='hidden' name='keyword' value='${cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	</form>

	<script src="/resources/js/admin/admin_memberInfo.js"></script>	
</body>
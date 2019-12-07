<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
	<link href="/resources/css/admin/admin.css" rel="stylesheet">
	<link rel="stylesheet" href="/resources/css/fullcalendar/datepicker3.css" />
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header">사원정보수정</h3>
		</div>
	</div>
	<div class="row">
		<div class="panel panel-default">
			<div class="panle-body">
				<div class="pagewrap">
					<form action="/admin/memberEdit" id="memberEditForm" name="form" onsubmit="return checkForm()" method="post">
						<input type='hidden' name='emp_num' value='${member.emp_num }'>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
						 <div class="table-responsive table-bordered">
						 	<table class="table">
						 		<tbody>
						 			<tr>
						 				<th>사진등록</th>
						 				<td>
						 					<div class="col-lg-12">
						 						<div class="col-lg-3 test12">
								 					<div class="uploadResult">
														<ul>
														</ul>						
													</div>
												</div>
						 						<div class="col-lg-9" style="padding-top:10px">
								 					이미지는 가로 96px, 세로 128px를 준수해 주시기 바랍니다.
								 					<input type="file" id="photoInput" name="photoInput">
							 					</div>
						 					</div>
						 				</td>		
						 			</tr>
						 			<tr>
						 				<th>이름</th>
						 				<td><input class="form-control" placeholder="Name" name="userName" value="${member.userName }"></td>	
						 			</tr>
						 			<tr>
						 				<th>아이디</th>
						 				<td><input class="form-control" id="id" name="userid" value= "${member.userid }" readonly="readonly"></td>	
						 			</tr>
						 			<tr>
						 				<th>비밀번호</th>
						 				<td><input type="password" class="form-control" 
						 							id="pw" name="userpw" placeholder="Password"></td>	
						 			</tr>
						 			<tr>
						 				<th>비밀번호 확인</th>
						 				<td>
						 					<input type="password" class="form-control" id="pwcheck"
									oninput="passwordCheck()" placeholder="Confirm Password">
						 				</td>	
						 			</tr>
						 			<tr>
						 				<th>부서</th>
						 				<td>
						 					<select class="form-control" name="depName">
						 						
												<option value="개발1팀"
													<c:if test="${member.depName eq '개발1팀'}"> selected </c:if>>개발1팀</option>
												<option value="개발2팀"
													<c:if test="${member.depName eq '개발2팀'}"> selected </c:if>>개발2팀</option>
												<option value="경영지원부"
													<c:if test="${member.depName eq '경영지원부'}"> selected </c:if>>경영지원부</option>
												<option value="영업1팀"
													<c:if test="${member.depName eq '영업1팀'}"> selected </c:if>>영업1팀</option>
												<option value="영업2팀"
													<c:if test="${member.depName eq '영업2팀'}"> selected </c:if>>영업2팀</option>
											</select>
						 				</td>	
						 			</tr>
						 			<tr>
						 				<th>직급</th>
						 				<td>
						 					<select class="form-control" name="member_position">
												<option value="사원"
													<c:if test="${member.member_position eq '사원'}"> selected </c:if>>사원</option>
												<option value="팀장"
													<c:if test="${member.member_position eq '팀장'}"> selected </c:if>>팀장</option>
											</select>
						 				</td>	
						 			</tr>
						 			<tr>
						 				<th>입사일</th>
						 				<td>
						 					<div class="input-group date" id="datetimepicker">
						 						<input type="text" class="form-control" name="regDate" 
						 								value='<fmt:formatDate value="${member.realRegDate }" pattern="yyyy-MM-dd"/>'>
						 						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						 					</div>
						 				</td>
						 			</tr>
						 			<tr>
						 				<th>휴대폰번호</th>
						 				<td>
						 					<div class="col-lg-12">
						 						<input type="hidden" name="phoneNumber" value="${member.phoneNumber }"/>
						 						<div class="col-xs-3 test12">
						 							<select class="form-control" id="p_first" name="pnum_first">
						 								<option value="010">010</option>
						 							</select>
						 						</div>
						 						<div class="col-xs-1">ㅡ</div>
						 						<div class="col-xs-3">
						 							<input class="form-control" type="text" maxlength="4" id="p_mid" name="pnum_mid">
						 						</div>
						 						<div class="col-xs-1">ㅡ</div>
						 						<div class="col-xs-3">
						 							<input class="form-control" type="text" maxlength="4" id="p_last" name="pnum_last">
						 						</div>
						 					</div>
						 				</td>	
						 			</tr>
						 			<tr>
						 				<th>내선번호</th>
						 				<td>
						 					<div class="col-lg-12 text-left">
						 						<input type="hidden" name="extensionNumber" value="${member.extensionNumber }"/>
						 						<div class="col-xs-3">
						 							<select class="form-control" id="e_first" name="ext_first">
						 								<option value="070">070</option>
						 							</select>
						 						</div>
						 						<div class="col-xs-1">ㅡ</div>
						 						<div class="col-xs-3">
						 							<input class="form-control" type="text" maxlength="4" id="e_mid" name="ext_mid">
						 						</div>
						 						<div class="col-xs-1">ㅡ</div>
						 						<div class="col-xs-3">
						 							<input class="form-control" type="text" maxlength="4" id="e_last" name="ext_last">
						 						</div>
						 					</div>
						 				</td>	
						 			</tr>
						 			<tr>
						 				<th>이메일</th>
						 				<td><input class="form-control" placeholder="E-mail" id="email" name="email" value="${member.email }"></td>
						 			</tr>
						 			<tr>
						 				<th>주소</th>
						 				<td>
						 					<div class="form-group input-group">
						 						<input type="hidden" name="address" value="${member.address }"/>
							 					<input type="text" class="form-control" placeholder="Address" 
							 										id="sample5_address" name="first_address" value="${member.address }">
							 					<span class="input-group-btn">
							 						<input type="button" class="btn btn-default" onclick="daumPost()" value="주소검색"/>
							 					</span>
							 				</div>
						 				</td>
						 			</tr>
						 			<tr>
						 				<th>상세주소</th>
						 				<td><input type="text" class="form-control" id="detailAddress" name="detailAddress"></td>	
						 			</tr>	
						 		</tbody>
						 	</table>
						 </div>
							<div class="text-center" style="padding-top:10px">
								<button type="submit" id="memberEditBtn" class="btn btn-info apvaddbtn">등록</button>
							</div>
					</form>
				</div>
					
			</div>
		</div>
	</div>
		
	<form id="actionForm" action="/admin/memberList" method="get">
		<input type='hidden' name='userid' value='${member.userid }'>
		<input type='hidden' name='pageNum' value='${cri.pageNum }'>
		<input type='hidden' name='amount' value='${cri.amount }'>
		<input type='hidden' name='type' value='${cri.type }'>
		<input type='hidden' name='keyword' value='${cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	</form>
	
	<script src="/resources/js/calendar/vendor/js/bootstrap-datepicker.js"></script>
	<script src="/resources/js/calendar/vendor/js/bootstrap-datepicker.kr.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/resources/js/admin/admin_memberRegister.js"></script>
	<script src="/resources/js/admin/admin_memberEdit.js"></script>
</body>
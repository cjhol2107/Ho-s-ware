<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>
<html lang="en">
<head>
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css?ver=1.1"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	

	function idCheck() {

		var id = $("#id").val();

		console.log("id: " + id);

		$.ajax({
			type : "POST",
			url : "/idcheck",
			data : {
				userid : id
			},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(data) {
				console.log("success: " + data);
				if (data == "NO") {
					$('#id').css("background-color", "#FFCECE");
				} else if (data == "YES") {
					$('#id').css("background-color", "#D4F4FA");
				}
			}
		})

	}

	function pwCheck() {
		var pw = $("#pw").val();
		var pwcheck = $("#pwcheck").val();

		if (pw == pwcheck) {

			$('#pwcheck').css("background-color", "#D4F4FA");
		} else {
			$("#pwcheck").css("background-color", "#FFCECE");
		}
	}

	/* function checkForm(){
		
		//email check
		var email=$("#email").val();
		var id=$("#id").val();
		var birthday=$("#birthday").val();
		
		console.log("id: "+id);
		console.log("bth: "+birthday);
		
		var emailregExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var idregExp = /^[A-Za-z0-9+]*$/;
		var birthdayregExp = /^[0-9]*$/;
		//form check
		var theForm=document.form;
		if(theForm.userName.value==""||theForm.userid.value==""
			||theForm.userpw.value==""||theForm.pwcheck.value==""
			||theForm.email.value==""||theForm.birthday.value==""
			||!email.match(emailregExp)||!id.match(idregExp)
			||!birthday.match(birthdayregExp))
		{
				if(theForm.userName.value==""){
					alert("이름을 입력해주세요");
					theForm.userName.focus();
					return false;
				}
				else if(theForm.userid.value==""){
					alert("ID를 입력해주세요");
					theForm.userid.focus();
					return false;
				}
				else if(theForm.userpw.value==""){
					alert("비밀번호를 입력해주세요");
					theForm.userpw.focus();
					return false;
				}
				else if(theForm.pwcheck.value==""){
					alert("비밀번호 확인을 입력해주세요");
					theForm.pwcheck.focus();
					return false;
				}
				else if(theForm.email.value==""){
					alert("이메일을 입력해주세요");
					theForm.email.focus();
					return false;
				}
				else if(theForm.birthday.value==""){
					alert("생년월일을 입력해주세요");
					theForm.birthday.focus();
					return false;
				}
				else if(!email.match(emailregExp)){
					alert("이메일 형식이 맞지 않습니다");
					theForm.email.focus();
					return false;
				}
				else if(!id.match(idregExp)){
					alert("id는 특수문자 입력이 불가능합니다.");
					theForm.id.focus();
					return false;
				}
				else if(!birthday.match(birthdayregExp)){
					alert("생년월일은 숫자만 입력 가능합니다.");
					theForm.birthday.focus();
					return false;
				}
				
			
		}
		else{
			
			return true;
		}	
	} */
	
	
</script>
</head>
<body>
<div id="page-wrapper" style="margin-left:400px; margin-right:400px;">

<div class="text-center">
	<a href="/freeBoard/list"><img src='/resources/img/logo1.png'></a>
</div>
	<div class="divider" style="width:100%; margin-top:0px;"></div>
	<div class="row">
		<div class="col-lg-12-join">
			<div class="panel panel-default">

				<div class="panel-body-join">
					<div class="row">
						<div class="col-lg-6-join">
							<form role="form" method="post" action="/join" name="form"
								onsubmit="return checkForm()">
								<div class="form-group">
									<label>이름</label>
								</div>
								<input class="form-control-join" name="userName"
									placeholder="Name">
								<div class="form-group">
									<label>아이디</label>
								</div>
								<input type="text" class="form-control-join-id" name="userid"
									id="id" oninput="idCheck()" placeholder="ID">
								<div class="form-group-left"></div>
								<div class="form-group-bottom"></div>
								<div class="form-group">
									<label>비밀번호</label>
								</div>
								<input type="password" class="form-control-join" name="userpw"  
									id="pw" placeholder="Password">
								<div class="form-group">
									<label>비밀번호 확인</label>
								</div>
								<input type="password" class="form-control-join" id="pwcheck"
									oninput="pwCheck()" placeholder="Confirm Password">
								<!-- <p class="help-block">Example block-level help text here.</p> -->

								<div class="form-group">
									<label>이메일</label>
								</div>
								<input class="form-control-join" placeholder="E-mail" name="email" id="email">

								<div class="form-group">
									<label>생년월일</label>
								</div>
								<input class="form-control-join" name="birthday" id="birthday"
									placeholder="ex) 941005" maxlength="6" minlength="6">

								<div class="form-group-btndiv" style="text-align: center;">
									<button type="submit" class="btn btn-outline btn-info">가입</button>
									<button type="reset" class="btn btn-outline btn-danger">취소</button>
								</div>
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }" />
							</form>
						</div>
					</div>
					<!-- /.row (nested) -->
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<!-- /#page-wrapper -->
	<!-- /#wrapper -->
</div>
	<%@include file="./includes/footer.jsp"%>

</body>

</html>

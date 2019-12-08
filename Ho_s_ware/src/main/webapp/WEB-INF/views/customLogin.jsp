<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="author" content="">

</head>

<body>


<div id="page-wrapper" style="border-left:0px; margin-left:0px">

<div class="text-center">
	<a href="/freeBoard/list"><img src='/resources/img/logo1.png'></a>
</div>

	<div class="divider" style="width:100%; margin-top:0px;"></div>
	<div class="col-lg-12-join">
			<div class="panel panel-default">
				<div class="panel-body-join">
					<div class="row">
						<div class="col-lg-6-join">
							<form role="form" method='post' action="/login">

								<div class="form-group">
									<label>아이디</label>
								</div>
								<input type="text" class="form-control-join-id" name="username" placeholder="ID" autofocus style="height:45px;">
								<div class="form-group-left"></div>


								<div class="form-group-bottom"></div>
								<div class="form-group">
									<label>비밀번호</label>
								</div>
								<input type="password" class="form-control-join" name="password"
									placeholder="Password" value="" style="height:45px;">

								<div class="form-group-btndiv" style="text-align: center;">
									<button class="btn btn-success" style="width:98%; height:45px;">로그인</button>
								</div>
								<div class="checkbox">
									<label>
										<input name="remember-me" type="checkbox">로그인 상태 유지
									</label>
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
	<div class="divider" style="margin-top:50px;"></div>
</div>
	
	<c:if test="${param.logout != null}">
		<script>
			$(document).ready(function() {
				alert("로그아웃하였습니다.");
			});
		</script>
	</c:if>
	
<script>
$("div").remove(".sidebar");
$("nav").remove(".navbar");
$("#page-wrapper").attr("id","");
</script>

</body>

</html>

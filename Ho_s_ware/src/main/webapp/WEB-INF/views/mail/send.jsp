<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head><link href="/resources/css/mail/mail.css" rel="stylesheet"></head>

	<div class="row">
		<div class="col-lg-12">
			<h4 class="page-header-rcvmail2">쪽지 쓰기</h4>
		</div>
	</div>
	
	<div class="pagewrap">
		<div class="row">
			<div class="col-lg-12">
				<form action="/mail/send" method="post" id="frm">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
					<div class="div-title">
						<label>받는사람 </label><span class="toMe"> <input type="checkbox" id="toMe">내게쓰기</span>
						<input id="sndid" type="text" name="eml_rcvid" oninput="idCheck()" class="form-control">
						<p class="text-danger" id="err" style="padding-top:5px; display:none;" > 유효하지 않은 아이디입니다!</p>
					</div>
					<div class="div-div">
						<label>제목</label><input type="text" name="eml_title" class="form-control">
					</div>
					<div class="form-group">
			            <label>내용</label>
			            <textarea class="form-control" rows="8" name="eml_content"></textarea>
			        </div>	
				</form>
			</div>
		</div>
	
		<div class='row'>
			<div class="col-xs-12">			
				<div class="col-lg-12 text-center"> 
					<button id="list" class="btn btn-outline btn-primary">
						<i class="fa fa-list"> 목록</i>								
					</button>
					<button id="send" class="btn btn-outline btn-success">
						<i class="fa fa-send"> 보내기</i>								
					</button>
				</div>		
			</div>
		</div>
	</div>	
		
	<form id='actionForm' action="/mail/getReceived" method='post'>
		<input type='hidden' name='eno' value='${mail.eml_eno }'>
		<input type="hidden" id="rcvid" name="rcvid" value='${mail.eml_sndid }'>
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'> 
		<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'> 
		<input type="hidden" name="type"  value='<c:out value="${cri.type }"/>'>
		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<sec:authorize access="isAuthenticated()"> 
		<sec:authentication property="principal" var="pinfo"/>
		<input type="hidden" name="userid" value='<c:out value="${pinfo.username }"/>'/>
	</sec:authorize>
	
	<script src="/resources/js/mail/mail_send.js"></script>				
</body>
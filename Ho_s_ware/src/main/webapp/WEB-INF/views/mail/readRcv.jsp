<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="row" style="padding-bottom:0px">
		<div class="col-lg-12">
			<h4 class="page-header-rcvmail">받은 쪽지함</h4>
		</div>
	</div>
	
	<div class="row">
		<div class="col-lg-12">
			<div class="div">
				<h5 class="getMail-header">
					<b class="getMail-headerb">보낸사람 </b> ${mail.eml_sndid }
				</h5>
			</div>
			<h5>
				<b class="getMail-headerb">보낸시간 </b> 
				<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${mail.snddate }" />
			</h5>	
		</div>
	</div>
	
	<div class="row" style="padding-bottom:0px;">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="content-form">
						<c:out value="${mail.eml_content }"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class='row'>
		<div class="col-xs-12">			
			<div class="col-lg-12 text-right" style="padding-right:0px"> 
				<button id="remove" class="btn btn-outline btn-danger">
					<i class="fa fa-trash-o"> 삭제</i>
				</button> 
				<button id='reply' class="btn btn-outline btn-success">
					<i class="fa fa-reply"> 답장</i>								
				</button>
				<button id="list" class="btn btn-outline btn-primary">
					<i class="fa fa-list"> 목록</i>								
				</button>
			</div>		
		</div>
	</div>
		
	<form id='actionForm' name="readRcv" action="/mail/getReceived" method='post'>
		<input type="hidden" name='eno' value='${mail.eml_eno }'>
		<input type="hidden" name="rcvid" value='${mail.eml_sndid }'>
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'> 
		<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'> 
		<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>		
	
	<script src="/resources/js/mail/mail_read.js"></script>	
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="row">
	<div class="col-lg-12">
		<h4 class="page-header">보낸 쪽지함</h4>
	</div>
</div>

<div class='row' style="padding-bottom:10px">
	<div class="col-xs-12">			
			 <div class="col-xs-6 text-left" style="padding-left:0px">
				<form id='searchForm' action="/mail/getSent" method='get'>
					<div class="form-group input-group">
							<select class="form-control" name="type">
								<option value=""
								<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
								<option value="S"
									<c:out value="${pageMaker.cri.type eq 'S'?'selected':'' }"/>>보낸사람</option>
							</select>
							<span class="input-group-btn" style="width:150px">
                                <input class="form-control" type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
                                <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
                                <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
								<button class='btn btn-default'><i class="fa fa-search"></i></button>
                            </span>  
                     </div>
				</form>
			</div> 		
			<div class="col-lg-6 text-right" style="padding-right:0px"> 
				<button class="btn btn-outline btn-danger" id="deleteSelected_btn">
					<i class="fa fa-trash-o"> 삭제</i>
				</button> 
				<button id='writeBtn' class="btn btn-outline btn-primary">
					<i class="fa fa-pencil"> 쪽지쓰기</i>								
				</button>
			</div>		
	</div>
</div>

<div class="row" style="padding-bottom:0px;">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table class="table table-hover" id="dataTables-example" style="margin-bottom:0px;">
					<thead>
						<tr>
							<th class="text-left" style="width:50px" >선택</th>
							<th class="text-center" style="width:180px">수신확인</th>
							<th>제목</th>
							<th class="text-center">받은사람</th>
							<th class="text-center">보낸시간</th>
						</tr>
					</thead>

					<c:forEach items="${sndMail}" var="mail">
						<tr>
							<td class="customtd" style="width:50px; padding-left:17px">
								<input type="checkbox" name="chBox" class="chBox" value='<c:out value="${mail.eml_eno }"/>'>
							</td>
							<td class="text-center">
								<c:choose>
									<c:when test="${mail.eml_read eq 'Y' }"><i class="fa fa-envelope-o"></i></c:when>
									<c:when test="${mail.eml_read eq 'N' }"><i class="fa fa-envelope"></i></c:when>
								</c:choose>	
							</td>
							<td>
								<a class="move" href='<c:out value="${mail.eml_eno }"/>'>
									<c:out value="${mail.eml_title }" />
								</a>
							</td>
							<td class="text-center" style="width:20%">
								<c:out value="${mail.eml_rcvid }" />
							</td>
							<td class="text-center" style="width:20%">
								<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${mail.snddate }" />
							</td>
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
				<div class='text-center'>
					<ul class="pagination" style="margin-bottom:0px;">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous">
							<a href="${pageMaker.startPage -1 }"><i class="fa fa-arrow-left"></i></a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum==num?"active":""}">
							<a href="${num }">${num }</a>
							</li>
						</c:forEach>

						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage+1 }"><i class="fa fa-arrow-right"></i></a>
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
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.board-header -->
</div>
<!-- /.col-lg-12 -->
				
	<form id='actionForm' name="mail_sent" action="/mail/getSent" method='get'>
		<input type='hidden' name='result' value='<c:out value="${result}"/>'> 
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'> 
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'> 
		<input type='hidden' name='type' value='${pageMaker.cri.type }'>
		<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	</form>
	
	<script src="/resources/js/list.js"></script>		
	<script src="/resources/js/mail/mail_list.js"></script>	
	<script src="/resources/js/mail/mail_delete.js"></script>	
</body>
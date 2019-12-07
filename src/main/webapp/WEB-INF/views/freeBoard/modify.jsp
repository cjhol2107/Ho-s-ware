<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@include file="../includes/header.jsp"%>


<script type="text/javascript"
	src="/resources/naver_editor/js/HuskyEZCreator.js" charset="utf-8"></script>

<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>


<div class="row">
	<div class="col-lg-12">
		<h4 class="page-header">게시글 수정</h4>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<!-- <div class="panel-heading">Board Register</div> -->
			<!-- /.panel-heading -->
			<div class="panel-body">

				<!-- 스프링 시큐리티 사용할때 post 방식의 전송은 반드시 CSRF 토큰을 추가해야 한다  -->
				<form role="form" action="/freeBoard/modify" method="post" id="frm">
					<div class="form-group">
						<label>제목</label> 
						<%-- <input class="form-control" name='title' value="${board.title }"/> --%>
						<input class="form-control" name="title" value='<c:out value="${board.title }"/>'>						
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea name="content" id="content"
							style="width: 100%; height: 400px;"><c:out value="${board.content }"/></textarea>
					</div>
					
					<input type="hidden" name="writer" value="user00"/>
					
					<input type="hidden" name="bno" value='<c:out value="${board.bno }"/>'>
					<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
					<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
					<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
					
					<div class="text-center">
						<button type="submit" data-oper="list" class="btn btn-outline btn-info">목록</button>
						<button type="submit" data-oper="remove" class="btn btn-outline btn-danger">삭제</button>
						<button type="submit" name="modify" id="modify" class="btn btn-outline btn-warning">수정</button>
					</div>
					
						
					<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/> --%>

				</form>
			</div>
		</div>
	</div>
</div>
<!-- row end -->


<script>



 $(function(){
    //전역변수
    var obj = [];              
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "content",
        sSkinURI: "/resources/naver_editor/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
        }
    });
    //전송버튼
    $("#modify").click(function(){
      
        console.log("★★★★★★★★★★★★★★★★★★★★★★★modify click..............");
        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		obj.getById["content"].exec("LOAD_CONTENTS_FIELD");
        //폼 submit
   		var content = $("#content").val();
        
        
        console.log(content); 
      
        /* return false; */
        $("#frm").submit();
    }); 
    
    
}); 
</script>
<script>
$(document).ready(function(){
  

    ////////// 수정,삭제,목록 //////////
    var formObj = $("form");
    
    $("button").on("click",function(e){
    	e.preventDefault();
    	var operation = $(this).data("oper");
    	console.log(operation);
    	
    	if(operation === 'remove'){
    		formObj.attr("action", "/freeBoard/remove");
    	}
    	else if(operation === 'list'){
    		formObj.attr("action","/freeBoard/list").attr("method","get");
    		var pageNumTag = $("input[name='pageNum']").clone();
    		var amountTag = $("input[name='amount']").clone();
    		var keywordTag = $("input[name='keyword']").clone();
    		var typeTag = $("input[name='type']").clone();
    		
    		formObj.empty(); 
    		formObj.append(pageNumTag);
    		formObj.append(amountTag);
    		formObj.append(keywordTag);
    		formObj.append(typeTag);
 
    	}
    	formObj.submit();
    }); 
    
    
});







</script>
<%@include file="../includes/footer.jsp"%>
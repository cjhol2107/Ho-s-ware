/* List JS 
/* modal처리, 페이징, 글 get , 검색처리  */

var result = $("input[name='result']").attr("value");
var actionForm = $("#actionForm");

$(document).ready(function(){
	//결과 modal 처리
	checkModal(result);
	history.replaceState({},null,null);
});

//제목클릭
$(".move").on("click",function(e) {
	
	e.preventDefault();
	// 해당 페이지의 type get, 제목 클릭했을때 type 별로 분기 위해서
	var type=$('#actionForm').attr("name");
	var num=$(this).attr("href");
	getByType(type,num);
});

//페이지 이동
$(".paginate_button a").on("click",function(e){
	e.preventDefault();
	console.log("click");
	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	actionForm.submit();
});

//검색처리
$("#searchForm button").on("click", function(e){
	
	var searchForm = $("#search0Form");
	
	if(!searchForm.find("option:selected").val()){
		alert("검색 종류를 선택하세요!");
		return false;
	}
	if(!searchForm.find("input[name='keyword']").val()){
		alert("키워드를 입력하세요!");
		return false;
	}	
	searchForm.find("input[name='pageNum']").val("1");
	e.preventDefault();
	//키워드,검색어,cri submit
	searchForm.submit();
});

// 리스트 체크박스 allCheck
$("#allCheck").click(function(){
	
	var check = $("#allCheck").prop("checked");
	if(check){
		$(".chBox").prop("checked", true);
	}
	else{
		$(".chBox").prop("checked", false);
	}
});

//result 값으로 modal show {처리완료(등록,수정,삭제...)}
function checkModal(result){
	
	//result값 없을때
	if(result==='' || history.state){
		console.log("if(result=''): "+result);
		return;
	}
	// result>0 ==> 게시글이 등록되었을 때
	else if(parseInt(result)>0){
		console.log("if(result>0): "+result);
		$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.");
	}
	$("#myModal").modal("show");
}

//list 타입에 따라 가져올글의 번호와 actionUrl지정 
function getByType(type,num){
	
	// 히든태그이름, actionUrl
	var hiddenTagName, callUrl = '';
	
	console.log("in func type: "+type);

	if(type=="board"){
		hiddenTagName="bno";
		callUrl="/freeBoard/get";
	}
	else if(type=="mail_received" || type=="mail_getToMe"){
		hiddenTagName="eno";
		callUrl="/mail/readRcv";
	}
	else if(type=="mail_sent"){
		hiddenTagName="eno";
		callUrl="/mail/readSnt";
	}
	else if(type=="approval"){
		
		
		var auth = $("input[name='auth'").val();
		var kinds = $("#listKinds").val();
		hiddenTagName="apv_ano";

		switch(auth){
			case "user":
				callUrl="/approval/approvalGet";
				break;
			case "member":
				if(kinds=="미결재"){
					callUrl="/approval/midapproval";
				}
				else{
					callUrl="/approval/approvalGet";
				}
				break;
			case "admin":
				if(kinds=="승인(중간)"){
					callUrl="/approval/fnlapproval";
				}
				else{
					callUrl="/approval/approvalGet";
				}
				break;
		}
	}
	

	actionForm.append("<input type='hidden' name='"+hiddenTagName+"' value='"+num+"'>");
	actionForm.attr("action", callUrl);
	actionForm.submit();
}
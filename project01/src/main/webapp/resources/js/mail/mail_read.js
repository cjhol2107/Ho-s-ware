var actionForm = $("#actionForm");
var type= actionForm.attr("name");
var callUrl = '';

// 쪽지 답장
$("#reply").on("click",function(e){

	actionForm.attr("method","get");
	actionForm.attr("action","/mail/send");
	actionForm.submit();
});

// read 에서 삭제
$("#remove").on("click",function(e){
	
	if(confirm("정말 삭제하시겠습니까?")){
		if(type=="readRcv"){
			callUrl="/mail/delRcvMail";
		}
		else if(type=="readSnt"){
			callUrl="/mail/delSentMail";
		}
		actionForm.attr("action",callUrl).submit();
	}	
});

// 목록버튼
$("#list").on("click",function(e){
	
	if(type=="readRcv"){
		callUrl="/mail/getReceived";
	}
	else if(type=="readSnt"){
		callUrl="/mail/getSent";
	}
	actionForm.attr("method","get");
	actionForm.attr("action",callUrl);
	actionForm.submit();
});
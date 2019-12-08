//midapproval.js

// 결재하기- modal show
$("#approval").on("click",function(e){
	e.preventDefault();
	addComments("승인");
});

// 목록으로
$("#list").on("click",function(e){
	e.preventDefault();
	$("#actionForm").submit();
});

//중간결재 sign 버튼
$("#signBtn").on("click",function(){
	signBtnEvent();
});

//코멘트 입력모달 버튼 (승인,반려)
$(".modal-footer button").on("click",function(e){
	
	e.preventDefault();
	
	//반려버튼
    if(this.id=="modalReturnBtn"){
    	$("#frm").attr("action","/approval/mid_reject");
    }
    //닫기버튼
    else if(this.id=="modalCloseBtn"){
    	$("#myModal").modal("hide");
    }
	// 결재Comment 추가
	appendComment();
    // 결재파일, 등록자sign, 중간결재자sign 추가
    appendAttachFile();
    appendRegistrarSign();
    appendMidSign();
    
    $("#frm").submit();
    $("#myModal").modal("hide");
});

//결재상태 css
(function(){
	var status = $("#status").val();
	console.log("status: "+status);
	switch(status){
		case "미결재":
			$(".status").css("color","orange");
			break;
		case "승인(중간)":
			$(".status").css("color","blue");
			break;
		case "승인(최종)":
			$(".status").css("color","green");
			break;
		case "반려(중간)":
			$(".status").css("color","red");
			break;
		case "반려(최종)":
			$(".status").css("color","red");
			break;
	}
})();



	
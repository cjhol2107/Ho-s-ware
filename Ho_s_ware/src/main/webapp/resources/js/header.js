var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");

// 사이드바 메뉴 접근 제한 (로그인유도)
$(".sidebar-nav ul li a").on("click",function(e){
	e.preventDefault();

	var userid = $("input[name='user_id']").val();
	
	if(userid==null){
		if(confirm("로그인이 필요합니다! 로그인 하시겠습니까?")){
			location.href="/customLogin";
		}
		else{
			location.href="/freeBoard/list";
		}
	}
	else{
		location.href= $(this).attr("href");
	}
});
//사이드메뉴바 - 일정관리 (권한에 따른 동적메뉴 링크처리)
$(".calendar li a").on("click",function(){
	
	console.log($(this).attr("id"));
	
	var frm = $("form[name='calendar_form']");
	var typeId = $(this).attr("id");
	var calendarType = $("#calendarType");

	console.log(calendarType);
	if(typeId=="companyCalendar"){
		console.log("typeId123: "+typeId);
		calendarType.attr("value","company");
	}
	else if(typeId=="userCalendar"){
		console.log("typeId: "+typeId);
		calendarType.attr("value","user");
	}
	frm.submit();
});

// 사이드메뉴바 - 전자결재 (권한에 따른 동적메뉴 링크처리)
$(".approval li a").on("click",function(){
	
	var frm = $("form[name='approval_form']");
	var approvalListType = $(this).attr("id");
	var listKinds  = $("#listKinds");

	switch(approvalListType){
	
		//** 사원 & 중간승인자 **//
	 	case "yetapv":
			listKinds.attr("value","미결재");
			break;
		case "proceeding":
			listKinds.attr("value","승인(중간)");
			break;
		case "approvalList":
			listKinds.attr("value","승인(최종)");
			break;
		case "rejectedList":
			listKinds.attr("value","반려");
			break;
		case "rejectedList_mid":
			listKinds.attr("value","반려(중간)");
			break;
		
		//** 최종승인자 **//
		case "yetapv_admin":
			listKinds.attr("value","승인(중간)");
			break;
		case "approvalList_admin":
			listKinds.attr("value","승인(최종)");
			break;
		case "rejectedList_admin":
			listKinds.attr("value","반려(최종)");
			break;
		}
		frm.submit();
});

// webSocket 통신 - 안읽은 메시지 count
(function(){
	send_message();
})();

function send_message() {
	
	var wsUri = "ws://localhost:8080/mail/count";
    websocket = new WebSocket(wsUri);

    websocket.onopen = function(evt) {
        onOpen(evt);
    };
    
    websocket.onmessage = function(evt) {
        onMessage(evt);
    };
}

function onOpen(evt) {
	var userid = $("input[name='user_id']").val();
	websocket.send(userid);
}

function onMessage(evt) {
	$(".unreadCnt").html(" "+evt.data);
}



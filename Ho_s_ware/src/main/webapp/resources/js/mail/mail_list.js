//mail list JS
var actionForm = $("#actionForm");
	
//쪽지 쓰기
$("#writeBtn").on("click",function(){

	actionForm.attr("method","get");
	actionForm.attr("action","/mail/send");
	actionForm.submit();
});

//읽은 쪽지 삭제
$(".deleteRead").on("click",function(){
	
	var unread = $("input[name='unread']").attr("value");
	var total = $("input[name='total']").attr("value");
	
	if(total-unread==0){
		alert("삭제할 쪽지가 없습니다!");
		return;
	}
	var confirm_val = confirm("정말 읽은 쪽지를 삭제하시겠습니까?");
	if(confirm_val){
			actionForm.attr("method","post");
			actionForm.attr("action","/mail/deleteReadMail").submit();
	}	
});
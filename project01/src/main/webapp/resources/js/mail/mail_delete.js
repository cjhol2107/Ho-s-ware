//delete JS
var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");

$("#deleteSelected_btn").click(function(){
	
	//쪽지함 type
	var type=$('#actionForm').attr("name");
	//ajax경로, success경로
	var ajaxUrl,successUrl = '';

	if(type=="mail_received"){
		ajaxUrl="/mail/delRcvSelected";
		successUrl="/mail/getReceived";
	}
	else if(type="mail_sent"){
		ajaxUrl="/mail/delSndSelected";
		successUrl="/mail/getSent";
	}
	else if(type="mail_getToMe"){
		ajaxUrl="/mail/remove";
		successUrl="/mail/getToMe";
	}

	if($("input:checkbox[name='chBox']").is(":checked") == false) {
		 alert("쪽지를 선택해주세요!");
		 return;
	}

	if(confirm("정말 삭제하시겠습니까?")){
		//체크된 박스의 쪽지번호 배열
		var checkArr = new Array();
		$("input[class='chBox']:checked").each(function(){
			checkArr.push($(this).val());
		});
	
		$.ajax({
			type : 'POST',
			url : ajaxUrl,
			data : {"checkArr":checkArr},
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(data){	
				location.href = successUrl;
				alert("삭제가 완료되었습니다!");
			}
		});  
	}
});
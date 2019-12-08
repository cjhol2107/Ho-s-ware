//approval_list JS

var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");

// 결재등록버튼
$("#approvalAddBtn").on("click",function(){
		location.href="/approval/approvalAdd";
});

// 결재삭제버튼
$("#approvalRemoveBtn").click(function(){
	
	var auth = $("#auth").val();
	var kinds = $("#listKinds").val();

	//사원은 결재현황이 미결재인 결재문서만 삭제 가능
	if(auth=='user' && kinds!='미결재'){
	//사원이면서 미결재가 아닐때
		alert("삭제 권한이 없습니다!");	
	}
	else{
		if($("input:checkbox[name='chBox']").is(":checked") == false) {
			 alert("삭제할 결재문서를 선택해주세요!");
			 return;
		}
		if(confirm("정말 삭제하시겠습니까?")){
			
			var checkArr = new Array();
			
			$("input[class='chBox']:checked").each(function(){
				checkArr.push($(this).val());
			});		
			
			var data = {"checkArr":checkArr};
			
			 $.ajax({
					type : 'POST',
					url : '/approval/delApvSelected',
					data : data,
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success : function(data){	
							location.href="/approval/approvalList";
							alert("삭제가 완료되었습니다!");
					}
			 });  
		}
	}
});
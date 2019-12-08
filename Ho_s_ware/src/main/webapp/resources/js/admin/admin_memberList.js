//사원등록버튼
$("#registerBtn").on("click",function(){
	location.href="/admin/memberRegister";
});

//사원삭제버튼
$("#removeBtn").on("click",function(){
	
	if(confirm("정말 삭제하시겠습니까?")){
		
		var checkArr = new Array();
		//체크된 박스들의 사원번호를 배열에 넣음
		$("input[class='chBox']:checked").each(function(){
			checkArr.push($(this).val());
		});

		var data = {"checkArr":checkArr};
		 $.ajax({
				type : 'POST',
				url : '/admin/deleteSelected',
				data : data,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(data){	
						location.href="/admin/memberList";
						alert("삭제가 완료되었습니다!");
				}
		 });  
		
	}
});

//jquery 컨텍스트메뉴 
$(function(){
	$.contextMenu({
	    selector: '.memberRow',
	    trigger: 'left',
	    callback: function(key, options) {
     
	        var emp_eno = $(this).closest('tr').attr('data-enum');

	        var frm = $("form[name='admin']");
	        
	        //상세보기
	        if(key=="info"){
	        	frm.append("<input type='hidden' name='emp_num' value='"+emp_eno+"'>");
	        	frm.attr("action", "/admin/memberInfo");
	        	frm.submit();
	        }
	        //사원정보수정
	        else if(key=="edit"){
	        	frm.append("<input type='hidden' name='emp_num' value='"+emp_eno+"'>");
	        	frm.attr("action", "/admin/memberEdit");
	        	frm.submit();
	        }
	        //삭제
	        else if(key=="delete"){
	        	
	        	if(confirm("정말 삭제하시겠습니까?")){
	        		
	        		 $.ajax({
	        				type : 'POST',
	        				url : '/admin/contextDelete',
	        				data : {emp_num:emp_eno},
	        				beforeSend : function(xhr) {
	        					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	        				},
	        				success : function(data){	
	        						location.href="/admin/memberList";
	        						alert("삭제가 완료되었습니다!");
	        				}
	        		 });  
	        	}
	        }
	    },
	    items: {
	    	"info": {name: "상세조회", icon: "fa-info-circle"},
	        "edit": {name: "사원정보수정", icon: "edit"},
	        "delete": {name: "사원삭제", icon: "delete"},
	        "sep1": "--------------",
	        "quit": {name: "닫기", icon: function(){
	            return 'context-menu-icon context-menu-icon-quit';
	        }}
	    }
	});
});



	





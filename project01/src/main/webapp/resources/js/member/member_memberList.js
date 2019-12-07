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
	        //쪽지쓰기
	        else if(key=="sendMail"){
	        	frm.append("<input type='hidden' name='emp_num' value='"+emp_eno+"'>");
	        	frm.attr("action", "/mail/send");
	        	frm.submit();
	        }

	    },
	    items: {
	    	"info": {name: "상세조회", icon: "fa-info-circle"},
	        "sendMail": {name: "쪽지쓰기", icon: "fa-pencil"},
	        "sep1": "--------------",
	        "quit": {name: "닫기", icon: function(){
	            return 'context-menu-icon context-menu-icon-quit';
	        }}
	    }
	});
});
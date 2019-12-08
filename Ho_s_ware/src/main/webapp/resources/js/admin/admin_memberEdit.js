console.log("edit.js..");


(function(){
	
	var userid = $("input[name='userid']").val();
	
	//사진 load
	$.getJSON("/admin/getPhoto", {userid: userid}, function(arr){

		var str="";
		
		$(arr).each(function(i,obj){
			
			var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
		    str += "<img data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'";
			str +="src='/display?fileName="+fileCallPath+"' width='128px' height='160px'/>";
			
		});
		$(".uploadResult ul").html(str);
	});
	
	// 휴대폰번호
	var fullP_num = $("input[name='phoneNumber']").val();
	var splitP_Num = fullP_num.split('-');
	$("#p_mid").attr("value",splitP_Num[1]);
	$("#p_last").attr("value",splitP_Num[2]);
	
	// 내선번호 
	var fullE_num = $("input[name='extensionNumber']").val();
	var splitE_Num = fullE_num.split('-');
	$("#e_mid").attr("value",splitE_Num[1]);
	$("#e_last").attr("value",splitE_Num[2]);
	
	// 주소
	var fullAddress = $("input[name='address']").val();
	var splitAddress = fullAddress.split(' | ');
	$("#sample5_address").attr("value",splitAddress[0]);
	$("#detailAddress").attr("value",splitAddress[1]);
	
})();

//사원수정폼 submit
$("#memberEditBtn").on("click",function(e){
	
	e.preventDefault(); 
    $("#memberEditForm").submit();
});

function checkForm(){
	
	//email check
	var email=$("#email").val();
	var id=$("#id").val();
	
	var emailregExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var idregExp = /^[A-Za-z0-9+]*$/;
	
	//form check
	var theForm=document.form;
	if(theForm.userName.value==""||theForm.userid.value==""||theForm.userpw.value==""||theForm.pwcheck.value==""
		||theForm.email.value==""||!email.match(emailregExp)||!id.match(idregExp)||theForm.depName.value=="--"
		||theForm.member_position.value=="--"||theForm.regDate.value==""||theForm.pnum_first.value=="--"
		||theForm.pnum_mid.value==""||theForm.pnum_last.value==""||theForm.ext_first.value=="--"
		||theForm.ext_mid.value==""||theForm.ext_last.value==""||theForm.first_address.value==""
		||theForm.detailAddress.value=="")
	{
			if(theForm.userName.value==""){
				alert("이름을 입력해주세요");
				theForm.userName.focus();
				return false;
			}
			else if(theForm.userid.value==""){
				alert("ID를 입력해주세요");
				theForm.userid.focus();
				return false;
			}
			else if(theForm.userpw.value==""){
				alert("비밀번호를 입력해주세요");
				theForm.userpw.focus();
				return false;
			}
			else if(theForm.pwcheck.value==""){
				alert("비밀번호 확인을 입력해주세요");
				theForm.pwcheck.focus();
				return false;
			}
			else if(theForm.depName.value=="--"){
				alert("부서를 선택해주세요!");
				theForm.depName.focus();
				return false;
			}
			else if(theForm.member_position.value=="--"){
				alert("직급을 선택해주세요!");
				theForm.member_position.focus();
				return false;
			}
			else if(theForm.regDate.value==""){
				alert("입사일을 입력해주세요!");
				theForm.regDate.focus();
				return false;
			}
			else if(theForm.pnum_first.value=="--"||theForm.pnum_mid.value==""||theForm.pnum_last.value==""){
				alert("휴대폰번호를 입력해주세요!");
				theForm.pnum_first.focus();
				return false;
			}
			else if(theForm.ext_first.value=="--"||theForm.ext_mid.value==""||theForm.ext_last.value==""){
				alert("내선번호를 입력해주세요!");
				theForm.ext_first.focus();
				return false;
			}
			else if(theForm.email.value==""){
				alert("이메일을 입력해주세요");
				theForm.email.focus();
				return false;
			}
			else if(theForm.first_address.value==""){
				alert("주소를 입력해주세요");
				theForm.first_address.focus();
				return false;
			}
			else if(theForm.detailAddress.value==""){
				alert("상세주소를 입력해주세요");
				theForm.detailAddress.focus();
				return false;
			}
			else if(!email.match(emailregExp)){
				alert("이메일 형식이 맞지 않습니다");
				theForm.email.focus();
				return false;
			}
			else if(!id.match(idregExp)){
				alert("id는 특수문자 입력이 불가능합니다.");
				theForm.id.focus();
				return false;
			}
			else if(!birthday.match(birthdayregExp)){
				alert("생년월일은 숫자만 입력 가능합니다.");
				theForm.birthday.focus();
				return false;
			}
	}
	else{
		
		alert("id폼체크성공!");
		
		var fullPhoneNumber = "";
		var fullExtensionNumber = "";
		var fullAddress = "";
		
		fullPhoneNumber += $("#p_first").val()+"-"+$("#p_mid").val()+"-"+$("#p_last").val();
		fullExtensionNumber += $("#e_first").val()+"-"+$("#e_mid").val()+"-"+$("#e_last").val();
		fullAddress += $("#sample5_address").val()+" | "+$("#detailAddress").val();
		
		$("input[name='phoneNumber']").attr("value",fullPhoneNumber);
		$("input[name='extensionNumber']").attr("value",fullExtensionNumber);
		$("input[name='address']").attr("value",fullAddress);

		return true;
	}	
}



console.log("mem register.1s");

// 입사일 datePicker show
$(function () {

	$("#datetimepicker").datepicker({
		format: "yyyy-mm-dd",
		language: "kr",
		autoclose : true
	});
 });

// 다음 주소 찾기 api
function daumPost() {
	
	new daum.Postcode({
		oncomplete: function(data) {
			var addr = data.address;
			document.getElementById("sample5_address").value = addr;
    }
	}).open();
}

// 비밀번호 일치 확인
function passwordCheck() {
	
	console.log("ss");
	var pw = $("#pw").val();
	var pwcheck = $("#pwcheck").val();

	if (pw == pwcheck) {
		$('#pwcheck').css("border-color", "#3c763d");
	} else {
		$("#pwcheck").css("border-color", "#a94442");
	}
}

//id중복체크
function idCheck() {

	var id = $("#id").val();

	console.log("id: " + id);

	$.ajax({
		type : "POST",
		url : "/idcheck",
		data : {
			userid : id
		},
		beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		success : function(data) {
			console.log("success: " + data);
			if (data == "NO") {
				$('#id').css("background-color", "#FFCECE");
			} else if (data == "YES") {
				$('#id').css("background-color", "#D4F4FA");
			}
		}
	})
}

//확장자체크(사원사진 pdf만)
function checkExtension(fileName){
	
	//jpg와 png (사진파일만 등록가능)
	var regex = new RegExp("(.*?)\.(jpg|png)$");
    if(!regex.test(fileName)){
      	alert("사진파일만 등록가능합니다!");
      	return false;
    }
    return true;
} 

//사진 선택 결과 출력
function showUploadedFile(uploadResultArr){
	
	if(!uploadResultArr || uploadResultArr.length==0){return;}
	
	var uploadUL = $(".uploadResult ul");
	var str="";
	
	$(uploadResultArr).each(function(i,obj){
		if(obj.image){
			var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			//data속성(경로, uuid, 이름) 설정 
		    str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
		    str += "<img src='/display?fileName="+fileCallPath+"' width='128px' height='160px'>";
			str +="</li>";
		}
	});
	uploadUL.append(str);
}

function checkForm(){
	
	//email check
	var email=$("#email").val();
	var id=$("#id").val();
	var photoInput=$("#photoInput").val();
	console.log("id: "+id);
	console.log("email: "+email);
	console.log("photoInput: "+photoInput);
	
	var emailregExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var idregExp = /^[A-Za-z0-9+]*$/;
	
	//form check
	var theForm=document.form;
	if(theForm.userName.value==""||theForm.userid.value==""||theForm.userpw.value==""||theForm.pwcheck.value==""
		||theForm.email.value==""||!email.match(emailregExp)||!id.match(idregExp)||theForm.depName.value=="--"
		||theForm.member_position.value=="--"||theForm.regDate.value==""||theForm.pnum_first.value=="--"
		||theForm.pnum_mid.value==""||theForm.pnum_last.value==""||theForm.ext_first.value=="--"
		||theForm.ext_mid.value==""||theForm.ext_last.value==""||theForm.first_address.value==""
		||theForm.detailAddress.value==""||theForm.photoInput.value=="")
	{
			if(photoInput==""){
				alert("사진을 등록해주세요!");
				theForm.photoInput.focus();
				return false;
			}
			else if(theForm.userName.value==""){
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

//파일input 변화시
$("#photoInput").change(function(e){
	  $("#photoInput").val("");
	  console.log("file change");
	  var formData = new FormData();		    
	  var inputFile = $("input[name='photoInput']");  
	  var files = inputFile[0].files;

	  for(var i = 0; i < files.length; i++){
		  // 파일체크(확장자)
		  if(!checkExtension(files[i].name, files[i].size) ){
		      return false;
		  }
		  formData.append("uploadFile", files[i]);
	  }
	  
	  //서버업로드
	  $.ajax({
	      url: '/uploadAjaxAction',
	      processData: false, 
	      contentType: false,
	      beforeSend: function(xhr){
	    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	      },
	      data: formData,
	      type: 'POST',
	      dataType:'json',
	      success: function(result){
	    	  showUploadedFile(result);
	      }
	  });
});

//사원등록(결재정보, 사진 업로드)
$("#memberRegisterBtn").on("click",function(e){
	
	e.preventDefault();
    var str = "";
    var form = $("#memberRegisterForm");
    
    //사원 사진 파일
    $(".uploadResult ul li").each(function(i, obj){
	      
      	  var jobj = $(obj);
   	  
      	  str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
	      
		  form.append(str);
    });   
    form.submit();
});








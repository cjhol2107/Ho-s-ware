var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");

//결재파일 등록 => 서버업로드 => 결재파일 Show
$("input[type='file']").change(function(e){	
	
	var inputFile = $("input[name='uploadFile']"); 
	var formData = new FormData();
	var files = inputFile[0].files;

	//서버 업로드 위한 fileData append
	for(var i=0; i<files.length; i++){
		if(!checkExtension(files[i].name)){
			return false;
		}
		formData.append("uploadFile", files[i]);
	}
	
	$.ajax({
	      url: '/approval/uploadApprovalAction',
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
        	  // file 태그 hide
        	  document.getElementById("inputFile").style.display="none";
	      }
	});
	    
});

//사인버튼클릭
$("#signBtn").on("click",function(e){
	
	e.preventDefault();
	signBtnEvent();
});

// 결재등록(결재정보, 사인, 결재파일 업로드)
$("#approvalRegisterBtn").on("click",function(e){
	
	e.preventDefault();
    var str = "";
    var signstr = "";
    var form = $("#approvalForm");
    
    //결재파일 히든태그 append
    $(".uploadResult ul li").each(function(i, obj){
	      
      	  var jobj = $(obj);
   	  
      	  str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		  form.append(str);
    }); 
    
    //사인 히든태그 append
    $(".signdiv img").each(function(i, obj){
	      
      	  var jobj = $(obj);
 	  
      	  signstr += "<input type='hidden' name='signList["+i+"].mysign_fileName' value='"+jobj.data("filename")+"'>";
      	  signstr += "<input type='hidden' name='signList["+i+"].mysign_uuid' value='"+jobj.data("uuid")+"'>";
      	  signstr += "<input type='hidden' name='signList["+i+"].mysign_uploadPath' value='"+jobj.data("path")+"'>";
      	  form.append(signstr);
    }); 
    form.submit();
});

//확장자체크(결재파일은 pdf만 등록가능)
function checkExtension(fileName){
	
	var regex = new RegExp("(.*?)\.(pdf)$");
    if(!regex.test(fileName)){
      	alert("해당 종류의 파일은 업로드할 수 없습니다!");
      	return false;
    }
    return true;
} 

// 결재등록폼 check
function checkForm(){

	var title = $("input[name=apv_title]").val();
	var kinds = $("select option:selected").val();
	var comments = $("input[name=reg_comments]").val();
	var uploadFile = $("input[name=uploadFile]").val();
	
	if(title==""||kinds=="--"||comments==""||uploadFile==""){

		if(title==""){
			alert("제목을 입력해주세요!");
			return false;
		}
		if(kinds=="--"){
			alert("결재구분를 선택해주세요!");
			return false;
		}
		if(comments==""){
			alert("등록의견을 입력해주세요!");
			return false;
		}
		if(uploadFile==""){
			alert("결재파일을 등록해주세요!");
			return false;
		} 
	} 
}

// 결재파일 Show
function showUploadedFile(uploadResultArr){
	
	if(!uploadResultArr || uploadResultArr.length==0){return;}
	
	var uploadUL = $(".uploadResult ul");
	var str = "";
	
	$(uploadResultArr).each(function(i,obj){
	
		// pdf 보여주는 컨트롤러 display함수에 넘겨줄 경로 
		var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
	    
	    //data속성(경로, uuid, 이름) 설정 후 pdf파일 보여주는 ViewrJS 호출
	    str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
		str +="<iframe style='text-align:center' src='/resources/ViewerJS/#/approval/display?fileName="+fileCallPath+"'width='100%' height='400px' allowfullscreen webkitallowfullscreen></iframe>";
		str +="</li>";
	});
	uploadUL.append(str);
}
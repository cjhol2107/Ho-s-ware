var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");

// file check(확장자,크기)
var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880; //5MB
function checkExtension(fileName, fileSize){
    
    if(fileSize >= maxSize){
      	alert("파일 사이즈가 초과되었습니다!");
      	return false;
    }
    if(regex.test(fileName)){
      	alert("해당 종류의 파일은 업로드할 수 없습니다!");
      	return false;
    }
    return true;
} 

//파일 선택 결과 출력
function showUploadedFile(uploadResultArr){
	
	if(!uploadResultArr || uploadResultArr.length==0){return;}
	
	var uploadUL = $(".uploadResult ul");
	var str="";
	
	$(uploadResultArr).each(function(i,obj){
		if(obj.image){
			var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"'";
			str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
			str +" ><div>";
			str += "<span> "+ obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
			str += "data-type='image' class='btn btn-default-close btn-circle'><i class='fa fa-times' style='color:red'></i></button><br>";
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str +"</li>";
		}else{
			var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			str += "<li "
			str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
			str += "<span> ";
			str += "<i class='fa fa-paperclip' style='color:black'> "+obj.fileName + "</i></span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " ;
			str += "class='btn btn-default-close btn-circle'><i class='fa fa-times' style='color:red'></i></button><br>";
			str += "</a>";
			str += "</div>";
			str +="</li>";
		}
	});
	uploadUL.append(str);
}

//파일input 변화시
$("input[type='file']").change(function(e){
	
	  var formData = new FormData();		    
	  var inputFile = $("input[name='uploadFile']");  
	  var files = inputFile[0].files;

	  for(var i = 0; i < files.length; i++){
		  // 파일체크(확장자,크기)
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

//파일리스트에서 삭제
$(".uploadResult").on("click", "button", function(e){

	var targetFile = $(this).data("file");
	 var type=$(this).data("type");
	 var targetLi=$(this).closest("li");
	 
	if(confirm("파일을 삭제하시겠습니까? ")){
		$.ajax({
			 url: '/deleteFile',
			 beforeSend: function(xhr){
		    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		      },
			 data: {fileName: targetFile, type:type},
			 dataType:'text',
			 type:'POST',
			 success:function(result){
				 targetLi.remove();
			 }
		 });
	}
	else{
		return false;
	}
 });
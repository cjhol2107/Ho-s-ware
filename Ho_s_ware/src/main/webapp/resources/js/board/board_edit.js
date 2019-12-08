var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");
var bno = $("input[name='bno']").attr("value");
var form = $("#form");

$(function(){
	      var obj = [];              
	      //프레임생성
	      nhn.husky.EZCreator.createInIFrame({
	          oAppRef: obj,
	          elPlaceHolder: "content",
	          sSkinURI: "/resources/naver_editor/SmartEditor2Skin.html",
	          htParams : {
	              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseToolbar : true,            
	              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseVerticalResizer : true,    
	              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseModeChanger : true,
	              fOnBeforeUnload : function(){}
	          }
	      });
	      
	      //게시글수정버튼
	      $("#modify").click(function(){
	    	  	
	    	    //에디터 컨텐트값 update
		  	    obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		  		obj.getById["content"].exec("LOAD_CONTENTS_FIELD");
		  		
		  		var content = $("#content").val();
		  	    var str="";
		  	    
		  	  $(".uploadResult ul li").each(function(i, obj){
		          
		            var jobj = $(obj);
		            
		            str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		            str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		            str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		            str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		      });
		  	  form.append(str).submit();     
		  }); 
}); 

// 첨부파일 load
(function(){
  
    $.getJSON("/freeBoard/getAttachList", {bno: bno}, function(arr){
        
       var str = "";
       
       $(arr).each(function(i, attach){
           
           // 이미지일때
           if(attach.fileType){
             var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
             
             str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
             str +=" data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
             str += "<span style='color:black'> "+ attach.fileName+"</span>";
             str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
             str += "class='btn btn-default-close btn-circle'><i class='fa fa-times' style='color:red'></i></button><br>";
             str += "<img src='/display?fileName="+fileCallPath+"'>";
             str += "</div>";
             str +"</li>";
             
             //이미지 아닐때
           }else{
               
             str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
             str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
             str += "<span> ";
 			 str += "<i class='fa fa-paperclip' style='color:black'> "+attach.fileName + "</i></span>";
             str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
             str += " class='btn btn-default-close btn-circle'><i class='fa fa-times' style='color:red'></i></button><br>";
             str += "</a>";
             str += "</div>";
             str +"</li>";
           }
        });
       
       $(".uploadResult ul").html(str);
     });//end getjson
})();//end function 

////////// 버튼이벤트
$("button").on("click",function(e){
	e.preventDefault();
	var operation = $(this).data("oper");
	
	//삭제
	if(operation === 'remove'){
		form.attr("action", "/freeBoard/remove");
		form.submit();
	}
	
	//목록으로
	else if(operation === 'list'){
		form.attr("action","/freeBoard/list").attr("method","get");
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		var keywordTag = $("input[name='keyword']").clone();
		var typeTag = $("input[name='type']").clone();
		
		form.empty(); 
		form.append(pageNumTag);
		form.append(amountTag);
		form.append(keywordTag);
		form.append(typeTag);
		form.submit();
	}
});

//마이페이지선택삭제
$("#deleteSelected_btn").click(function(){
	
	var confirm_val = confirm("정말 삭제하시겠습니까?");
	if(confirm_val){
		
		var checkArr = new Array();
		
		//체크된 박스들의 bno를 배열에 넣음
		$("input[class='chBox']:checked").each(function(){
			checkArr.push($(this).val());
		});

		var data = {"checkArr":checkArr};
		 $.ajax({
				type : 'POST',
				url : '/freeBoard/deleteSelected',
				data : data,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(data){	
						location.href="/freeBoard/myPage";
						alert("삭제가 완료되었습니다!");
				}
		 });  
		
	}
	
});
















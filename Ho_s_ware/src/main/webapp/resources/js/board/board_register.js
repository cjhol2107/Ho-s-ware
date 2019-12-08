var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");

//스마트에디터 load
$(function(){

	//프레임생성
    var obj = [];              
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
            
            htParams: { fOnBeforeUnload : function(){}}
        }
    });
    //게시글등록시 에디터값 get
    $("#savebutton").click(function(){
        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
        $("#frm").submit();
    });  
});


//게시글 등록시 첨부파일을 list로 담아 hidden으로 날림
$("button[type='submit']").on("click", function(e){
	
    e.preventDefault();
    var str = "";
    var formObj = $("form[role='form']");
    
    $(".uploadResult ul li").each(function(i, obj){
    	
    	var jobj = $(obj);
        console.dir(jobj);
    	  
    	str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	    str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	    str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	    str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
    });
    formObj.append(str);
});



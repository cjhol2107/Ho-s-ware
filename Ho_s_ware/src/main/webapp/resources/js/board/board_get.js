var bno = $("input[name='bno']").attr("value");
var operForm = $("#operForm");
var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");
var userid = $("input[name='userid']").attr("value");

// ajax 전송전 csrf토큰 세팅
$(document).ajaxSend(function(e,xhr,options){
	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
});

(function(){
	
	// 게시글 추천수 표시
	heartView();
	// reply showList 
	showList(1);
	
	// getAttachList : bno로 해당 게시글의 첨부파일을 가져옴
    $.getJSON("/freeBoard/getAttachList", {bno: bno}, function(arr){
    	
       var str = "";
       $(arr).each(function(i, attach){
           //첨부파일이 이미지일때
           if(attach.fileType){
        	   
        	   //썸네일 출력을 위해 호출될 파일의 경로 
               var fileCallPath =  encodeURIComponent(attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
               
           	   str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
               str += "<i class='fa fa-photo'><span style='color:black'> "+ attach.fileName+"</i></span><br>";
               str += "<img src='/display?fileName="+fileCallPath+"'>";
               str += "</div>";
               str +"</li>";
           }
           //첨부파일이 이미지가 아닐때
           else{
           	   str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
               str += "<i class='fa fa-paperclip' style='color:black; font-size:14px;' > "+attach.fileName + "</i></span>";
               str += "</div>";
               str +"</li>";
           }
       });
       $(".uploadResult ul").html(str);
       
    });//end getjson  
})();//end function

function heartView(){

	 $.ajax({
			type : 'POST',
			url : '/freeBoard/heartView',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify({bno:bno, userid:replyer}),
			dataType : "json",
			success : function(data){	
				//id로 해당 게시글에 추천 여부 확인 
				if(data=="YES"){
					$("#heartBtn").attr('class','fa fa-heart-o');	
				}
				else if(data=="NO"){
					$("#heartBtn").attr('class','fa fa-heart');
				}	
			}
		}); 
}

// 추천버튼 click
$("#heart").on("click",function(){
	console.log("click heart:");
	if(userid==null){
		if(confirm("로그인한 사용자만 좋아요 할 수 있습니다! 로그인 하시겠습니까?")==true){
			location.href="/customLogin";
		}
		else{
			return false;
		}
	}
	var obj = $("#heart");
		 $.ajax({
			type : 'POST',
			url : '/freeBoard/heart',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify({bno:bno, userid:userid}),
			dataType : "json",
			success : function(data){	
				if(data.check==1){
					//liked already
					$("#heartBtn").attr('class','fa fa-heart-o');
					$("#heartBtn").html(" "+data.like_cnt);
				}
				else if(data.check==0){
					$("#heartBtn").attr('class','fa fa-heart');
					$("#heartBtn").html(" "+data.like_cnt);
				}		
			}
		});  
});

/////////////버튼처리(수정,목록)

$("button[data-oper='modify']").on("click",function(e){
	operForm.attr("action","/freeBoard/modify").submit();
});

$("button[data-oper='list']").on("click",function(e){
	operForm.find("#bno").remove();
	operForm.attr("action","/freeBoard/list");
	operForm.submit();
});

$("#listbtn").on("click",function(){
	operForm.find("#bno").remove();
	operForm.attr("action","/freeBoard/list");
	operForm.submit();
});


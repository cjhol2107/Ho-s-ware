var approvalNum = $("#ano").val();


$("#list").on("click",function(){
	$("#actionForm").submit();
});

$("#remove").on("click",function(e){
	
	if(confirm("정말 삭제하시겠습니까?")){
		$("#actionForm").attr("method","post");
		$("#actionForm").attr("action","/approval/delApv").submit();
	}
	else{
		return;
	}
});

//결재파일 load
(function(){

	//결재번호로 결재파일 getJSON
	$.getJSON("/approval/getAttachList", {ano: approvalNum}, function(arr){

		var str="";
		
		$(arr).each(function(i,obj){
			
			var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      	    	    
		    str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
			str +="<iframe style='text-align:center' src='/resources/ViewerJS/#/approval/display?fileName="+fileCallPath+"'width='100%' height='400px' allowfullscreen webkitallowfullscreen></iframe>";
			str +="</li>";
		});
		$(".uploadResult ul").html(str);
	});
})();

//사인 load
(function(){
	
	//결재번호로 해당 결재문서의 사인list getJSON
	$.getJSON("/approval/getSignList", {ano: approvalNum}, function(arr){

		var str="";
		var strmid="";
		var strfnl="";
		
		$(arr).each(function(i,obj){
		
			String.prototype.replaceAll = function(org, dest) {
			    return this.split(org).join(dest);
			}
			
			//등록자 signdiv에 append
			var fileCallPath =  encodeURIComponent( obj.mysign_uploadPath+"/"+obj.mysign_uuid+"_"+obj.mysign_fileName);			      
		    str += "<img data-path='"+obj.mysign_uploadPath+"' data-uuid='"+obj.mysign_uuid+"' data-filename='"+obj.mysign_fileName+"'";
			str +="src='/approval/displaySign?fileName="+fileCallPath+"' width='80px' height='40px'/>";	
			
			//중간결재자
			if(obj.midsign_fileName!=null){
				var fileCallPath_mid =  encodeURIComponent( obj.midsign_uploadPath+"/"+obj.midsign_uuid+"_"+obj.midsign_fileName);	
			    strmid += "<img data-path='"+obj.midsign_uploadPath+"' data-uuid='"+obj.midsign_uuid+"' data-filename='"+obj.midsign_fileName+"'";
				strmid +="src='/approval/displaySign?fileName="+fileCallPath_mid+"' width='80px' height='40px'/>";	
			}		
			
			//최종결재자
			if(obj.fnlsign_fileName!=null){
				var fileCallPath_fnl =  encodeURIComponent( obj.fnlsign_uploadPath+"/"+obj.fnlsign_uuid+"_"+obj.fnlsign_fileName);	
				strfnl += "<img data-path='"+obj.fnlsign_uploadPath+"' data-uuid='"+obj.fnlsign_uuid+"' data-filename='"+obj.fnlsign_fileName+"'";
				strfnl +="src='/approval/displaySign?fileName="+fileCallPath_fnl+"' width='80px' height='40px'/>";	
			}			
		});
		$(".mysign").html(str);
		$(".midsign").html(strmid);
		$(".fnlsign").html(strfnl);
	});
})(); 

//결재상태 css 설정
(function(){
	var status = $("#status").val();
	console.log("status: "+status);
	switch(status){
		case "미결재":
			$(".status").css("color","orange");
			break;
		case "승인(중간)":
			$(".status").css("color","blue");
			break;
		case "승인(최종)":
			$(".status").css("color","green");
			break;
		case "반려(중간)":
			$(".status").css("color","red");
			break;
		case "반려(최종)":
			$(".status").css("color","red");
			break;
	}
})();

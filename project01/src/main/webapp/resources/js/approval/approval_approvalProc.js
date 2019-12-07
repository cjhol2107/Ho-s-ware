var ano = $("input[name='apv_ano']").val();
var modalObj = $(".modal");
var frm = $("#frm");

//결재파일 load
(function(){
	
	$.getJSON("/approval/getAttachList", {ano: ano}, function(arr){

		var str="";
		
		$(arr).each(function(i,obj){
			
			//display에 넘겨줄 경로
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
	
	$.getJSON("/approval/getSignList", {ano: ano}, function(arr){

		var str="";
		var strmid="";
		
		$(arr).each(function(i,obj){
		
			String.prototype.replaceAll = function(org, dest) {
			    return this.split(org).join(dest);
			}
			//display에 넘겨줄 경로
			var fileCallPath =  encodeURIComponent( obj.mysign_uploadPath+"/"+obj.mysign_uuid+"_"+obj.mysign_fileName);			      
		    str += "<img data-path='"+obj.mysign_uploadPath+"' data-uuid='"+obj.mysign_uuid+"' data-filename='"+obj.mysign_fileName+"'";
			str +="src='/approval/displaySign?fileName="+fileCallPath+"' width='80px' height='40px'/>";
			
			//사인을 load하는데 중간결재자 사인이 있다면 ( 결재현황 : 승인(중간) )
			if(obj.midsign_fileName!=null){
				var fileCallPath_mid =  encodeURIComponent( obj.midsign_uploadPath+"/"+obj.midsign_uuid+"_"+obj.midsign_fileName);	
			    strmid += "<img data-path='"+obj.midsign_uploadPath+"' data-uuid='"+obj.midsign_uuid+"' data-filename='"+obj.midsign_fileName+"'";
				strmid +="src='/approval/displaySign?fileName="+fileCallPath_mid+"' width='80px' height='40px'/>";
			}	
		});
		$(".mysigndiv").html(str);
		$(".midsigndiv").html(strmid);
	});
})();

function signBtnEvent(){
	
	if(confirm("결재하시겠습니까?")){
		
		var auth = $("input[name='approverAuth']").val();
		var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
		var csrfTokenValue = $("meta[name='_csrf']").attr("content");
		$("button").remove("#signBtn");

		$.ajax({
			  url: '/approval/getSign',
		      processData: false, 
		      contentType: false,
		      beforeSend: function(xhr){
		    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		      },
		      type: 'POST',
		      dataType:'json',
	          success: function(result){
	        	  console.log(result);
	        	  showSign(result,auth);
		      }
		});	
	} 
	else{
		return false;
	}
}

function showSign(uploadResultArr,auth){
	
	if(!uploadResultArr || uploadResultArr.length==0){return;}
	
	var str="";
	var fileCallPath="";
	var signdiv="";

	$(uploadResultArr).each(function(i,obj){
		
		//등록자 사인div append
		if(auth=="registrant"){
			signdiv = $(".signdiv");
			var fileCallPath =  encodeURIComponent( obj.mysign_uploadPath+"/"+ obj.mysign_uuid +"_"+obj.mysign_fileName);			      
			str += "<img data-path='"+obj.mysign_uploadPath+"' data-uuid='"+obj.mysign_uuid+"' data-filename='"+obj.mysign_fileName+"'";
			str +="src='/approval/displaySign?fileName="+fileCallPath+"' width='80px' height='40px'/>";
		}
		
		//중간결재자
		else if(auth=="midapprover"){
			signdiv = $(".midsigndiv");
			fileCallPath =  encodeURIComponent( obj.midsign_uploadPath+"/"+ obj.midsign_uuid +"_"+obj.midsign_fileName);			      
			str += "<img data-path='"+obj.midsign_uploadPath+"' data-uuid='"+obj.midsign_uuid+"' data-filename='"+obj.midsign_fileName+"'";
			str +="src='/approval/displaySign?fileName="+fileCallPath+"' width='80px' height='40px'/>";
		}
		
		//최종결재자
		else if(auth=="fnlapprover"){
			signdiv = $(".fnlsigndiv");
			fileCallPath =  encodeURIComponent( obj.fnlsign_uploadPath+"/"+ obj.fnlsign_uuid +"_"+obj.fnlsign_fileName);			      
			str += "<img data-path='"+obj.fnlsign_uploadPath+"' data-uuid='"+obj.fnlsign_uuid+"' data-filename='"+obj.fnlsign_fileName+"'";
			str +="src='/approval/displaySign?fileName="+fileCallPath+"' width='80px' height='40px'/>";
		}
	});
	signdiv.append(str);
}

// 결재의견 modal창 show
function addComments(){

	var approver = $("#approver").val();
	
	modalObj.find("input").val("");
	modalObj.find("input[name='approver']")
			.val(approver)
			.attr("readonly","readonly");
	$("#myModal").modal("show");
	
	return; 
}

//결재의견 append
function appendComment(){
	
	var str = "";
	var comments = modalObj.find("input[name='comments']").val();
    str+="<input type='hidden' name='apv_comments' value='"+comments+"'>";
    frm.append(str);
}

//결재파일 append
function appendAttachFile(){

    $(".uploadResult ul li").each(function(i, obj){
    
    	  var str="";
      	  var jobj = $(obj);
      	  console.dir(jobj);
      	  
      	  str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	      
		  frm.append(str);
    }); 
}

//등록자 사인 append
function appendRegistrarSign(){
	
	$(".mysigndiv img").each(function(i, obj){
		
    	var jobj = $(obj);
    	var signstr='';
	    signstr += "<input type='hidden' name='signList["+i+"].mysign_fileName' value='"+jobj.data("filename")+"'>";
	    signstr += "<input type='hidden' name='signList["+i+"].mysign_uuid' value='"+jobj.data("uuid")+"'>";
	    signstr += "<input type='hidden' name='signList["+i+"].mysign_uploadPath' value='"+jobj.data("path")+"'>";
    	  
    	frm.append(signstr);
  });
}

//중간결재자 사인 append
function appendMidSign(){
	
    $(".midsigndiv img").each(function(i, obj){
	      
    	  var jobj = $(obj);
    	  var signstr='';
    	  
    	  signstr += "<input type='hidden' name='signList["+i+"].midsign_fileName' value='"+jobj.data("filename")+"'>";
    	  signstr += "<input type='hidden' name='signList["+i+"].midsign_uuid' value='"+jobj.data("uuid")+"'>";
    	  signstr += "<input type='hidden' name='signList["+i+"].midsign_uploadPath' value='"+jobj.data("path")+"'>";
    	  
    	frm.append(signstr);
  });	
}

//최종결재자 사인 append
function appendFnlSign(){
	
	$(".fnlsigndiv img").each(function(i, obj){
		
		var jobj = $(obj);
		var signstr='';
		
		signstr += "<input type='hidden' name='signList["+i+"].fnlsign_fileName' value='"+jobj.data("filename")+"'>";
    	signstr += "<input type='hidden' name='signList["+i+"].fnlsign_uuid' value='"+jobj.data("uuid")+"'>";
    	signstr += "<input type='hidden' name='signList["+i+"].fnlsign_uploadPath' value='"+jobj.data("path")+"'>";
		
		frm.append(signstr);
	});	
}



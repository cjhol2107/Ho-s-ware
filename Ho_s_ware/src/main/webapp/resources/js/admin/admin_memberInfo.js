var frm = $("form[name='admin']");

$("#memberListBtn").on("click",function(){
	frm.submit();
});

$("#memberEditBtn").on("click",function(){
	var emp_num = $("input[name='emp_num']").val();
	frm.attr("action","/admin/memberEdit");
	frm.append("<input type='hidden' name='emp_num' value='"+emp_num+"'>");
	frm.submit();
});

$("#memberDelBtn").on("click",function(){
	
});

//사진파일 load
(function(){
	
	var userid = $("input[name='userid']").val();
	
	$.getJSON("/admin/getPhoto", {userid: userid}, function(arr){

		var str="";
		
		$(arr).each(function(i,obj){
		
			String.prototype.replaceAll = function(org, dest) {
			    return this.split(org).join(dest);
			}
			var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
		    str += "<img data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'";
			str +="src='/display?fileName="+fileCallPath+"' width='128px' height='160px'/>";

		});
		$(".photodiv").html(str);
	});
})();

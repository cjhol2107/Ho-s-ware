var bno = $("input[name='bno']").attr("value");
var replyer = $("input[name='userid']").attr("value");
var replyUL = $(".chat");


//댓글 list 출력
function showList(page){
    
    replyService.getList({bno:bno,page: page|| 1 }, function(replyCnt,list) {

     var str="";
     
     if(page==-1){
    	 pageNum = Math.ceil(replyCnt/10.0);
    	 showList(pageNum);
    	 return;
     }
     
     if(list == null || list.length == 0){
    	 return;
     }
     
     for (var i = 0, len = list.length || 0; i < len; i++) {
       
       str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
       str +="  <div><div class='header'><strong class='primary-font'>["
    	   +list[i].rno+"] "+list[i].replyer+"</strong>";
       str +="  <div class='pull-right' style='padding-right:10px'>"+replyService.displayTime(list[i].replyDate);
       str +="<br></div></div>";
       str +="<p>"+list[i].reply+"<small class='pull-right'>";
       
           if(list[i].replyer==replyer){
        	   str +="<button class='btn btn-outline btn-warning btn-xs' id='replyMod'>수정</button>&nbsp";
               str +="<button class='btn btn-outline btn-danger btn-xs' id='replyDel'>삭제</button>";
           }
       str +="</small></p></div></li>";      
     }
     replyUL.html(str);
     showReplyPage(replyCnt);
 }); //end function;
} //end showList

// 페이징 네비게이션 생성
var pageNum = 1;
var replyPageFooter = $(".replyfooter");

function showReplyPage(replyCnt){
  
      var endNum = Math.ceil(pageNum / 10.0) * 10;  
      var startNum = endNum - 9; 
      var prev = startNum != 1;
      var next = false;
      
      if(endNum * 10 >= replyCnt){
          endNum = Math.ceil(replyCnt/10.0);
      }
      if(endNum * 10 < replyCnt){
          next = true;
      }
      
      var str = "<ul class='pagination'>";
      if(prev){
          str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
      }
      for(var i = startNum ; i <= endNum; i++){
          var active = pageNum == i? "active":"";
          str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
      }
      if(next){
          str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
      }
      str += "</ul></div>";
      replyPageFooter.html(str);
}

//페이징 이동
replyPageFooter.on("click","li a", function(e){
	
    e.preventDefault();
    var targetPageNum = $(this).attr("href");
    pageNum = targetPageNum;
    showList(pageNum);
    
});  

/* ****************
 *  replyService ( add, getList, remove, update, get, displayTime )
 * ************** */
var replyService = (function() {

	function add(reply, callback, error) {
		console.log("add reply...............");

		$.ajax({
			type : 'post',
			url : '/freeboard/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}
	

	function getList(param, callback, error) {

	    var bno = param.bno;
	    var page = param.page || 1;
	    
	    $.getJSON("/freeboard/replies/pages/" + bno + "/" + page + ".json",
	        function(data) {
	    	
	          if (callback) {
	            //callback(data); // 댓글 목록만 가져오는 경우 
	            callback(data.replyCnt, data.list); //댓글 숫자와 목록을 가져오는 경우 
	          }
	        }).fail(function(xhr, status, err) {
	      if (error) {
	        error();
	      }
	    });
	  }

	function remove(rno, replyer, callback, error) {
		 
		    
	    $.ajax({
	      type : 'delete',
	      url : '/freeboard/replies/' + rno,
	      
	      data:  JSON.stringify({rno:rno, replyer:replyer}),
	      
	      contentType: "application/json; charset=utf-8",
	      
	      success : function(deleteResult, status, xhr) {
	        if (callback) {
	          callback(deleteResult);
	        }
	      },
	      error : function(xhr, status, er) {
	        if (error) {
	          error(er);
	        }
	      }
	    });
	  }


	function update(reply, callback, error) {

		console.log("RNO: " + reply.rno);

		$.ajax({
			type : 'put',
			url : '/freeboard/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}

	function get(rno, callback, error) {

		$.get("/freeboard/replies/" + rno + ".json", function(result) {

			if (callback) {
				callback(result);
			}

		}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}

	//날짜처리 (오늘날짜면 시간까지, 아니면 날짜까지만 출력)
	function displayTime(timeValue) {


		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";

		if (gap < (1000 * 60 * 60 * 24)) {

			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
					':', (ss > 9 ? '' : '0') + ss ].join('');

		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();

			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
					(dd > 9 ? '' : '0') + dd ].join('');
		}
	};

	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};

})();

/////////////버튼처리
var modalObj = $(".modal");
var modalInputReply = modalObj.find("input[name='reply']");
var modalInputReplyer = modalObj.find("input[name='replyer']");
var modalInputReplyDate = modalObj.find("input[name='replyDate']");
var modalLabel = $("#myModalLabel");
var modalModBtn = $("#modalModBtn");
var modalRemoveBtn = $("#modalRemoveBtn");
var modalRegisterBtn = $("#modalRegisterBtn");

$("#modalCloseBtn").on("click", function(e){
	
	$("#myModal").modal("hide");
});

//댓글작성모달 show
$("#addReplyBtn").on("click", function(e){

	modalObj.find("input").val("");
	modalObj.find("input[name='replyer']").val(replyer).attr("readonly","readonly");
    modalInputReplyDate.closest("div").hide();
    modalObj.find("button[id !='modalCloseBtn']").hide();
   
    modalRegisterBtn.show();
    
    $("#myModal").modal("show");
});

//댓글등록
$("#modalRegisterBtn").on("click",function(e){

	var reply={	
		reply: modalInputReply.val(),
		replyer: modalInputReplyer.val(),
		bno: bno
	};
	
	replyService.add(reply,function(result){
		
		alert("등록이 완료되었습니다!");
		modalObj.find("input").val("");
		modalObj.modal("hide");
		
		showList(-1);
	});
});

//댓글 삭제
$(document).on("click","#replyDel",function(e){
	
	var rno = $(this).closest("li").data("rno");
	
	if(confirm("댓글을 삭제하시겠습니까?")){
		replyService.remove(rno, replyer, function(result){
			alert("삭제가 완료되었습니다!");
			showList(pageNum);
		});
	}
	else{
		return;
	}
});

//////////////////// 댓글 수정 Modal 창 띄움
$(document).on("click","#replyMod",function(e){
	
	var rno = $(this).closest("li").data("rno");

	replyService.get(rno, function(reply){
		
		modalLabel.html("댓글 수정");
		modalInputReply.val(reply.reply);
		modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
		modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
		.attr("readonly","readonly");
		modalObj.data("rno", reply.rno);
		
		modalObj.find("button[id!='modalCloseBtn']").hide();
		modalModBtn.show();
		
		$(".modal").modal("show");
	});
})
// 댓글 수정 
modalModBtn.on("click",function(e){
	
	var originalReplyer = modalInputReplyer.val();
	
	var reply = {
			rno:modalObj.data("rno"), 
			reply:modalInputReply.val(),
			replyer:originalReplyer
	};
	if(replyer != originalReplyer){
		alert("자신이 작성한 댓글만 수정 가능합니다!");
		modalObj.modal("hide");
		return;
	}
	replyService.update(reply, function(result){
		
		alert("수정이 완료되었습니다!");
		modalObj.modal("hide");
		showList(pageNum);
	});
});


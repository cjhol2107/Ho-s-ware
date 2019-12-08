// send JS
var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");
var userid=$("input[name='userid']").attr("value");

// 보낸 사람 ID 쿼리스트링 (답장시 id세팅위해)
function getQueryStringObject() {
    var a = window.location.search.substr(1).split('&');
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i) {
        var p = a[i].split('=', 2);
        if (p.length == 1)
            b[p[0]] = "";
        else
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
}

// 답장(받는사람 id 세팅)
var qs = getQueryStringObject();
var rcvid = qs.rcvid;
if(rcvid!=null){
	$("#sndid").attr("value",rcvid);
}

// 쪽지 작성시 상대방 id체크
function idCheck() {

	var id = $("#sndid").val();
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
			//존재하지 않는 아이디일때
			if (data == "NO") {
				$('#sndid').css("background-color", "#D4F4FA");
				document.all.err.style.display="none";		
			} else if (data == "YES") {
				$('#sndid').css("background-color", "#FFCECE");
				document.all.err.style.display="";
			}
		}
	});
};

// 내게쓰기 체크박스
$("#toMe").on("click",function(){
	var check = $("#toMe").prop("checked");
	
	if(check){
		console.log("checked!!");
		$("#sndid").attr("value",userid);		
	}
	else{
		$("#sndid").attr("value","");
	}
});

////////// 버튼처리
$("#list").on("click",function(){
	location.href="/mail/getReceived";
});

$("#send").on("click",function(){
	$("#frm").submit();
});
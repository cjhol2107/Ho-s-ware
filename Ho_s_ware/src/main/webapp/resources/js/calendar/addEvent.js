var eventModal = $('#eventModal');
var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');
var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');

/* ****************
 *  새로운 일정 생성
 * ************** */

var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김
   
    modalTitle.html('새로운 일정');
    editTitle.val('');
    editDesc.val('');
    editStart.val(start);
    editEnd.val(end);
    editType.val(eventType).prop("selected", true);

    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');

    //새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
    $('#save-event').on('click', function () {
    	
        var eventData = {
            title: editTitle.val(),
            start: editStart.val(),
            end: editEnd.val(),
            description: editDesc.val(),
            type: editType.val(),
            username: username,
            userid: userid,
            backgroundColor: editColor.val(),
            textColor: '#ffffff',
            calendarType: calendarType,
            allDay: false
        };

        if(userid==null){
        	if(confirm("로그인이 필요합니다! 로그인 하시겠습니까?")){
        		location.href="/customLogin";	
        	}
        	else{
        		return;
        	}
        }
        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;

        //하루종일일때
        if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD');
            eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD');
            eventData.allDay = true;
        }
        else{      	
        	eventData.start = moment(eventData.start).add(3,'hours').format('YYYY-MM-DDThh:mm');
            eventData.end = moment(eventData.end).add(3,'hours').format('YYYY-MM-DDThh:mm');
        }
        //일정 등록후 render
        $("#calendar").fullCalendar('renderEvent', eventData, true);
        
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        var jsonData = JSON.stringify(eventData);
        eventModal.modal('hide');
        
        //새로운 일정 저장
        $.ajax({
            type: "post",
            url: "/calendar/insertCalendar",
            dataType: "text",
            contentType: "application/json",
            beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
            data: jsonData,
            success: function (result) {
                //DB연동시 중복이벤트 방지를 위한
            	alert("일정이 등록되었습니다!");
                $('#calendar').fullCalendar('removeEvents');
                $('#calendar').fullCalendar('refetchEvents');
            },
            error:function(xhr,status,error){
                console.log(" error = " + error);
            }
        });
    });
};
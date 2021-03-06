var draggedEventIsAllDay;
var activeInactiveWeekends = true;

var csrfHeaderName = $("meta[name='_csrf_header']").attr("content");
var csrfTokenValue = $("meta[name='_csrf']").attr("content");
var userauth = $("#userauth").val();
var userid = $("#userid").val();
var username = $("#username").val();
var calendarType = $("input[name='calendarType']").val();

//일정 hover시 시간표시 func
function getDisplayEventDate(event) {

  var displayEventDate;

  // allDay => 하루종일이 아니면 
  if (event.allDay == false) {
    var startTimeEventInfo = moment(event.start).format('HH:mm');
    var endTimeEventInfo = moment(event.end).format('HH:mm');
    displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;
    
  // allDay => 하루종일이면
  } else {
    displayEventDate = "하루종일";
  }
  return displayEventDate;
}

// 선택된 카테고리 filtering
function filtering(event) {
	
  var show_type = true;
  var types = $('#type_filter').val();

  if (types && types.length > 0) {
    if (types[0] == "all") {
      show_type = true;
    } else {
      show_type = types.indexOf(event.type) >= 0;
    }
  }
  return show_type;
}

function calDateWhenDragnDrop(event) {
  // 드랍시 수정된 날짜반영
  var newDates = {
    cno: event.cno,
    start: '',
    end: ''
  }

  //하루짜리 all day
  if (event.allDay && event.end === null) {
	  console.log("하루짜리 올데이");
    newDates.start = moment(event.start._d).format('YYYY-MM-DDTHH:mm');
    newDates.end = newDates.start;
  }

  //2일이상 all day
  else if (event.allDay && event.end !== null) {
	  console.log("//2일이상 all day");
    newDates.start = moment(event.start._d).format('YYYY-MM-DDTHH:mm');
    newDates.end = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DDTHH:mm');
  }

  //all day가 아님
  else if (!event.allDay) {
	  console.log(" 올데ㅐ이 아님");
    newDates.start = moment(event.start._d).format('YYYY-MM-DDTHH:mm');
    newDates.end = moment(event.end._d).format('YYYY-MM-DDTHH:mm');
  }

  return newDates;
}


var calendar = $('#calendar').fullCalendar({

  eventRender: function (event, element, view) {

    //일정에 hover시 요약
    element.popover({
      title: $('<div />', {
        class: 'popoverTitleCalendar',
        text: event.title
      }).css({
        'background': event.backgroundColor,
        'color': event.textColor
      }),
      content: $('<div />', {
          class: 'popoverInfoCalendar'
        }).append('<p><strong>등록자:</strong> ' + event.username + '</p>')
        .append('<p><strong>구분:</strong> ' + event.type + '</p>')
        .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
        .append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.description + '</div>'),
      delay: {
        show: "800",
        hide: "50"
      },
      trigger: 'hover',
      placement: 'top',
      html: true,
      container: 'body'
    });

    return filtering(event);

  },

  //주말 숨기기 & 보이기 버튼
  customButtons: {
    viewWeekends: {
      text: '주말',
      click: function () {
        activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
        $('#calendar').fullCalendar('option', {
          weekends: activeInactiveWeekends
        });
      }
    }
  },

  header: {
    left: 'today, prevYear, nextYear, viewWeekends',
    center: 'prev, title, next',
    right: 'month,agendaWeek,agendaDay,listWeek'
  },
  
  views: {
    month: {
      columnFormat: 'dddd'
    },
    agendaWeek: {
      columnFormat: 'M/D ddd',
      titleFormat: 'YYYY년 M월 D일',
      eventLimit: false
    },
    agendaDay: {
      columnFormat: 'dddd',
      eventLimit: false
    },
    listWeek: {
      columnFormat: ''
    }
  },

  /* ****************
   *  일정 받아옴 
   * ************** */
  
  events: function (start, end, timezone, callback) {
    $.ajax({
      type: "post",
      url: "/calendar/getCalendar",
      contentType: 'application/json',
      dataType : "json",
      data: 
    	JSON.stringify({
    		start: start.format('YYYY-MM-DD'),
    		end: end.format('YYYY-MM-DD'),
    		calendarType: calendarType
      }),
      beforeSend : function(xhr) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	  },
      success: function (response) {
    	  console.log("success: "+response);
    	  callback(response);
      }
    });
  },

  eventAfterAllRender: function (view) {
    if (view.name == "month") {
      $(".fc-content").css('height', 'auto');
    }
  },

  eventDragStart: function (event, jsEvent, ui, view) {
    draggedEventIsAllDay = event.allDay;
  },

  //일정 드래그앤드롭
  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
    
	 if(userauth=="user" && calendarType=="company"){
    	 alert("관리자만 수정가능합니다!");
    	 location.reload();
    	 return;
     }
     else{
		$('.popover.fade.top').remove();
	
	    //주,일 view일때 종일 <-> 시간 변경불가
	    if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
	      if (draggedEventIsAllDay !== event.allDay) {
	        alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
	        location.reload();
	        return false;
	      }
	    }
	
	    // 드랍시 수정된 날짜반영
	    var newDates = calDateWhenDragnDrop(event);
	    console.log(newDates);
	
	    //드롭한 일정 업데이트
	    $.ajax({
	      type: "post",
	      url: "/calendar/dragnDropCalendar",
	      contentType: "application/json",
	      data: JSON.stringify(newDates),
	      beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
	      success: function (response) {
	    	  alert("일정이 수정되었습니다!");
	      }
	    });
     }
  },

  select: function (startDate, endDate, jsEvent, view) {

	//user의 사내일정 수정접근 제한
	if(userauth=="user" && calendarType=="company"){
		return false;
	}
	
    $(".fc-body").unbind('click');
    $(".fc-body").on('click', 'td', function (e) {

      $("#contextMenu")
        .addClass("contextOpened")
        .css({
          display: "block",
          left: e.pageX,
          top: e.pageY
        });
      return false;
    });

    var today = moment();

    if (view.name == "month") {
      startDate.set({
        hours: today.hours(),
        minute: today.minutes()
      });
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).subtract(1, 'days');

      endDate.set({
        hours: today.hours() + 1,
        minute: today.minutes()
      });
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    } else {
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    }

    //날짜 클릭시 카테고리 선택메뉴
    var $contextMenu = $("#contextMenu");
    $contextMenu.on("click", "a", function (e) {
      e.preventDefault();
      console.log("카테고리 선택메뉴");

      //닫기 버튼이 아닐때
      if ($(this).data().role !== 'close') {
    	  console.log("닫기 안누르고 카테고리 누름");
          newEvent(startDate, endDate, $(this).html());
       
      }

      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

    $('body').on('click', function () {
      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

  },

  //이벤트 클릭시 수정이벤트
  eventClick: function (event, jsEvent, view) {
	  if(userauth=="user" && calendarType=="company"){
    	 alert("관리자만 수정가능합니다!");
    	 return false;
	  }
	  else{
		  editEvent(event);
	  }
  },

  locale: 'ko',
  timezone: "local",
  nextDayThreshold: "09:00:00",
  allDaySlot: true,
  displayEventTime: true,
  displayEventEnd: true,
  firstDay: 0, //월요일이 먼저 오게 하려면 1
  weekNumbers: false,
  selectable: true,
  weekNumberCalculation: "ISO",
  eventLimit: true,
  views: {
    month: {
      eventLimit: 12
    }
  },
  eventLimitClick: 'week', //popover
  navLinks: true,
  defaultDate: moment('2019-08'), //실제 사용시 삭제
  timeFormat: 'HH:mm',
  defaultTimedEventDuration: '01:00:00',
  editable: true,
  minTime: '00:00:00',
  maxTime: '24:00:00',
  slotLabelFormat: 'HH:mm',
  weekends: true,
  nowIndicator: true,
  dayPopoverFormat: 'MM/DD dddd',
  longPressDelay: 0,
  eventLongPressDelay: 0,
  selectLongPressDelay: 0
});
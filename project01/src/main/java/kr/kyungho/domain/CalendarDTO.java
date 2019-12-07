package kr.kyungho.domain;

import java.util.Date;
import lombok.Data;

@Data
public class CalendarDTO {
	private Long cno;
	private String title;
	private String start;
	private String end;
	private String description;
	private String type;
	private String username;
	private String userid;
	private String backgroundColor;
	private String textColor;
	private Date realStart;
	private Date realEnd;
	private boolean allDay;
	private String calendarType;
}

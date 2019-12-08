package kr.kyungho.domain;

import java.util.Date;
import lombok.Data;

@Data
public class CalendarVO {
	private Long cno;
	private String title;
	private Date start;
	private Date end;
	private String description;
	private String type;
	private String username;
	private String userid;
	private String backgroundColor;
	private String textColor;
	private boolean allDay;
	private String calendarType;
}

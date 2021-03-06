package kr.kyungho.mapper;

import java.util.List;

import kr.kyungho.domain.CalendarDTO;
import kr.kyungho.domain.CalendarVO;

public interface CalendarMapper {
	
	public void addEvent(CalendarVO calendar);
	public void updateEvent(CalendarDTO calendar);
	public void dragnDropEvent(CalendarDTO calendar);
	public void removeEvent(Long cno);
	public List<CalendarVO> searchSchedule(CalendarVO calendar);
	
}

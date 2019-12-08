package kr.kyungho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kyungho.domain.CalendarDTO;
import kr.kyungho.domain.CalendarVO;
import kr.kyungho.mapper.CalendarMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CalendarServiceImpl implements CalendarService {

	@Setter(onMethod_=@Autowired)
	private CalendarMapper mapper;

	@Override
	public void addEvent(CalendarVO calendar) {
		log.info("addEvent: "+calendar);
		mapper.addEvent(calendar);
	}
	
	@Override
	public void updateEvent(CalendarDTO calendar) {
		log.info("updateEvent: "+calendar);
		mapper.updateEvent(calendar);
		
	}

	@Override
	public List<CalendarVO> searchSchedule(CalendarVO calendar) {
		return mapper.searchSchedule(calendar);
	}

	@Override
	public void removeEvent(Long cno) {
		mapper.removeEvent(cno);
	}

	@Override
	public void dragnDropEvent(CalendarDTO calendar) {
		mapper.dragnDropEvent(calendar);
	}	
}

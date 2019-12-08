package kr.kyungho.mapper;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kyungho.domain.CalendarVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CalendarMapperTests {
	
	@Setter(onMethod_= {@Autowired})
	private CalendarMapper mapper;
	
	/*@Test
	public void TestsearchSchedule() throws ParseException {
		CalendarVO vo = new CalendarVO();
		String start = "2019-07-28T13:11";
		String end = "2019-09-08T18:11";
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		
		vo.setStart(transFormat.parse(start));
		vo.setEnd(transFormat.parse(end));
		
		vo.setCalendarAuth("admin");
		vo.setCno(60L);
		
		log.info(mapper.searchSchedule(vo));
	}*/
}

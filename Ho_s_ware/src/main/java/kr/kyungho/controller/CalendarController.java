package kr.kyungho.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;


import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.kyungho.domain.CalendarDTO;
import kr.kyungho.domain.CalendarVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.service.CalendarService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/calendar/*")
@AllArgsConstructor
public class CalendarController {
	
	private CalendarService service;
	
	@GetMapping("/calendarList")
	public void calendarList(Criteria cri, Model model, HttpServletRequest req) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		cri.setUserid(auth.getName());
		
		if(req.isUserInRole("ROLE_USER")){ cri.setAuth("user");}
		else if(req.isUserInRole("ROLE_MEMBER")){ cri.setAuth("member");}
		else if(req.isUserInRole("ROLE_ADMIN")){ cri.setAuth("admin");}

		model.addAttribute("userauth", cri);
	}
	
	@PostMapping("/insertCalendar")
	@ResponseBody
	public void insertCalendar(@RequestBody CalendarVO calendar) {
		
		service.addEvent(calendar);
	}
	
	@PostMapping("/getCalendar")
	@ResponseBody      
	public List<CalendarVO> getCalendar(@RequestBody CalendarVO calendar, HttpServletRequest req){
		
		log.info("calendar: "+calendar);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		calendar.setUserid(auth.getName());
	
		return service.searchSchedule(calendar);
	}
	
	@PostMapping("/removeCalendar")
	@ResponseBody
	public void removeCalendar(@RequestParam("cno") Long cno) {
		service.removeEvent(cno);
	}
	
	@PostMapping("/updateCalendar")
	@ResponseBody      
	public void updateCalendar(@RequestBody CalendarDTO calendar) throws ParseException{

		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		calendar.setRealStart(transFormat.parse(calendar.getStart()));
		calendar.setRealEnd(transFormat.parse(calendar.getEnd()));
		
		service.updateEvent(calendar);
	}
	
	@PostMapping("/dragnDropCalendar")
	@ResponseBody      
	public void dragnDropCalendar(@RequestBody CalendarDTO calendar) throws ParseException{
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
		calendar.setRealStart(transFormat.parse(calendar.getStart()));
		calendar.setRealEnd(transFormat.parse(calendar.getEnd()));
		
		service.dragnDropEvent(calendar);
	}
	
	
}

package kr.kyungho.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.MemberVO;
import kr.kyungho.domain.PageDTO;
import kr.kyungho.service.AdminService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {
	
	private AdminService service;
	private PasswordEncoder pwencoder;
	
	@GetMapping("/memberList")
	public void memberList(Criteria cri, Model model, HttpServletRequest req) {
		
		int total = service.getTotal(cri);
		model.addAttribute("totalCnt", total);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/memberRegister")
	public void memberRegister() {
		
	}
	@PostMapping("/memberRegister")
	public String memberRegister(MemberVO member, RedirectAttributes rttr) throws ParseException {

		if (member.getAttachList() != null) {
			member.getAttachList().forEach(attach -> log.info(attach));
		}

		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		member.setRealRegDate(transFormat.parse(member.getRegDate()));
		String encodedpw=pwencoder.encode(member.getUserpw());
		member.setUserpw(encodedpw);
		
		service.register(member);
		rttr.addFlashAttribute("result", "success");

		return "redirect:/admin/memberList";
	}
	
	@GetMapping("/memberInfo")
	public String memberInfo(@RequestParam("emp_num") Long emp_num, @ModelAttribute("cri") Criteria cri, Model model) {

		model.addAttribute("member", service.getMemberInfo(emp_num));
		return "/admin/memberInfo";
	}
	
	@GetMapping("/memberEdit")
	public void memeberEdit(@RequestParam("emp_num") Long emp_num, @ModelAttribute("cri") Criteria cri, Model model) {

		model.addAttribute("member", service.getMemberInfo(emp_num));
	}
	
	@PostMapping("/memberEdit")
	public String memeberEdit(MemberVO member, RedirectAttributes rttr) throws ParseException {
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		member.setRealRegDate(transFormat.parse(member.getRegDate()));
		String encodedpw=pwencoder.encode(member.getUserpw());
		member.setUserpw(encodedpw);
		
		service.updateMemberInfo(member);
		rttr.addFlashAttribute("result", "success");

		return "redirect:/admin/memberList";
	}
	
	@PostMapping("/deleteSelected")
	@ResponseBody
	public void deleteSelected(@RequestParam(value="checkArr[]") List<String> emp_numArr) {
		
		if(emp_numArr!=null) {
			
			for(int i=0; i<emp_numArr.size(); i++) {
				
				Long eno = Long.parseLong(emp_numArr.get(i));
				MemberVO member = new MemberVO();
				member.setUserid(service.getUserId(eno));
				member.setEmp_num(eno);
				service.deleteAll(member);
			}
		}
		return;
	}
	
	@PostMapping("/contextDelete")
	@ResponseBody
	public void deleteSelected(@RequestParam("emp_num") Long emp_num) {
		
		if(emp_num!=null) {
	
			MemberVO member = new MemberVO();
			member.setUserid(service.getUserId(emp_num));
			member.setEmp_num(emp_num);
			service.deleteAll(member);
		}
		return;
	}
	
	@GetMapping(value = "/getPhoto", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getPhoto(@RequestParam("userid") String userid) {
		
		return new ResponseEntity<>(service.getPhoto(userid), HttpStatus.OK);
	}
	
}

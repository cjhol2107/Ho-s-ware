package kr.kyungho.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import kr.kyungho.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CommonController {

	private MemberService service;
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {

		log.info("access Denied : " + auth);

		model.addAttribute("msg", "Access Denied");
	}

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {

		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	
	@GetMapping("/customLogout")
	public String logoutGET(RedirectAttributes rttr) {

		return "redirect:/customLogin";
	}
	
	//id 중복체크
	@RequestMapping(value="/idcheck", method=RequestMethod.POST)
	public @ResponseBody String idCheck(@RequestParam("userid") String userid) {

		log.info("controller id check...."+userid);
		int result = service.idcheck(userid);
		String check="";
		if(result==1) {check="NO";}
		else if(result==0) {check="YES";}

		return check;
	}
}

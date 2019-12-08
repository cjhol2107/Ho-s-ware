package kr.kyungho.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.EmailVO;
import kr.kyungho.domain.PageDTO;
import kr.kyungho.service.EmailService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mail/*")
@AllArgsConstructor
public class EmailController {

	private EmailService service;
	
	@GetMapping("/getReceived")
	public void getReceivedMail(Criteria cri, Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String user_id=auth.getName();
		cri.setUserid(auth.getName());
		
		int total = service.getRcvTotal(user_id);

		model.addAttribute("getCount", service.getCount(user_id));
		model.addAttribute("rcvMail", service.getReceiveMail(cri));
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/getToMe")
	public void getToMe(Criteria cri, Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String user_id=auth.getName();
		cri.setUserid(auth.getName());

		int total = service.getToMetotal(user_id);

		model.addAttribute("getCount", service.getCount(user_id));
		model.addAttribute("rcvMail", service.getToMe(cri));
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	@GetMapping("/getSent")
	public void getSentMail(Criteria cri, Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String user_id=auth.getName();
		cri.setUserid(auth.getName());
		
		int total = service.getSndTotal(user_id);
		
		model.addAttribute("getCount", service.getCount(user_id));
		model.addAttribute("sndMail", service.getSendMail(cri));
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	@PostMapping("/send")
	public String sendMail(EmailVO vo, RedirectAttributes rttr) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String user_id=auth.getName();
		vo.setEml_sndid(user_id);
		
		service.sendMail(vo);
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/mail/getReceived";
		
	}
	@GetMapping("/send")
	public void sendMail(Model model) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("getCount", service.getCount(auth.getName()));
	}
	
	@GetMapping("/sendReply")
	public void sendReply(@RequestParam("rcvid") String rcvid, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("getCount", service.getCount(auth.getName()));
		log.info("rcvid: "+rcvid);
	}
	
	@GetMapping("/readRcv")
	public void getRcv(@RequestParam("eno") Long eno, @ModelAttribute("cri") Criteria cri, Model model ) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		service.updateEmlRead(eno);
		
		model.addAttribute("mail", service.getMail(eno));
		model.addAttribute("getCount", service.getCount(auth.getName()));

	}
	@GetMapping("/readSnt")
	public void getSnt(@RequestParam("eno") Long eno, @ModelAttribute("cri") Criteria cri, Model model ) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("mail", service.getMail(eno));
		model.addAttribute("getCount", service.getCount(auth.getName()));
	}
	@PostMapping("/remove")
	@ResponseBody
	public void remove(@RequestParam(value="checkArr[]") List<String> enoArr, Criteria cri) {

		if(enoArr!=null) {
			
			for(int i=0; i<enoArr.size(); i++) {
				
				Long eno = Long.parseLong(enoArr.get(i));
				service.deleteMail(eno);
			}
		}
	}
	
	@PostMapping("/delRcvMail")
	public String delRcvMail(@RequestParam("eno") Long eno, Criteria cri, RedirectAttributes rttr) {
		
		log.info("delRcvMail..."+eno);
		String chk = service.sendDelCheck(eno);
		
		if(chk.equals("Y")) {
			service.deleteMail(eno);
		}
		else if(chk.equals("N")) {

			service.updateReceiveDel(eno);
		}	
		rttr.addFlashAttribute("result", "success");
		return "redirect:/mail/getReceived"+cri.getListLink();
	}
	
	@PostMapping("/delRcvSelected")
	@ResponseBody
	public String deleteRcvSelected(@RequestParam(value="checkArr[]") List<String> enoArr, Criteria cri) {
			
		if(enoArr!=null) {
			
			for(int i=0; i<enoArr.size(); i++) {
				
				Long eno = Long.parseLong(enoArr.get(i));
				String chk = service.sendDelCheck(eno);
				
				if(chk.equals("Y")) {
					service.deleteMail(eno);
				}
				else if(chk.equals("N")) {
					
					service.updateReceiveDel(eno);
					service.updateEmlRead(eno);
				}
			}
		}
		return "redirect:/mail/getReceived"+cri.getListLink();
	}
	
	@PostMapping("/delSentMail")
	public String delSentMail(@RequestParam("eno") Long eno, Criteria cri, RedirectAttributes rttr) {
		
		log.info("delSentMail..."+eno);
		String chk = service.receiveDelCheck(eno);
		
		if(chk.equals("Y")) {
			service.deleteMail(eno);
		}
		else if(chk.equals("N")) {
			service.updateSendDel(eno);
		}
		
		rttr.addFlashAttribute("result", "success");
		return "redirect:/mail/getSent"+cri.getListLink();
	}
	
	@PostMapping("/delSndSelected")
	@ResponseBody
	public void deleteSndSelected(@RequestParam(value="checkArr[]") List<String> enoArr) {
		
		log.info("delSndSelected..."+enoArr);
		
		if(enoArr!=null) {
			
			for(int i=0; i<enoArr.size(); i++) {
				
				Long eno = Long.parseLong(enoArr.get(i));
				String chk = service.receiveDelCheck(eno);
				
				if(chk.equals("Y")) {
					service.deleteMail(eno);
				}
				else if(chk.equals("N")) {
					service.updateSendDel(eno);
				}
			}
		}
		return;
	}
	
	@PostMapping("/deleteReadMail")
	public String deleteReadMail(RedirectAttributes rttr) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userid = auth.getName();
		
		service.deleteReadMail(userid);
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/mail/getReceived";
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

}

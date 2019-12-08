package kr.kyungho.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.PageDTO;
import kr.kyungho.service.AdminService;
import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

	private AdminService service;
	
	@GetMapping("/memberList")
	public void memberList(Criteria cri, Model model, HttpServletRequest req) {
		
		int total = service.getTotal(cri);

		model.addAttribute("totalCnt", total);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

}

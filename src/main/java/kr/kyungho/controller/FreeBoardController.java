package kr.kyungho.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;
import kr.kyungho.domain.PageDTO;
import kr.kyungho.service.FreeBoardService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/freeBoard/*")
public class FreeBoardController {

	@Setter(onMethod_ = @Autowired)
	private FreeBoardService service;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list: "+cri);
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotal(cri);
		
		log.info("total: "+total);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}

	@PostMapping("/register")
	public String register(FreeBoardVO board, RedirectAttributes rttr) {

		log.info("register..." + board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		

		return "redirect:/freeBoard/list";
	}

	@GetMapping("/register")
	public void register() {

	}

	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("get or modify..." + bno);

		model.addAttribute("board", service.get(bno));
	}

	@PostMapping("/modify")
	public String modify(FreeBoardVO board, @ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) {

		log.info("modify..."+board);
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "수정이 완료되었습니다.");
		}
		
		return "redirect:/freeBoard/list"+cri.getListLink();
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove...");
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/freeBoard/list"+cri.getListLink();
	}

}

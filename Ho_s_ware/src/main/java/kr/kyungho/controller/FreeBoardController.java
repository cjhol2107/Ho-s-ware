package kr.kyungho.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.BoardLikeVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;
import kr.kyungho.domain.PageDTO;
import kr.kyungho.service.EmailService;
import kr.kyungho.service.FreeBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/freeBoard/*")
@AllArgsConstructor
public class FreeBoardController {

	private FreeBoardService service;
	private EmailService mailService;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("getCount", mailService.getCount(auth.getName()));
		model.addAttribute("totalCnt", total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

	}

	@GetMapping("/register")
	public void register() {

	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(FreeBoardVO board, RedirectAttributes rttr) {


		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/freeBoard/list";
	}

	@GetMapping("/get")
	public String get(HttpServletRequest request, HttpServletResponse response, @RequestParam("bno") Long bno,
			@ModelAttribute("cri") Criteria cri, Model model) {

		//조회수 구현하는 쿠키
		Cookie cookies[] = request.getCookies();
		Cookie viewCookie = null;

		if (cookies != null && cookies.length > 0) {
			// 쿠키 존재
			for (int i = 0; i < cookies.length; i++) {
				// cookie의 name이 cookie+reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌
				if (cookies[i].getName().equals("cookie" + bno)) {
					viewCookie = cookies[i];
				}
			}
		}

		if (viewCookie == null) {
			// 쿠키 없음 -> 생성 -> 추가 -> 조회수 증가
			Cookie newCookie = new Cookie("cookie" + bno, "|" + bno + "|");
			response.addCookie(newCookie);
			service.updateViews(bno);
		}
		model.addAttribute("board", service.get(bno));
		return "/freeBoard/get";
	}

	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("modify page..." + bno);
		model.addAttribute("board", service.get(bno));
	}

	@PostMapping("/modify")
	public String modify(FreeBoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

		log.info("modify..." + board);
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/freeBoard/list" + cri.getListLink();
	}

	@PreAuthorize("principal.username==#board.writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {

		log.info("remove..." + bno);
		List<AttachVO> attachList = service.getAttachList(bno);

		if (service.remove(bno)) {
			// 첨부파일 삭제
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/freeBoard/list" + cri.getListLink();
	}
	
	@GetMapping("/myPage")
	public void myPage(Criteria cri,Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String user_id=auth.getName();
		cri.setUserid(user_id);
	
		int total = service.getTotalMyPage(cri);
		
		model.addAttribute("list", service.getMyPage(cri));
		model.addAttribute("totalCnt", total);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	@PostMapping("/deleteSelected")
	@ResponseBody
	public void deleteSelected(@RequestParam(value="checkArr[]") List<String> bnoArr) {
		
		
		if(bnoArr!=null) {
			for(int i=0; i<bnoArr.size(); i++) {
				Long bno = Long.parseLong(bnoArr.get(i));
				service.deleteSelected(bno);
			}
		}
		return;
		
	}

	//첨부파일삭제
	private void deleteFiles(List<AttachVO> attachList) {

		if (attachList == null || attachList.size() == 0) {
			return;
		}

		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {

					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
							+ attach.getFileName());

					Files.delete(thumbNail);
				}

			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long bno) {

		log.info("getAttachList " + bno);

		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);

	}

	@PostMapping(value = "/heart")
	@ResponseBody
	public JSONObject heart(@RequestBody BoardLikeVO vo) {

		int result, like_cnt;
		JSONObject data = new JSONObject();

		result = service.checkBoardLike(vo);

		if (result == 1) {
			// liked already
			service.deleteBoardLike(vo);
		} else {
			service.insertBoardLike(vo);
		}

		like_cnt = service.getBoardLike(vo.getBno());

		data.put("like_cnt", like_cnt);
		data.put("check", result);

		return data;
	}
}

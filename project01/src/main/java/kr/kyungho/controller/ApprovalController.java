package kr.kyungho.controller;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import kr.kyungho.domain.ApprovalVO;
import kr.kyungho.domain.AttachFileDTO;
import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.PageDTO;
import kr.kyungho.domain.SignDTO;
import kr.kyungho.domain.SignVO;
import kr.kyungho.service.ApprovalService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/approval/*")
@AllArgsConstructor
public class ApprovalController {

	private ApprovalService service;

	@GetMapping("/approvalList")
	public void approvalList(Criteria cri, Model model, HttpServletRequest req) {
	
		if(req.isUserInRole("ROLE_USER")){ cri.setAuth("user");}
		else if(req.isUserInRole("ROLE_MEMBER")){ cri.setAuth("member");}
		else if(req.isUserInRole("ROLE_ADMIN")){ cri.setAuth("admin");}
		
		if(cri.getListKinds()==null) {
			if(cri.getAuth()=="admin") {cri.setListKinds("승인(중간)");}
			else {cri.setListKinds("미결재");}
		}
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userid = auth.getName();
		cri.setUserid(userid);
		int total = service.getTotal(cri);

		model.addAttribute("getCount", service.getCount(cri));
		model.addAttribute("totalCnt", total);
		model.addAttribute("kinds",	cri.getListKinds());
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/approvalGet")
	public String approvalGet(@RequestParam("apv_ano") Long ano, @ModelAttribute("cri") Criteria cri, Model model){

		model.addAttribute("apv", service.get(ano));
		model.addAttribute("midapv", service.getMidInfo(ano));
		
		return "/approval/approvalGet";
	}
	
	@GetMapping("/midapproval")
	public String approvalAdd_manager(@RequestParam("apv_ano") Long ano, @ModelAttribute("cri") Criteria cri, Model model){
		
		model.addAttribute("apv", service.get(ano));
		
		return "/approval/midapproval";
	}
	
	@PostMapping("/midapproval")
	public String approvalAdd_manager(ApprovalVO approval, RedirectAttributes rttr) {
		
		if (approval.getAttachList() != null) {
			approval.getAttachList().forEach(attach -> log.info(attach));
		}
		if (approval.getSignList() != null) {
			approval.getSignList().forEach(sign -> log.info(sign));
		}
		service.midApproval(approval);
		rttr.addFlashAttribute("result","approval");

		return "redirect:/approval/approvalList";	
	}
	
	@GetMapping("/fnlapproval")
	public String fnlapproval(@RequestParam("apv_ano") Long ano, @ModelAttribute("cri") Criteria cri, Model model){
	
		model.addAttribute("apv", service.get(ano));
		model.addAttribute("midapv", service.getMidInfo(ano));
		
		return "/approval/fnlapproval";
	}
	
	@PostMapping("/fnlapproval")
	public String fnlapproval(ApprovalVO approval, RedirectAttributes rttr) {

		if (approval.getAttachList() != null) {
			approval.getAttachList().forEach(attach -> log.info(attach));
		}
		if (approval.getSignList() != null) {
			approval.getSignList().forEach(sign -> log.info(sign));
		}
		service.fnlApproval(approval);
		rttr.addFlashAttribute("result","approval");
		
		return "redirect:/approval/approvalList";	
	}
		
	@GetMapping("/approvalAdd")
	public void approvalAdd(Model model) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userid = auth.getName();
		
		//id로 그 팀의 중간결재자 get
		model.addAttribute("midapv", service.getmidapprover(userid));
	}
	
	@PostMapping("/approvalAdd")
	public String approvalAdd(ApprovalVO approval, RedirectAttributes rttr) {

		if (approval.getAttachList() != null) {
			approval.getAttachList().forEach(attach -> log.info(attach));
		}
		if (approval.getSignList() != null) {
			approval.getSignList().forEach(sign -> log.info(sign));
		}
		service.register(approval);
		rttr.addFlashAttribute("result", "success");

		return "redirect:/approval/approvalList";
	}
	
	@PostMapping("/mid_reject")
	public String mid_reject(ApprovalVO approval, RedirectAttributes rttr) {

		service.mid_reject(approval);
		rttr.addFlashAttribute("result","reject");
		
		return "redirect:/approval/approvalList";
	}
	
	@PostMapping("/fnl_reject")
	public String fnl_reject(ApprovalVO approval, RedirectAttributes rttr) {

		service.fnl_reject(approval);
		rttr.addFlashAttribute("result","reject");
		
		return "redirect:/approval/approvalList";
	}
	
	//결재시 사인show
	@PostMapping(value = "/getSign", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<SignDTO>> getSign(HttpServletRequest req) throws IOException {
		
		boolean isUser = req.isUserInRole("ROLE_USER");
		boolean isMember = req.isUserInRole("ROLE_MEMBER");
		boolean isAdmin = req.isUserInRole("ROLE_ADMIN");
			
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userid = auth.getName();
		String uploadFolder="C:\\sign";
		String uploadFolderPath = getFolder();
		
		//최종 업로드 경로
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		//경로가 만들어지지 않았으면 make
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		SignDTO signDTO = new SignDTO();
		String mysign_fileName=service.getSignFileName(userid);
		
		//업로드
		File sign = new File(uploadFolder,mysign_fileName);
		FileItem fileItem = new DiskFileItem("mainFile", 
								Files.probeContentType(sign.toPath()), 
								false, 
								sign.getName(), 
								(int) sign.length(), 
								sign.getParentFile());
		try {
		    InputStream input = new FileInputStream(sign);
		    OutputStream os = fileItem.getOutputStream();
		    IOUtils.copy(input, os);
		} catch (IOException ex) {
			log.error(ex.getMessage());
		}
	
		//파일에 UUID 붙임
		UUID uuid = UUID.randomUUID();
		String uploadFileName = uuid.toString()+"_"+mysign_fileName;
		
		MultipartFile multipartFile = new CommonsMultipartFile(fileItem);
		File mysign = new File(uploadPath, uploadFileName);
		multipartFile.transferTo(mysign);
		
		List<SignDTO> list = new ArrayList<>();
	
		//권한에 따라 dto 세팅
		if(isUser) {
			signDTO.setMysign_fileName(mysign_fileName);
			signDTO.setMysign_uuid(uuid.toString());
			signDTO.setMysign_uploadPath(uploadFolderPath);
		}
		if(isMember) {
			signDTO.setMidsign_fileName(mysign_fileName);
			signDTO.setMidsign_uuid(uuid.toString());
			signDTO.setMidsign_uploadPath(uploadFolderPath);
		}
		if(isAdmin) {
			signDTO.setFnlsign_fileName(mysign_fileName);
			signDTO.setFnlsign_uuid(uuid.toString());
			signDTO.setFnlsign_uploadPath(uploadFolderPath);
		}
		list.add(signDTO);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping("/delApv")
	public String delApv(@RequestParam("apv_ano") Long apv_ano, Criteria cri, RedirectAttributes rttr) {
		
		service.deleteApv(apv_ano);
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/approval/approvalList"+cri.getListLink();
	}
	
	@PostMapping("/delApvSelected")
	@ResponseBody
	public String deleteApvSelected(@RequestParam(value="checkArr[]") List<String> anoArr, Criteria cri, RedirectAttributes rttr) {
			
		if(anoArr!=null) {
			
			for(int i=0; i<anoArr.size(); i++) {
				
				Long ano = Long.parseLong(anoArr.get(i));
				service.deleteApv(ano);
			}
		}
		rttr.addFlashAttribute("result", "success");
		return "redirect:/approval/approvalList"+cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> getAttachList(Long ano) {

		return new ResponseEntity<>(service.getAttachList(ano), HttpStatus.OK);
	}
	
	@GetMapping(value = "/getSignList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<SignVO>> signList(Long ano) {

		return new ResponseEntity<>(service.getSignList(ano), HttpStatus.OK);
	}
	
	//결재파일 upload
	@PostMapping(value = "/uploadApprovalAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadApprovalAction(MultipartFile[] uploadFile) {
		log.info("uploadApprovalAction..."+uploadFile);
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder="C:\\upload";
		
		String uploadFolderPath = getFolder();
		log.info("uploadFolderPath: "+uploadFolderPath);
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
		
		//경로에 folder가 존재하는지 확인
		//없으면 폴더 생성(uploadPath)경로로 
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
			
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			//순수 파일명
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			attachDTO.setFileName(uploadFileName);
			
			//UUID 붙임
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			
			//서버 Upload
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
			
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				list.add(attachDTO);
				
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);

		log.info("replace: "+str.replace("-", File.separator));
		// ex) 2019-11-08 -> 2019/11/08
		return str.replace("-", File.separator);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
	
		String path = "c:\\upload\\"+fileName;
		Path pdfPath = Paths.get(path);
		File file = new File("c:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(Files.readAllBytes(pdfPath), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("/displaySign")
	@ResponseBody
	public ResponseEntity<byte[]> displaySign(String fileName) {

		File file = new File("c:\\sign\\" + fileName);
		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
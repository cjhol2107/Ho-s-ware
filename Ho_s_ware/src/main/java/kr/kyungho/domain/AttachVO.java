package kr.kyungho.domain;

import lombok.Data;

@Data
public class AttachVO {
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private Long bno;
	private Long apv_ano;
	private String userid;
}

package kr.kyungho.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data	
public class PhotoVo {
	
	private MultipartFile Filedata;
    
    private String callback;
    
    private String callback_func;




}

package kr.kyungho.domain;

import lombok.Data;

@Data
public class SignDTO {
	
	private String mysign_uuid;
	private String mysign_uploadPath;
	private String mysign_fileName;
	
	private String midsign_uuid;
	private String midsign_uploadPath;
	private String midsign_fileName;
	
	private String fnlsign_uuid;
	private String fnlsign_uploadPath;
	private String fnlsign_fileName;

}

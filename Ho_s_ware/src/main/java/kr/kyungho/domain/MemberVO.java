package kr.kyungho.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private Long emp_num;
	private String userid;
	private String userpw;
	private String userName;
	private String email;
	private String depName;
	private String member_position;
	private String phoneNumber;
	private String extensionNumber;
	private String address;
	
	/*private String photo_uploadPath;
	private String photo_fileName;
	private String sign_uploadPath;
	private String sign_fileName;*/
	
	private Date realRegDate;
	String regDate;
	private Date updateDate;
	private boolean enabled;
	
	private List<AttachVO> attachList;
	private List<AuthVO> authList;
	
	
}

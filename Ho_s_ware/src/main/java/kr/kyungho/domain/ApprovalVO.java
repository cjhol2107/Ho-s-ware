package kr.kyungho.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ApprovalVO {
	
	//결재정보
	private Long apv_ano;
	private String apv_title;
	private String apv_kinds;
	private String apv_userid;
	private String apv_username;
	private String apv_dep_name;
	private String apv_position;
	private String apv_status;
	private String reg_comments;
	private String apv_comments;
	
	//결재자
	private String midapprover;
	private String finalapprover;
	
	//결재등록일
	private Date apv_regdate;
	private Date apv_mysigndate;
	private Date apv_midsigndate;
	private Date apv_fnlsigndate;
	
	//결재파일,사인
	private List<AttachVO> attachList;
	private List<SignVO> signList;

}

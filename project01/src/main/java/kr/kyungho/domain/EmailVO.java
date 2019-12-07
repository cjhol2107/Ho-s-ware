package kr.kyungho.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EmailVO {
	
	private Long eml_eno;
	private String eml_title;
	private String eml_content;
	private String eml_sndid;
	private String eml_rcvid;
	private Date snddate;
	private String eml_snd_del;
	private String eml_rcv_del;
	private String eml_read;
	
}

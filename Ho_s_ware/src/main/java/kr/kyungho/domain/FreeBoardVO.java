package kr.kyungho.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FreeBoardVO {
	
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	private int replyCnt;
	private int views;
	private int likes;
	
	private List<AttachVO> attachList;

}

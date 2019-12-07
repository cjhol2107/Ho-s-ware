package kr.kyungho.domain;

import lombok.Data;

@Data
public class getCountDTO {
	
	// mail
	//안읽은, 받은, 보낸, 내게
	private int unreadRcvMailCnt;
	private int rcvMailCnt;
	private int sntMailCnt;
	private int toMeMailCnt;
	
	// approval
	//미결재, 승인, 반려
	private int yetApvCnt;
	private int apvCnt;
	private int cmpApvCnt;
	private int prcApvCnt;
	private int fnlRejApvCnt;
}

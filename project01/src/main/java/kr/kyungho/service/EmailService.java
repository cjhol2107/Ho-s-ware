package kr.kyungho.service;

import java.util.List;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.EmailVO;
import kr.kyungho.domain.getCountDTO;

public interface EmailService {
	
	public List<EmailVO> getReceiveMail(Criteria cri);
	public List<EmailVO> getSendMail(Criteria cri);
	public List<EmailVO> getToMe(Criteria cri);
	
	
	public int getRcvTotal(String userid);
	public int getSndTotal(String userid);
	public int getToMetotal(String userid);
	public getCountDTO getCount(String userid);
	
	public void sendMail(EmailVO vo);
	public boolean deleteMail(Long eno);
	public EmailVO getMail(Long eno);
	
	
	public String sendDelCheck(Long eno);
	public boolean updateReceiveDel(Long eno);
	
	public String receiveDelCheck(Long eno);
	public boolean updateSendDel(Long eno);
	
	public boolean updateEmlRead(Long eno);

	public boolean deleteReadMail(String userid);
	
	


}

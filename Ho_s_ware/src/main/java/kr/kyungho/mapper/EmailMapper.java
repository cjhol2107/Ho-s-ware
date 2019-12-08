package kr.kyungho.mapper;

import java.util.List;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.EmailVO;

public interface EmailMapper {
	
	public List<EmailVO> getReceiveMail(Criteria cri);
	public List<EmailVO> getSendMail(Criteria cri);
	public List<EmailVO> getToMe(Criteria cri);
	
	
	public int getReceiveMailTotal(String userids);
	public int getSendMailTotal(String userid);
	public int getToMetotal(String userid);
	
	public void sendMail(EmailVO vo);
	public int deleteMail(Long eno);
	public int deleteSelected(Long eno);
	public EmailVO getMail(Long eno);
	
	public String sendDelCheck(Long eno);
	public int updateReceiveDel(Long eno);
	
	public String receiveDelCheck(Long eno);
	public int updateSendDel(Long eno);
	
	public int updateEmlRead(Long eno);
	public int cntUnread(String userid);
	
	public int deleteReadMail(String userid);
	
}

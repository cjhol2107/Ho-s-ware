package kr.kyungho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.EmailVO;
import kr.kyungho.domain.getCountDTO;
import kr.kyungho.mapper.EmailMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class EmailServiceImpl implements EmailService {

	@Setter(onMethod_=@Autowired)
	private EmailMapper mapper;
	
	@Override
	public List<EmailVO> getReceiveMail(Criteria cri) {
		
		log.info("getReceiveMail..."+cri);
		log.info("getReceiveMail..."+mapper.getReceiveMail(cri));
		return mapper.getReceiveMail(cri);
	}

	@Override
	public List<EmailVO> getSendMail(Criteria cri) {
		
		log.info("getSendMail..."+cri);
		log.info("getSendMail..."+mapper.getSendMail(cri));
		return mapper.getSendMail(cri);
	}

	@Override
	public void sendMail(EmailVO vo) {
		
		log.info("sendMail..."+vo);
		mapper.sendMail(vo);
		
	}

	@Override
	public boolean deleteMail(Long eno) {
		
		log.info("deleteMail..."+eno);
		return mapper.deleteMail(eno)==1;
	}

	@Override
	public String sendDelCheck(Long eno) {
		
		log.info("sendDelCheck..."+eno);
		String result = mapper.sendDelCheck(eno);
		log.info("result :"+result);
		return result;
	}

	@Override
	public boolean updateReceiveDel(Long eno) {
		
		log.info("updateReceiveDel..."+eno);
		return mapper.updateReceiveDel(eno)==1;
	}

	@Override
	public String receiveDelCheck(Long eno) {
		
		log.info("receiveDelCheck..."+eno);
		String result = mapper.receiveDelCheck(eno);
		log.info("result : "+result);
		return result;
	}

	@Override
	public boolean updateSendDel(Long eno) {
		
		log.info("updateSendDel..."+eno);
		return mapper.updateSendDel(eno)==1;
	}

	@Override
	public int getRcvTotal(String userid) {
		
		log.info("getRcvTotal..."+userid);
		return mapper.getReceiveMailTotal(userid);
	}

	@Override
	public int getSndTotal(String userid) {

		log.info("getSndTotal..."+userid);
		return mapper.getSendMailTotal(userid);
	}
	

	@Override
	public EmailVO getMail(Long eno) {
		
		log.info("getMail..."+eno);
		return mapper.getMail(eno);
	}

	@Override
	public List<EmailVO> getToMe(Criteria cri) {
		log.info("getToMe..."+cri);
		log.info("getToMe..."+mapper.getToMe(cri));
		return mapper.getToMe(cri);
	}

	@Override
	public int getToMetotal(String userid) {
		log.info("getToMetotal..."+userid);
		return mapper.getToMetotal(userid);
	}

	@Override
	public boolean updateEmlRead(Long eno) {
		log.info("updateEmlRead..."+eno);
		return mapper.updateEmlRead(eno)==1;
	}

	@Override
	public getCountDTO getCount(String user_id) {
		log.info("serviceimpl getcnt ... " + user_id);
		getCountDTO dto = new getCountDTO();
		dto.setRcvMailCnt(mapper.getReceiveMailTotal(user_id));
		dto.setUnreadRcvMailCnt(mapper.cntUnread(user_id));
		dto.setSntMailCnt(mapper.getSendMailTotal(user_id));
		dto.setToMeMailCnt(mapper.getToMetotal(user_id));
		
		return dto;
	}

	@Override
	public boolean deleteReadMail(String userid) {

		log.info("deleteReadMail..."+userid);
		return mapper.deleteReadMail(userid)==1;
	}




	

	

}

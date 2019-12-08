package kr.kyungho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kyungho.domain.ApprovalVO;
import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.MemberVO;
import kr.kyungho.domain.SignVO;
import kr.kyungho.domain.approverInfoVO;
import kr.kyungho.domain.getCountDTO;
import kr.kyungho.mapper.ApprovalMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ApprovalServiceImpl implements ApprovalService {

	@Setter(onMethod_=@Autowired)
	private ApprovalMapper mapper;
	
	@Override
	public List<ApprovalVO> getList(Criteria cri) {
		log.info("getList..."+cri);
		return mapper.getList(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get Total..."+cri);
		return mapper.getTotal(cri);
	}

	@Override
	public getCountDTO getCount(Criteria cri) {
		getCountDTO dto = new getCountDTO();
		dto.setApvCnt(mapper.getApvCnt(cri));
		dto.setCmpApvCnt(mapper.getCmpApvCnt(cri));
		dto.setYetApvCnt(mapper.getYetApvCnt(cri));
		dto.setPrcApvCnt(mapper.getPrcApvCnt(cri));
		dto.setFnlRejApvCnt(mapper.getFnlRejApvCnt(cri));
		return dto;
	}

	//결재등록
	@Override
	public void register(ApprovalVO approval) {
		log.info("register Approval.."+approval);
		mapper.insertSelectKey(approval);
		mapper.insertAno(approval.getApv_ano());
		approval.getAttachList().forEach(attach->{
			attach.setApv_ano(approval.getApv_ano());
			mapper.insert(attach);
		});
		approval.getSignList().forEach(sign->{
			sign.setApv_ano(approval.getApv_ano());
			mapper.insertSign_my(sign);
		});
		mapper.insert_apvInfo_mid(approval);
	}
	
	//중간결재
	@Override
	public void midApproval(ApprovalVO approval) {
		//comments, status update
		mapper.insertComments(approval);
		
		/*//결재자 테이블 update
		mapper.insert_apvInfo_mid(approval);*/
		
		//insert sign
		approval.getSignList().forEach(sign->{
			sign.setApv_ano(approval.getApv_ano());
			mapper.insertSign_manager(sign);
		});
	}
	
	@Override
	public ApprovalVO get(Long ano) {
		log.info("get approval..."+ano);
		return mapper.getApproval(ano);
		
	}

	@Override
	public List<AttachVO> getAttachList(Long ano) {
		log.info("get attach.. findByano..."+ano);
		return mapper.findByAno(ano);
	}
	
	@Override
	public List<SignVO> getSignList(Long ano) {
		log.info("findSignByAno..."+ano);
		return mapper.findSignByAno(ano);
	}

	@Override
	public String getSignFileName(String userid) {
		log.info("getSignFileName..."+userid);
		return mapper.getSignFileName(userid);
	}

	@Override
	public MemberVO getmidapprover(String userid) {
		log.info("getmidapprover..."+userid);
		return mapper.getmidapprover(userid);
	}

	@Override
	public void mid_reject(ApprovalVO approval) {
		log.info("mid_reject..."+approval);
		mapper.mid_reject(approval);
		mapper.insert_apvInfo_mid(approval);
		approval.getSignList().forEach(sign->{
			sign.setApv_ano(approval.getApv_ano());
			mapper.insertSign_manager(sign);
		});
	}

	@Override
	public approverInfoVO getMidInfo(Long apv_ano) {
		return mapper.getMidInfo(apv_ano);
	}

	@Override
	public void fnlApproval(ApprovalVO approval) {
		//comments, status update
		mapper.insertComments_final(approval);
		//결재자 테이블 update
		mapper.insert_apvInfo_final(approval);
		//insert sign
		approval.getSignList().forEach(sign->{
			sign.setApv_ano(approval.getApv_ano());
			mapper.insertSign_admin(sign);
		});
	}

	@Override
	public void fnl_reject(ApprovalVO approval) {
		mapper.fnl_reject(approval);
		mapper.insert_apvInfo_final(approval);
		//insert sign
		approval.getSignList().forEach(sign->{
			sign.setApv_ano(approval.getApv_ano());
			mapper.insertSign_admin(sign);
		});
	}

	@Override
	public void deleteApv(Long apv_ano) {
		
		mapper.delete_ApvInfo(apv_ano);
		mapper.delete_Sign(apv_ano);
		mapper.delete_Attach(apv_ano);
		mapper.delete_Approval(apv_ano);
		
	}
}

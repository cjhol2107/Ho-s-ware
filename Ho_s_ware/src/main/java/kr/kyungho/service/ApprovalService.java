package kr.kyungho.service;

import java.util.List;

import kr.kyungho.domain.ApprovalVO;
import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.MemberVO;
import kr.kyungho.domain.SignVO;
import kr.kyungho.domain.approverInfoVO;
import kr.kyungho.domain.getCountDTO;

public interface ApprovalService {

	//결재 리스트
	public List<ApprovalVO>getList(Criteria cri);
	public List<AttachVO> getAttachList(Long ano);
	public List<SignVO> getSignList(Long ano);
	
	//결재 등록
	public void register(ApprovalVO approval);
	
	//GET
	public String getSignFileName(String userid);
	public ApprovalVO get(Long ano);
	public MemberVO getmidapprover(String userid);
	
	//미결재,승인,반려,진행중 count
	public getCountDTO getCount(Criteria cri);
	public int getTotal(Criteria cri);
	
	//중간승인
	public void midApproval(ApprovalVO approval);
	public void mid_reject(ApprovalVO approval);
	
	//최종승인
	public approverInfoVO getMidInfo(Long apv_ano);
	public void fnlApproval(ApprovalVO approval);
	public void fnl_reject(ApprovalVO approval);
	
	//전자결재 삭제
	public void deleteApv(Long ano);
}

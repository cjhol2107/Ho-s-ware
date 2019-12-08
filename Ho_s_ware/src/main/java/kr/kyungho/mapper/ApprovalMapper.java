package kr.kyungho.mapper;

import java.util.List;

import kr.kyungho.domain.ApprovalVO;
import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.MemberVO;
import kr.kyungho.domain.SignVO;
import kr.kyungho.domain.approverInfoVO;

public interface ApprovalMapper {
	
	//결재리스트
	public List<ApprovalVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	
	//결재정보등록
	public void insertSelectKey(ApprovalVO apv);
	public void insert(AttachVO attach);
	public void insertAno(Long apv_ano);
	
	//sign 등록
	public void insertSign_my(SignVO vo);
	public void insertSign_manager(SignVO vo);
	public void insertSign_admin(SignVO vo);
	
	//미결재,승인,반려,진행중 카운트
	public int getYetApvCnt(Criteria cri);
	public int getApvCnt(Criteria cri);
	public int getCmpApvCnt(Criteria cri);
	public int getPrcApvCnt(Criteria cri);
	public int getFnlRejApvCnt(Criteria cri);
	
	//GET
	public ApprovalVO getApproval(Long ano);
	public List<AttachVO> findByAno(Long ano);
	public List<SignVO> findSignByAno(Long ano);
	public String getSignFileName(String userid);
	public MemberVO getmidapprover(String userid);
	
	//중간승인 및 반려
	public void insertComments(ApprovalVO approval);	
	public void insert_apvInfo_mid(ApprovalVO approval);
	public void mid_reject(ApprovalVO approval);
	
	//최종승인 및 반려
	public approverInfoVO getMidInfo(Long apv_ano);
	public void insertComments_final(ApprovalVO approval);
	public void insert_apvInfo_final(ApprovalVO approval);
	public void fnl_reject(ApprovalVO approval);
	
	//전자결재 삭제
	public void delete_ApvInfo(Long apv_ano);
	public void delete_Sign(Long apv_ano);
	public void delete_Attach(Long apv_ano);
	public void delete_Approval(Long apv_ano);
}

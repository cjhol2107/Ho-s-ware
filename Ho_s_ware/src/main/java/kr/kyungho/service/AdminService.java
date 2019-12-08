package kr.kyungho.service;

import java.util.List;

import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.MemberVO;


public interface AdminService {

	//사원 리스트
	public List<MemberVO>getList(Criteria cri);
	public int getTotal(Criteria cri); 
	
	//사원등록
	public void register(MemberVO member);

	//사원상세정보
	public MemberVO getMemberInfo(Long emp_num);
	public List<AttachVO> getPhoto(String userid);
	
	//사원정보수정
	public void updateMemberInfo(MemberVO member);
	
	//사원삭제
	public void deleteAll(MemberVO member);
	public String getUserId(Long emp_num);
}

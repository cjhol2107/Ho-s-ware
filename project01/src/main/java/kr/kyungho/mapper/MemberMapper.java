package kr.kyungho.mapper;

import java.util.List;

import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	public int idcheck(String userid);

	public List<MemberVO> getMemberList(Criteria cri);
	public int getTotalCount(Criteria cri);
	
	//사원정보등록(인적사항, 사진, 권한)
	public void insertMemberInfo(MemberVO member);
	public void insertMemberPhoto(AttachVO attach);
	public void insertMemberAuth(MemberVO member);
	
	//사원상세정보
	public MemberVO getMemberInfo(Long emp_num);
	public List<AttachVO> getPhoto(String userid);
	
	//사원정보수정
	public void updateMemberInfo(MemberVO member);
	
	//사원정보삭제
	public String getUserId(Long emp_num);
	public void deleteMemberAttach(MemberVO member);
	public void deleteMemberAuth(MemberVO member);
	public void deleteMember(MemberVO member);
	
	
}

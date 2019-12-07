package kr.kyungho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.MemberVO;
import kr.kyungho.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;

	@Override
	public List<MemberVO> getList(Criteria cri) {
		return mapper.getMemberList(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public void register(MemberVO member) {
		log.info("register member..."+member);
		mapper.insertMemberInfo(member);
		mapper.insertMemberAuth(member);
		member.getAttachList().forEach(attach->{
			attach.setUserid(member.getUserid());
			mapper.insertMemberPhoto(attach);
		});
		
		
	}

	@Override
	public MemberVO getMemberInfo(Long emp_num) {
		
		return mapper.getMemberInfo(emp_num);
	}

	@Override
	public List<AttachVO> getPhoto(String userid) {
		
		return mapper.getPhoto(userid);
	}

	@Override
	public void updateMemberInfo(MemberVO member) {

		mapper.updateMemberInfo(member);	
	}

	@Override
	public void deleteAll(MemberVO member) {
		
		mapper.deleteMemberAttach(member);
		mapper.deleteMemberAuth(member);
		mapper.deleteMember(member);

	}

	@Override
	public String getUserId(Long emp_num) {
		return mapper.getUserId(emp_num);
	}
	

}

package kr.kyungho.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.kyungho.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Override
	public int idcheck(String userid) {
		// TODO Auto-generated method stub
		log.info("impl: idcheck...."+userid);
		return mapper.idcheck(userid);
	}
	
	

}

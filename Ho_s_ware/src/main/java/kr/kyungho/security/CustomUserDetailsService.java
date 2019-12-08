package kr.kyungho.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.security.domain.CustomUser;

import kr.kyungho.domain.MemberVO;
import kr.kyungho.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

		log.warn("Load User By UserName : " + userName);

		// userName means userid
		
		MemberVO vo = memberMapper.read(userName);
		log.info(vo.getAuthList());

		log.warn("queried by member mapper: " + vo);

		return vo == null ? null : new CustomUser(vo);
	
	} 

}

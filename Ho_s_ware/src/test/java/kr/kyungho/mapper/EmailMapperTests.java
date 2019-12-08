package kr.kyungho.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.EmailVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class EmailMapperTests {
	
	@Setter(onMethod_= {@Autowired})
	private EmailMapper mapper;
	
	/*@Test
	public void testSendMail() {
		EmailVO vo = new EmailVO();
		vo.setEml_title("쪽지 테스트 제목");
		vo.setEml_content("쪽지 테스트 내용");
		vo.setEml_sndid("cjhol2107");
		vo.setEml_rcvid("user50");
		
		mapper.sendMail(vo);
	}
	
	@Test
	public void testDeleteMail() {
		
		Long eno = 131081L;
		mapper.deleteMail(eno);
		
	}
	
	
	@Test 
	public void testSendDelCheck() {
		Long eno=131061L;
		mapper.sendDelCheck(eno);
	}
	
	@Test 
	public void testReceiveDelCheck() {
		Long eno=131061L;
		mapper.receiveDelCheck(eno);
	}
	
	@Test
	public void testUpdateReceiveDel() {
		Long eno=131061L;
		mapper.updateReceiveDel(eno);
	}
	
	@Test
	public void testUpdateSendDel() {
		Long eno=131061L;
		mapper.updateSendDel(eno);
	}
	
	@Test
	public void testGetReceiveMail() {
		Criteria cri = new Criteria();
		cri.setUserid("cjhol2103");
		log.info("받은편지함: "+mapper.getReceiveMail(cri));
	}
	
	@Test
	public void testgetSendMail() {
		Criteria cri = new Criteria();
		cri.setUserid("cjhol2107");
		log.info("보낸편지함: "+mapper.getSendMail(cri));
		
	}
	
	@Test
	public void testGetMail() {
		Long eno=131061L;
		log.info(mapper.getMail(eno));
	}
	*/
	
	/*@Test
	public void testGetReceiveMailTotal() {
		Criteria cri = new Criteria();
		cri.setUserid("cjhol2107");
		log.info("getrcvtotal: "+mapper.getReceiveMailTotal(cri));
	}
	@Test
	public void testGetSendMailTotal() {
		Criteria cri = new Criteria();
		cri.setUserid("cjhol2107");
		log.info("getsndTotal: "+mapper.getSendMailTotal(cri));
	}*/
	/*@Test
	public void testGoStorage() {
		Long eno = 131144L;
		mapper.goStorage(eno);
	}*/
	
	@Test
	public void testCntUnread() {
		String id = "cjhol2107";
		log.info("cnt: "+mapper.cntUnread(id));
	}
	
	
	

}

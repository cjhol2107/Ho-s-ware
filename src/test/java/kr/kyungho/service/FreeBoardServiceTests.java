package kr.kyungho.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kyungho.domain.FreeBoardVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FreeBoardServiceTests {
	
	@Setter(onMethod_= {@Autowired})
	private FreeBoardService service;
	
	/*@Test
	public void testExit() {
		log.info(service);
	
	}
	
	@Test 
	public void testRegister() {
		
		FreeBoardVO board = new FreeBoardVO();
		board.setTitle("등록테스트02");
		board.setContent("등록테스트02");
		board.setWriter("등록테스트02");
		
		service.register(board);
		log.info("생성된 게시물 번호: "+board.getBno());
	}
	
	
	@Test
	public void testGetList() {
		
		service.getList().forEach(board->log.info(board));
	}
	
	/*@Test
	public void testRead() {
		
		log.info(service.get(18L));
	}
	
	
	@Test
	public void testModify() {
		FreeBoardVO board = new FreeBoardVO();
		board.setTitle("수정테스트02");
		board.setContent("수정테스트02");
		board.setWriter("수정테스트02");
		board.setBno(18L);
		
		log.info("result: "+service.modify(board));

	}
	
	
	@Test
	public void testDelete() {
		
		log.info("result: "+service.remove(18L));
		
	}*/
	
	
	
	
	
	
	

}

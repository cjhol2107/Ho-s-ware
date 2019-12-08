package kr.kyungho.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kyungho.domain.BoardLikeVO;
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
	
	*/
	/*@Test
	public void testModify() {
		FreeBoardVO board = new FreeBoardVO();
		board.setTitle("수정테스트!!");
		board.setContent("수정테스트!!");
		board.setBno(524407L);
		board.setWriter("user55");
		
		log.info("result: "+service.modify(board));

	}*/
	
	
	/*@Test
	public void testDelete() {
		
		log.info("result: "+service.remove(18L));
		
	}*/
	
	/*@Test
	public void testGetList() {
		
		Criteria cri = new Criteria();
		service.getList(cri).forEach(board->log.info(board));
	}*/
	
	/*@Test
	public void testgetBoardLike() {
		
		log.info("좋아요 수: "+service.getBoardLike(524408L));
	}*/
	/*@Test
	public void testinsertBoardLike() {
		BoardLikeVO vo = new BoardLikeVO();
		vo.setBno(524408L);
		vo.setUserid("cjhol2103");
	
		service.insertBoardLike(vo);
	}*/
	
	/*@Test
	public void testdeleteBoardLike() {
		BoardLikeVO vo = new BoardLikeVO();
		vo.setUserid("cjhol2107");
		vo.setBno(524408L);
		
		service.deleteBoardLike(vo);
	}*/
	
	/*@Test
	public void testupdateBoardLike() {
		log.info("before: "+service.getBoardLike(524408L));
		BoardLikeVO vo = new BoardLikeVO();
		vo.setUserid("cjhol2103");
		vo.setBno(524408L);
		service.insertBoardLike(vo);
		log.info("after: "+service.getBoardLike(524408L));
		
	}*/
	
	/*@Test
	public void testModify() {
		FreeBoardVO board = new FreeBoardVO();
		board.setTitle("수정테스트!!");
		board.setContent("수정테스트!!");
		board.setBno(524407L);
		board.setWriter("user55");
		
		log.info("result: "+service.modify(board));

	}*/
	
	
	
	

}

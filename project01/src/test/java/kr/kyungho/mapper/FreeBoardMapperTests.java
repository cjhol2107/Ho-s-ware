package kr.kyungho.mapper;

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
public class FreeBoardMapperTests {
	
	@Setter(onMethod_= {@Autowired})
	private FreeBoardMapper mapper;
	
	
	
	/*@Test
	public void testInsert() {
		FreeBoardVO board = new FreeBoardVO();
		board.setTitle("테스트제목01");
		board.setContent("테스트내용01");
		board.setWriter("테스트작성자01");
		
		mapper.insert(board);
		
		log.info("insert: "+board);
	}
	@Test
	public void testInserSelectKey() {
		FreeBoardVO board = new FreeBoardVO();
		board.setTitle("테스트제목02");
		board.setContent("테스트내용02");
		board.setWriter("테스트작성자02");
		
		mapper.insertSelectKey(board);
		
		log.info("insertSelectKey: "+board);
	}*/
	
	/*@Test
	public void testRead() {
		FreeBoardVO board = mapper.read(21L);
		log.info(board);
		
	}*/
	
	
	/*@Test
	public void testDelete() {
		int result = mapper.delete(16L);
		log.info("result.......... "+result);
	}
	
	
	@Test
	public void testUpdate() {
		
		FreeBoardVO board = new FreeBoardVO();
		
		board.setTitle("수정테스트제목01");
		board.setContent("수정테스트내용01");
		board.setWriter("수정테스트작성자01");
		
		board.setBno(5L);
		
		int result = mapper.update(board);
		log.info("result....."+result);
		
		
	}*/
	
	/*@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}*/
	
	/*@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("user50");
		cri.setType("W");
		
		List<FreeBoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board));
	}*/
	
	/*@Test
	public void testcreateBoardLike() {
		
		BoardLikeVO vo = new BoardLikeVO();
		vo.setBno(524408L);
		vo.setUserid("user45");
		
		mapper.createBoardLike(vo);
		
		
	}*/
	
	/*@Test
	public void testupdateBoardLike() {
		Long bno = 524408L;
		int result = mapper.updateBoardLike(bno);
		log.info("result: " +result);
	
	}*/
	/*@Test
	public void testdeleteBoardLike() {
		BoardLikeVO vo = new BoardLikeVO();
		vo.setBno(524408L);
		vo.setUserid("user45");
		
		mapper.deleteBoardLike(vo);
	}*/
	
	/*@Test
	public void testgetBoardLike() {
		int cnt=mapper.getBoardLike(524408L);
		log.info(cnt);
	}*/
	
	/*@Test
	public void testcheckLike() {
		BoardLikeVO vo = new BoardLikeVO();
		vo.setBno(524408L);
		vo.setUserid("cjhol2107");
	
		log.info("cnt: "+mapper.checkLike(vo));
	}*/
	
	/*@Test
	public void testUpdate() {
		
		FreeBoardVO board = new FreeBoardVO();
		
		board.setTitle("수정테스트제목01");
		board.setContent("수정테스트내용01");
		board.setWriter("수정테스트작성자01");
		
		board.setBno(5L);
		
		int result = mapper.update(board);
		log.info("result....."+result);
		
		
	}*/
	
	/*@Test
	public void testupdateBoardLike() {
		Long bno = 524408L;
		int result = mapper.updateBoardLike(bno);
		log.info("result: " +result);
	
	}*/

}

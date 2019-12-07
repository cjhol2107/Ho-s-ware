package kr.kyungho.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoard_ReplyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FreeBoard_ReplyMapperTests {
	
	private Long[] bnoArr = {524388L, 524387L, 524386L, 524385L, 524383L};
	
	@Setter(onMethod_=@Autowired)
	private FreeBoard_ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		
		log.info(mapper);
		
	}
	
	/*@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i->{
			FreeBoard_ReplyVO vo = new FreeBoard_ReplyVO();
			
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글 테스트"+i);
			vo.setReplyer("replyer"+i);
			
			mapper.insert(vo);
		});
	}*/
	
	/*@Test
	public void testRead() {
		
		Long rno = 5L;
		FreeBoard_ReplyVO vo = mapper.read(rno);
		log.info(vo);
		
		
	}*/
	
	/*@Test
	public void testDelete() {
		Long rno = 5L;
		mapper.delete(rno);
	}*/
	
	/*@Test
	public void testUpdate() {
		Long rno = 10L;
		FreeBoard_ReplyVO vo = mapper.read(rno);
		vo.setReply("UPDATE REPLY");
		mapper.update(vo);
		log.info("after: "+mapper.read(rno));
	}
	*/
	
/*	@Test
	public void testList() {
		Criteria cri = new Criteria();
		
		List<FreeBoard_ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply->log.info(reply));
	}*/
	
	
	

}

package kr.kyungho.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.kyungho.domain.ApprovalVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.EmailVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ApprovalMapperTests {
	
	@Setter(onMethod_= {@Autowired})
	private ApprovalMapper mapper;
	
	/*@Test
	public void TestInsertAll() {
		ApprovalVO vo = new ApprovalVO();
		vo.setApv_title("사인테스트제목");
		vo.setApv_kinds("업무");
		vo.setApv_userid("cjhol2107");
		vo.setApv_username("최경호");
		vo.setApv_dep_name("개발1팀");
		vo.setMidapprover("manager80");
		vo.setComments("테스트 결재부탁드립니다~");
		
		mapper.insertSelectKey(vo);
		log.info("insertSign before: "+vo);
		mapper.insertSign(vo.getApv_userid(), vo.getApv_ano());
	}*/
}

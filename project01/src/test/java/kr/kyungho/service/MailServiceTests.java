package kr.kyungho.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MailServiceTests {
	
	@Setter(onMethod_= {@Autowired})
	private EmailService service;

	@Test
	public void testGet() {
		//Long eno = 131026L;
		Long eno = 131025L;
		log.info(service.getMail(eno));
		
	}
}

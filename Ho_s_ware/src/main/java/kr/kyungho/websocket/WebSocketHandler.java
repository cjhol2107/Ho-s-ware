package kr.kyungho.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.kyungho.domain.Criteria;
import kr.kyungho.mapper.EmailMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class WebSocketHandler extends TextWebSocketHandler{
	
	@Setter(onMethod_ = { @Autowired })
	private EmailMapper mapper;
	
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

	}

	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

	
	}
	
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		log.info("handleTextMessage...");
		
		log.info(message.getPayload());
		String id = message.getPayload();
		int cntunread = mapper.cntUnread(id);
		log.info("cnt: "+cntunread);

		String cntString = Integer.toString(cntunread);
		session.sendMessage(new TextMessage(cntString));
	}

	





}

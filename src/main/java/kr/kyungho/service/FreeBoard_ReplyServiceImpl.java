package kr.kyungho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoard_ReplyVO;
import kr.kyungho.mapper.FreeBoard_ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FreeBoard_ReplyServiceImpl implements FreeBoard_ReplyService {

	
	@Setter(onMethod_=@Autowired)
	private FreeBoard_ReplyMapper mapper;
	
	@Override
	public int register(FreeBoard_ReplyVO vo) {
		
		log.info("register..."+vo);
		return mapper.insert(vo);
		
	}

	@Override
	public FreeBoard_ReplyVO get(Long rno) {
		log.info("get..."+rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(FreeBoard_ReplyVO vo) {
		log.info("modify..."+vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("remove..."+rno);
		return mapper.delete(rno);
	}

	@Override
	public List<FreeBoard_ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get Reply List..."+bno);
		return mapper.getListWithPaging(cri, bno);
	}

}

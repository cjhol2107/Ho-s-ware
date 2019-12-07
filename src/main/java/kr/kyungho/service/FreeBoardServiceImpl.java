package kr.kyungho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;
import kr.kyungho.mapper.FreeBoardMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Setter(onMethod_=@Autowired)
	private FreeBoardMapper mapper;

	@Override
	public FreeBoardVO get(Long bno) {
		log.info("get..."+bno);
		
		return mapper.read(bno);
	}

	@Override
	/*public List<FreeBoardVO> getList() {
		
		log.info("get List...");
		return mapper.getList();
	}*/
	public List<FreeBoardVO> getList(Criteria cri) {
		
		log.info("get List paging..."+cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public void register(FreeBoardVO board) {
		
		log.info("register..."+board);
		mapper.insertSelectKey(board);
		
	}

	@Override
	public boolean modify(FreeBoardVO board) {
		
		log.info("modify..."+board);
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(Long bno) {
		
		log.info("remove..."+bno);
		return mapper.delete(bno)==1;
		
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("get Total.......");
		return mapper.getTotalCount(cri);
	}
	
	
	
	

}

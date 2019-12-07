package kr.kyungho.service;

import java.util.List;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoard_ReplyVO;

public interface FreeBoard_ReplyService {

		public int register(FreeBoard_ReplyVO vo);
		
		public FreeBoard_ReplyVO get(Long rno);
		
		public int modify(FreeBoard_ReplyVO vo);
		
		public int remove(Long rno);
		
		public List<FreeBoard_ReplyVO> getList(Criteria cri, Long bno);
}

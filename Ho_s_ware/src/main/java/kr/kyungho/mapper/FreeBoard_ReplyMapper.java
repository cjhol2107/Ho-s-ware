package kr.kyungho.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoard_ReplyVO;

public interface FreeBoard_ReplyMapper {
	
	public int insert(FreeBoard_ReplyVO vo);
	
	public FreeBoard_ReplyVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(FreeBoard_ReplyVO reply);
	
	public List<FreeBoard_ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	
	public int getCountByBno(Long bno);

	public void updateReplyCnt(Long bno, int arg1);
	
	public int deleteAll(Long bno);
	

}

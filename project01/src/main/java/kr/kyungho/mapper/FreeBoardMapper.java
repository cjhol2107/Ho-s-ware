package kr.kyungho.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.kyungho.domain.BoardLikeVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;

public interface FreeBoardMapper {
	
	
	public List<FreeBoardVO> getList();
	
	public List<FreeBoardVO> getListWithPaging(Criteria cri); 
	
	public List<FreeBoardVO> getListMyPageWithPaging(Criteria cri);
	
	public void insert(FreeBoardVO board);
	
	public void insertSelectKey(FreeBoardVO board);
	
	public FreeBoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(FreeBoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	//조회수
	public int updateViews(Long bno);
	
	//추천수
	public int checkLike(BoardLikeVO vo);
	
	public void createBoardLike(BoardLikeVO vo);
	
	public int deleteBoardLike(BoardLikeVO vo);
	
	public int getBoardLike(Long bno);
	
	public void updateBoardLike(Long bno);
	
	public int getTotalMyPageCount(Criteria cri);
	
	public int deleteSelected(Long bno);
	
	public int deleteBoardLikeAll(Long bno);
	

}

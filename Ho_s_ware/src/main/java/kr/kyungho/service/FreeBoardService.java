package kr.kyungho.service;

import java.util.List;


import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.BoardLikeVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;

public interface FreeBoardService {
	
	public FreeBoardVO get(Long bno);
	
	public List<FreeBoardVO> getList(Criteria cri);
	
	public void register(FreeBoardVO board);
	
	public boolean modify(FreeBoardVO board);
	
	public boolean remove(Long bno);
	
	public List<AttachVO> getAttachList(Long bno);
	
	public int getTotal(Criteria cri);
	
	public int getTotalMyPage(Criteria cri);
	
	public List<FreeBoardVO> getMyPage(Criteria cri);
	
	public boolean updateViews(Long bno);
	
	//좋아요
	public int getBoardLike(Long bno);
	
	public int checkBoardLike(BoardLikeVO vo);
	
	public void insertBoardLike(BoardLikeVO vo);
	
	public void deleteBoardLike(BoardLikeVO vo);
	
	public boolean deleteSelected(Long bno);
	
	
	


}

package kr.kyungho.mapper;

import java.util.List;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;

public interface FreeBoardMapper {
	
	
	public List<FreeBoardVO> getList();
	
	public List<FreeBoardVO> getListWithPaging(Criteria cri); 
	
	public void insert(FreeBoardVO board);
	
	public void insertSelectKey(FreeBoardVO board);
	
	public FreeBoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(FreeBoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	

}

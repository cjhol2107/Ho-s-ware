package kr.kyungho.service;

import java.util.List;

import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;

public interface FreeBoardService {
	
	public FreeBoardVO get(Long bno);
	
	/*public List<FreeBoardVO> getList();*/
	public List<FreeBoardVO> getList(Criteria cri);
	
	public void register(FreeBoardVO board);
	
	public boolean modify(FreeBoardVO board);
	
	public boolean remove(Long bno);
	
	public int getTotal(Criteria cri);
	

}

package kr.kyungho.mapper;

import java.util.List;

import kr.kyungho.domain.AttachVO;

public interface BoardAttachMapper {
	
	//첨부파일의 수정이라는 개념은 존재하지 않기 때문에 insert, delete만
	public void insert(AttachVO vo);
	
	public void delete(String uuid);
	
	public List<AttachVO> findByBno(Long bno);
	//게시물의 번호로 첨부파일 찾는 작업
	
	public void deleteAll(Long bno);
	
	public List<AttachVO> getOldFiles();


}

package kr.kyungho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.kyungho.domain.AttachVO;
import kr.kyungho.domain.BoardLikeVO;
import kr.kyungho.domain.Criteria;
import kr.kyungho.domain.FreeBoardVO;
import kr.kyungho.mapper.BoardAttachMapper;
import kr.kyungho.mapper.FreeBoardMapper;
import kr.kyungho.mapper.FreeBoard_ReplyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Setter(onMethod_=@Autowired)
	private FreeBoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Setter(onMethod_=@Autowired)
	private FreeBoard_ReplyMapper replyMapper;

	@Override
	public FreeBoardVO get(Long bno) {
		log.info("get..."+bno);
		
		return mapper.read(bno);
	}

	public List<FreeBoardVO> getList(Criteria cri) {
		
		log.info("get List paging..."+cri);
		log.info("service...................."+mapper.getListWithPaging(cri));
		return mapper.getListWithPaging(cri);
	}
	
	@Transactional
	@Override
	public void register(FreeBoardVO board) {
		
		log.info("register..."+board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList()==null || board.getAttachList().size()<=0) {
			log.info("if문");
			return;
			
		}
		
		board.getAttachList().forEach(attach->{
			log.info("insert 전.................");
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}
	
	@Transactional
	@Override
	public boolean modify(FreeBoardVO board) {
		
		
		log.info("impl modify..."+board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board)==1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
		
	}

	@Override
	public boolean remove(Long bno) {
		
		log.info("remove..."+bno);
		
		attachMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
		
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get Total.......");
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getBoardLike(Long bno) {

		return mapper.getBoardLike(bno);
	}

	@Override
	public void insertBoardLike(BoardLikeVO vo) {

		mapper.createBoardLike(vo);
		mapper.updateBoardLike(vo.getBno());
	}

	@Override
	public void deleteBoardLike(BoardLikeVO vo) {

		mapper.deleteBoardLike(vo);
		mapper.updateBoardLike(vo.getBno());
	}


	@Override
	public int checkBoardLike(BoardLikeVO vo) {

		return mapper.checkLike(vo);
	}

	@Override
	public boolean updateViews(Long bno) {

		return mapper.updateViews(bno)==1;
	}

	@Override
	public List<AttachVO> getAttachList(Long bno) {

		log.info("get Attach list by bno"+bno);
		return attachMapper.findByBno(bno);
	}

	@Override
	public int getTotalMyPage(Criteria cri) {

		log.info("get total count");
		return mapper.getTotalMyPageCount(cri);
	}

	@Override
	public List<FreeBoardVO> getMyPage(Criteria cri) {
		
		log.info("impl cri: "+cri.getUserid());

		return mapper.getListMyPageWithPaging(cri);
		
	}

	@Override
	public boolean deleteSelected(Long bno) {
		
		log.info("remove..."+bno);
		
		//댓글,첨부,추천
		replyMapper.deleteAll(bno);
		attachMapper.deleteAll(bno);
		mapper.deleteBoardLikeAll(bno);
		return mapper.delete(bno)==1;
	
	}


}

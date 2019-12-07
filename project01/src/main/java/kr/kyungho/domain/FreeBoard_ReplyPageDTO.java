package kr.kyungho.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class FreeBoard_ReplyPageDTO {
	
	private int replyCnt;
	private List<FreeBoard_ReplyVO> list;
	


}

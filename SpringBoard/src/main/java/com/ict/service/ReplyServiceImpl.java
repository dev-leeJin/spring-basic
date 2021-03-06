package com.ict.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.domain.ReplyVO;
import com.ict.mapper.BoardMapper;
import com.ict.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{

	// 서비스가 매퍼를 호출하므로 매퍼를 위에 선언해야 합니다.
	@Autowired
	private ReplyMapper mapper;
	
	// 0502댓글쓰기시 board_tbl쪽에도 관여해야 하므로 board테이블을 수정하는 Mapper를 추가선언합니다. 
	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<ReplyVO> listReply(long bno) {
		return mapper.getList(bno);
	}

	@Transactional // 2개 이상의 DB접근 구문이 사용되면 트랜잭션 적용
	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
		// 댓글번호는 ReplyVO에 들어있으므로 getter를 활용
		boardMapper.updateReplyCount(vo.getBno(), 1); // 댓글이 추가되면 갯수 증가 
		
	}

	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
		
	}
	
	@Transactional
	@Override
	public void removeReply(Long rno) {
		// 글 삭제 전에 먼저 bno번을 채취하놓고
		Long bno = mapper.getBno(rno);
		// 다음 글 삭제해야 문제 없이 글 번호를 가져옵니다. 
		mapper.delete(rno);
		// DB에서 커밋 안하면 pending 상태로 계속 지연되니 주의 
		boardMapper.updateReplyCount(bno, -1); // 댓글이 추가되면 갯수 감소 
	}
}

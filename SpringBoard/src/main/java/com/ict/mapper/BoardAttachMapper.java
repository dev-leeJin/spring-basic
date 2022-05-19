package com.ict.mapper;

import java.util.List;

import com.ict.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	public void  insert(BoardAttachVO vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVO> findByBno(Long bno); // 특정 그림에 엮여있는 그림만 가져오기ㅣ. 
}

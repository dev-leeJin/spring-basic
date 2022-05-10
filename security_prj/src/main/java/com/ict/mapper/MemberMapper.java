package com.ict.mapper;

import com.ict.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userId); // select구문 id에 read연결, #{userId}에 변수 연결

}

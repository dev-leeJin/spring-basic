package com.ict.mapper;

import com.ict.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userId); // select구문 id에 read연결, #{userId}에 변수 연결
	
	//회원가입 로직 
	public void insertMemberTbl(MemberVO vo);  // 회원정보 기입
	public void insertMemberAuth(MemberVO vo); // 권한목록 기입 //MemberVO내부에 authList정보가 들어있음.
}

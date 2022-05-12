package com.ict.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.domain.MemberVO;
import com.ict.mapper.MemberMapper;

@Service
public class SecurityServiceImpl implements SecurityService {

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public void insertMember(MemberVO vo) { // 회원가입 로직 2개의 쿼리문이 가입로직이라는 하나의 동작으로 엮여있어야 하므로 둘 다 실행을 위해 insertMember으로 묶어서 생성
		mapper.insertMemberTbl(vo);
		
		mapper.insertMemberAuth(vo);
		
	}

}

package com.ict.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	
	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> auth) {
		super(username, password, auth);
	}
	
	// 유저 아이디, 유저 비밀번호, 유저권한은 무조건 customuser가 받도록 해줘야 한다. (핵심)
	public CustomUser(MemberVO vo) {
		super(vo.getUserId(), vo.getUserPw(), vo.getAuthList().stream().map(author ->
				new SimpleGrantedAuthority(author.getAuth()))
				.collect(Collectors.toList()));
		this.member = vo;
	}

}

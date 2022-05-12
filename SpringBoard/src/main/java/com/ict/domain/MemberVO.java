package com.ict.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO { //# 도메인은 보드, 리플라이, 유저 등으로 나눠서 쓰는게 좋음(실제로 적용할 때)
	
	private String userId;
	private String userPw;
	private String userName;  //아이디 비번 이름은 필수. 나머지 사항은 추가 하고 싶은 것 추가
	private boolean enabled;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;

}

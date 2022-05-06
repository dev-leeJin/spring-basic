package com.ict.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		
		// 로그인 성공시 어떤 권한인지 체크하기 위해 부여받은 권한(틀) 불러오기
		// ROLE_ADMIN의 경우는 ROLE_MEMBER가 부여되기때문에 경우에 따라 권한이 여럿일 수 있음
		log.warn("로그인 성공");
		List<String> roleList = new ArrayList<>();
		
		for (GrantedAuthority role : authentication.getAuthorities()) { //향상된 for문 형식으로 처리 (끝에 s가 붙으므로 모두 사용)
			roleList.add(role.getAuthority());
		}
		
		// roleList에 포함된 권한을 통해 로그인 계정의 권한에 따라 처리
		log.warn("부여받은 권한들 : " + roleList);
		if(roleList.contains("ROLE_ADMIN")) {
			response.sendRedirect("/secu/admin");
			return; // 메서드 종료후 return을 끝내지 않으면 밑에꺼까지 중복으로 들어갈 수 있음.
		}
		if(roleList.contains("ROLE_MEMBER")){
			response.sendRedirect("/secu/member");
			return;
		}
		response.sendRedirect("/");
	}

}

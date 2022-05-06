package com.ict.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("접근 거부 : " + auth);
		
		model.addAttribute("errorMessage", "접근 거부");
	}
	
	// security-context.xml에 작성된 customLogin이 여기에서 기능을 실행함
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error여부 : " + error);
		log.info("logout여부 : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "로그인 관련 에러입니다. 계정확인을 다시해주세요.");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃 했습니다.");
		}
	}
}

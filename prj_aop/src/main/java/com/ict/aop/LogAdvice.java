package com.ict.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect // import안되는 트러블 슈팅 해결 : ctrl+클릭으로 오류 추적 -> xml에서 runtime주석 처리로 해결(log4j처럼) 
@Log4j
@Component
public class LogAdvice {

	@Before("execution(* com.ict.service.SampleService*.*(..))") //()내부를 표현식이라고 부름. ->표현식에 해당하는 모든 메서드를 잡아서 적용
	public void logBefore() {									 // *을써서 접근제한자가 뭐가 됐든 적용-> .*은 메서드명 -> (..)파라미터
		log.info("==============");
	}
}

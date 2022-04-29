package com.ict.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect // import안되는 트러블 슈팅 해결 : ctrl+클릭으로 오류 추적 -> xml에서 runtime주석 처리로 해결(log4j처럼) 
@Log4j
@Component
public class LogAdvice {
	
	//@Befrom 예외가 터져도 발생 After 예외가 터지지 않아야 발생 Afterreturning 예외가 터져도 Ater로 발생
	@AfterReturning("execution(* com.ict.service.SampleService*.*(..))") //()내부를 표현식이라고 부름. ->표현식에 해당하는 모든 메서드를 잡아서 적용
	public void logBefore() {									 // *을써서 접근제한자가 뭐가 됐든 적용-> .*은 메서드명 -> (..)파라미터
		log.info("==============");
	}
	
														//doAdd가 붙어야만 실행.
	@Before("execution(* com.ict.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	// 예외가 발생했을 때만 발생하는 코드                                                           //모든 종류의 예외
	@AfterThrowing(pointcut = "execution(* com.ict.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		
		log.info("Exception....!!!!");
		log.info("exception: " + exception);
		
	}
	
	// Around는 메서드 실행 내내 실행되는 특이한 경우 (Before + Afrer = 이기 때문에 실행 전에 실행될 부분 실행부분 실행 후 부분으로 3개로 나뉜다)
	@Around("execution(* com.ict.service.SampleService*.*(..))")
						// 앞으로 실행될 메서드(pointcut)에 대한 정보를 pjp에 저장중
	public Object logTime(ProceedingJoinPoint pjp) { // Around와 ProceedingJoinPoint객체를 활용하면 파라미터와 예외 등등을 한 번에 처리
		
		long start =System.currentTimeMillis(); // 메서드 실행 직전 시간 저장
		
		log.info("Target: " + pjp.getTarget()); // 해당 메서드 명칭
		log.info("Param: " + Arrays.toString(pjp.getArgs())); // 해당 메서드 파라미터
		
		Object result =null;
		
		////////// 이전까지 핵심로직은 실행 안 됨//////////  여기까지 Before라고 생각하면 됌
		try {
			result = pjp.proceed(); // 핵심로직 실행
		////////// 핵심로직 실행 후 실행할 코드들//////////  여기서부터 After라고 생각하면 됌.
		}catch(Throwable e) {
			// 예외 발생시 실행
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis(); // 메서드 실행이 모두 끝난 직후 시간 저장
		
		log.info("TIME: " + (end -  start)); // 소요시간 계산해 로그에 찍기
		
		return result;
		//# 달리기로 예를 들었을 때 long start에서 스톱워치를 누르고 result 에서 달리고 long end에서 스톱워치 종료 느낌
	}
}

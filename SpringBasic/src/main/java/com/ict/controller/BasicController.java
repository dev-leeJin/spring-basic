package com.ict.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

// 어노테이션에 네 종류가 있었는데 (@Component, @Repository, @Controller, @Service)
// 컨트롤러를 만드는 경우이니 당연히 @Controller를 씁니다.
@Controller
public class BasicController {

	// RequsetMapping의 value는 localhost:8181/어떤주소로 접속시 해당 로직이 실행될지 결정합니다.
	// 아무것도 안 적으면 기본적으로 get방식을 허용합니다.
	@RequestMapping(value="/goA")
	// 아래에 해당 주소로 접속시 실행하고 싶은 메서드를 작성합니다.
	public String goA() {
		System.out.println("goA 접속이 감지되었습니다.");
		// return "goA";라고 적으면 views폴더 내부에 gaA.jsp파일을 보여줍니다.
		return "goA";
	}
	
	
	// /goB로 접속했을때 b.jsp 창이 열리도록 아래에 세팅해주세요.
	@RequestMapping(value="/goB")
	public String goB() {
		System.out.println("goB 접속이 감지되었습니다.");
		return "b";
	}
	
	
	//# 1.특정주소로 접속히 localhost:8181빼고 남은 주소를 인지
	// 2. 컨트롤러 내부에서 1에서 인지한 주소를 바탕으로 @RequestMapping의 value=/주소 와 매칭해서 연결되는 주소가 있는지 매칭해봄
	// 3. 인지된 라인의 가장 가까운 메서드를 실행
	// 4. 메서드 마지막 줄에 return부분의 문자열 이름을 참고해서 views폴더의 .jsp파일과 연동함.
	
	
	
	// 여러분들의 성함 성씨 기준(강사 기준 : "/chae")으로 패턴을 잡고
	// 결과 페이지는 "XXX의 페이지 입니다."라는 문장이 뜨도록 처리해서 메서드와 어노테이션을 저에게 보내세요.
	@RequestMapping(value="/lee")
	public String lee() {
		System.out.println("lee 접속이 감지되었습니다.");
		return "lee";
	}
	
	
	// 외부에서 전송하는 데이터는 메서드 선언부에 선언된 변수로 받습니다.
	// 이름만 일치하면 알아서 받아옵니다.
	// 자료형을 신경쓸 필요가 없습니다.
	@RequestMapping(value="/getData")
							// /getData?data1=데이터1&data2=데이터2 에 해당하는요소를 받아옵니다.
	public String getData(String data1, int data2) {
		//String data1 = request.getParameter("data1"); // jsp때 데이터를 받아오는 방법
		//int data2 = Integer.parseInt(strData2); // jsp에서 받아온 데이터를 다른 자료형으로 변환하는 방법
		System.out.println("data1에 든 값 : " + data1);
		System.out.println("data2에 든 값 : " + data2);
		System.out.println("data2가 정수임을 증명 : " + (data2+100));
		return "getResult";
		
		//# jsp에서는 변수를 받아올 때 Request.getparameter을 사용해서 복잡했고 무조건 문자형 String으로면 받아져서 
		// 정수형을 사용해야 할 때 문자형을 Integer.parseInt를 사용해 정수형으로 바꿨었는데 
		// 스프링에서는 자료형 조절이 가능하다. 
	}
	
	
	// 외부에서 전송하는 데이터를 /getMoney 주소로 받아오겠습니다.
	// 이 주소는 int won 이라는 형식으로 금액을 받아서
	// 환율에 따른 환전금액을 콘솔에 찍어줍니다. 환전화폐는 임의로 정해주세요.
	// 결과페이지는 exchange.jsp로 하겠습니다.
	// 메서드명은 임의로 만들어주세요.
	@RequestMapping(value="/getMoney")
	public String getMoney(int won) {
		System.out.println("입력한 금액은 " + won + "원입니다.");
		System.out.println("현재 캐나다 환율은 975.02원당 1달러입니다.");
		System.out.println("입력한 금액에 따른 환전금액은 " + (won/975.02) + "달러입니다.");
		return "exchange";
	}
	
	
	
}

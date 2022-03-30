package com.ict.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.protobuf.Method;

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
	@RequestMapping(value="/getData", method=RequestMethod.POST) //localhost:8181/getData
							// /getData?data1=데이터1&data2=데이터2 에 해당하는요소를 받아옵니다.
	public String getData(String data1, int data2, Model model){ 
		//String data1 = request.getParameter("data1"); // jsp때 데이터를 받아오는 방법
		//int data2 = Integer.parseInt(strData2); // jsp에서 받아온 데이터를 다른 자료형으로 변환하는 방법
		System.out.println("data1에 든 값 : " + data1);
		System.out.println("data2에 든 값 : " + data2);
		System.out.println("data2가 정수임을 증명 : " + (data2+100));
		// data1,data2 변수를 getResult.jsp로 보내서 위 콘솔메세지를 화면에서 조회가능하게 해주세요.
		model.addAttribute("data1",data1);
		model.addAttribute("data2",data2);
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
	@RequestMapping(value="/getMoney", method=RequestMethod.POST) // Post방식으로만 받도록 처리
						//1. 포워딩시 바인딩을 하고 싶다면 Model을 선언합니다. 
	public String getMoney(int won, Model model) {
		System.out.println("입력한 금액은 " + won + "원입니다.");
		System.out.println("현재 캐나다 환율은 975.02원당 1달러입니다.");
		System.out.println("입력한 금액에 따른 환전금액은 " + (won/975.02) + "달러입니다.");
		double result =(won/975.02);
		//2. model.addAttribute("보내이름", 보낼 자료);
		// 넘어간 데이터는 .jsp파일에서 el을 이용해 출력
		// ex-> model.addAttribute("test",자료); 로 바인딩한경우
		// $(test)로 .jsp에서 출력 가능
		model.addAttribute("result2",result);
		// won변수에 해당하는 변수도 추가로 보내보세요.
		model.addAttribute("moneymoney",won);
		// exchange.jsp를 타겟으로 하니 views폴데에 생성해주세요.
		return "exchange";
	}
	
	// form 페이지의 결과페이지를 분리해야 합니다.
	// 다만 목적지 주소가 .jsp기준이 아닌, @RequestMapping상의 주소기준으로 갑니다.
	// 주소 moneyForm으로 연결되도록 아래에 이노테이션 + 메서드를 구성해주세요.
	// moneyForm.jsp로 연결
	// moneyForm.jsp에는 목적지를 # 으로 하고
	// name=won 인 폼을 추가로 만들어주세요.
	
	// 1. @RequestMapping에 어떤 주소로 접속해야 하는지 적는다
	@RequestMapping(value="/moneyForm")
	// 2. public String 메서드() 를 만든다
	public String moneyFrom() {
		// 3. return구문 뒤에 연결할 .jsp파일의 이름을 적는다(확장자는 x)
		return "moneyForm";
	}
	
	
	// /dataForm을 감지해 dataForm.jsp로 보내주는 메서드를 만들어주세요.
	// data1, data2를 자료형에 맞게 폼으로 입력받아 전송버튼을 누르면
	// 해당 데이터가 결과 페이지에 나올 수 있도록 .jsp파일부터 시작해서
	// form태그나 세부 로직까지 완성시켜주세요.
	// 1. 주소 및 연결 메서드 완성 후 보내주시고
	// 2. 상단 /getData 주소를 타켓으로 하는 form태그 완성후 보내주세요.
	@RequestMapping(value="/dataForm")
	public String dataForm() {
		return "dataForm";
	}
	
	
	// 스프링 5버전부터 허용
	// @요청메서드Mapping은 해당 메서드만 허용하는 어노테이션입니다.
	@GetMapping(value="/onlyGet")
	public String onlyGet() {
		return "onlyGet";
	}
	
	
	
	// 성적을 입력하는 양식과 입력하고 제출버튼을 누르면 총점 및 평균을 보여주는 페이지를 제작
	// 조건: 모든 페이지의 접속주소는 /score입니다. 1. 성적 입력 폼 같은 경우 get방식 접근만 허용. 
	// 2. 성적 결과 페이지는 post방식 접근만 허용
	// 3. 폼에서는 수학, 영어, 언어, 사탐, 컴퓨터 과목의 성적을 각각 입력받도록 5개의 입력란이 있으며
	// name속성은 알아서 지정
	// 4. 목적지 페이지에서는 해당 5개과목의 성적을 받아서 total변수에 총점을 저장한 다음 바인딩
	// avg변수에 평균을 double로 저장한 다음 바인딩
	// 전달받은 5개 과목도 전부 바인딩해서
	// 5. 결과 페이지의 과목별성적, 총점, 평균점수를 띄워줍니다.
	
	// 성적 입력 폼 접근 로직
	@GetMapping(value="/score")
	public String scoreForm() {
		return "scoreForm";
	}
	
	@PostMapping(value="/score")
	public String scoreResult() {
		return "scoreResult";
	}
	
	
}

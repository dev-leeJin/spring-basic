package com.ict.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ict.domain.TestVO;

@RestController
// 클래스 위에 붙인 RequestMapping은 해당 컨트롤러의 공통된 진입주소를 설정해줍니다. 
@RequestMapping("/test")
public class TestController {

	// controller위에 /test가 붙여졌기 때문에 /hello전에 /test가 붙여져야함. (RequestMapping사용시_)
	@RequestMapping("/hello")
	public String sayHelllo() {
		return "Hello Hello";
	}
	
	@RequestMapping("/sendVO")
	public TestVO sendTestVO() {
		TestVO testVO = new TestVO();
		
		testVO.setName("이창훈");
		testVO.setAge(25);
		testVO.setMno(1);
		return testVO;
	}
	
	@RequestMapping("/sendVOList")
	public List<TestVO> sendVOList(){
		List<TestVO> list = new ArrayList<>();
		for(int i =0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "창훈");
			vo.setAge(25 + i);
			list.add(vo);
		}
		return list;
	}	
	
	@RequestMapping("/sendMap")
	public Map<Integer, TestVO> sendMap(){
		Map<Integer, TestVO> map = new HashMap<>();
		
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setName("이창훈");
			vo.setMno(i);
			vo.setAge(50 + i);
			map.put(i, vo);
		}
		return map;
	}
	
	// 의도적인 에러상황 만들기 (catch문에 많이 넣음)
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
		// ResponseEntity<Void> result=new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		// return result; 대체
		return
				new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		// return 다음 new를 쓰는걸 익명클래스라고 함
	}
	
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<TestVO>> sendListNot(){
		List<TestVO> list = new ArrayList<>();
		for(int i = 0; i < 10; i++) {
			TestVO vo = new TestVO();
			vo.setMno(i);
			vo.setName(i + "창훈");
			vo.setAge(25 + i);
			list.add(vo);
		}
		return
				new ResponseEntity<List<TestVO>>(list, HttpStatus.NOT_FOUND);
	}
}

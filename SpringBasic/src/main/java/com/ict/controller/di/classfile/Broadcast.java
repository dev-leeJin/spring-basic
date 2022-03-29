package com.ict.controller.di.classfile;

import org.springframework.stereotype.Component;

@Component
public class Broadcast {
	
	// 가수 -> 무대
	// 방송 -> 무대세팅, 가수
	// 의 의존 관계를 가진다. singer-> stage(singer) -> broadcast(stage(singer))
	// 방송이 무대에 의존하기 때문에
	// 1.BroadCast클래스를 만들고 Stage를 입력받아야만 생성가능하게 해주세요.
	private Stage stage;
	
	public Broadcast(Stage stage) {
		this.stage = stage;
	}
	// 2.Broadcast의 송출기능을 담당하는 onAir메서드는 "방송 송출중인 무대에서 가수가 노래를 합니다."라는 문장이 나오도록 세팅
	public void onAir() {
		System.out.print("방송 송출중인 ");
		this.stage.perform();
		
	}
	
	// 3.DiMainSpringver에서 Stage와 Singer를 건너뛰고 바로 Broadcast를 만들어서 세팅 후 실행
		
		
	
		
	

}
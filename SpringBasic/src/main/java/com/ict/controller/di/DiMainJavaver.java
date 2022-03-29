package com.ict.controller.di;

import com.ict.controller.di.classfile.Book;
import com.ict.controller.di.classfile.Library;
import com.ict.controller.di.classfile.Singer;
import com.ict.controller.di.classfile.Stage;

public class DiMainJavaver {

	public static void main(String[] args) {
		/*
		// 가수, 무대를 생성한 다음
		Singer singer = new Singer(); // Singer이 없으면 실행이 안됌. (stage가 singer에 의존한다.) 
		Stage stage = new Stage(singer);
		
		// 무대에 공연(perform)메서드를 호출해주세요.
		stage.perform();
		
		// 그냥 가수가 노래하는것도 가능한지 테스트
		singer.sing();
		*/
		// 기존 자바에서는 Book, Livrary를 둘 다 생성해야 실행 가능
		Book book = new Book();
		// Library library = new Library(book);// 생성자 주입이 가능할때는 생성하면서 book을 Library에 넣으면 됨
		Library library = new Library();
		library.setBook(book);
		library.browse();
		

	}

}
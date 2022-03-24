package com.ict.controller.di;

import com.ict.controller.di.classfile.Singer;
import com.ict.controller.di.classfile.Stage;

public class DiMainJavaver {

	public static void main(String[] args) {
		// ����, ���븦 ������ ����
		Singer singer = new Singer(); // Singer�� ������ ������ �ȉ�. (stage�� singer�� �����Ѵ�.) 
		Stage stage = new Stage(singer);
		
		// ���뿡 ����(perform)�޼��带 ȣ�����ּ���.
		stage.perform();
		
		// �׳� ������ �뷡�ϴ°͵� �������� �׽�Ʈ
		singer.sing();

	}

}

package com.ict.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j  // pom.xml에서 jinit 4.12로 , log4j는 1.2.17버전, exclusions 태그 삭제, scope주석 처리 해야 에러가 안뜸
public class UploadController {
	
	// uploadForm으로 접속하면 처리가 가능하도록 만들기.
	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload form");
	}
	
	// uploadFormPost 메서드 파라미터로 같은 이름인 uploadFile을 선언하면 그대로 받아오기.
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) { //MultipartFile을 선언하여 스프링이 파일을 인식.-> 파일 받아오기
		
		// 어떤 폴도에 저장할것인지 위치지정
		String uploadFolder =  "C:\\upload_data\\temp";
		
		for(MultipartFile multipartFile : uploadFile) { // 반목문 사용으로 업로드 파일에 들어있는 파일을 multipartFile에 담아둠.
			log.info("----------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename()); //자바의 File객체를 생성 
																						//-> 외부에 있던 파일을 자바 자료형으로 받아 어느 위치에 저장할지 
			
			try {
				multipartFile.transferTo(saveFile); // 파일 저장. //동일한 파일 존재시 덮어 씌움. 
			}catch(Exception e) {
				log.error(e.getMessage());
			}			
		} //end for
	}
	
	// ajax로 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
	}
	
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("ajax post update!");
		
		String uploadFolder = "C:\\upload_data\\temp";
		
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("===============================");
			log.info("Upload file name: " + multipartFile.getOriginalFilename());
			log.info("Upload file size: " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			log.info("last file name: " + uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}//end for
	}

}

package com.ict.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ict.domain.BoardAttachVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j  // pom.xml에서 jinit 4.12로 , log4j는 1.2.17버전, exclusions 태그 삭제, scope주석 처리 해야 에러가 안뜸
public class UploadController {
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			//이미지인지 아닌지 체크 
			return contentType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return false; // 이미지가 아니면 false
	}
	
	// 업로드되는 사진들을 날짜별로 구분
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		//yyyy-MM-dd에 날짜를 받아와서 폴더명으로 처리
		return str.replace("-", File.separator);
				
	}

	
	// uploadForm으로 접속하면 처리가 가능하도록 만들기.
	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload form");
	}
	
	// uploadFormPost 메서드 파라미터로 같은 이름인 uploadFile을 선언하면 그대로 받아오기.
	@PostMapping(value="/uploadFormAction",
				produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	//일반 컨트롤러에서 메서드 선언으로 레스트 방식을 쓸 수 있다. 
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> uploadFormPost(MultipartFile[] uploadFile) { //MultipartFile을 선언하여 스프링이 파일을 인식.-> 파일 받아오기
		
		//AttachFileDTO는 파일 한 개의 정보를 저장합니다.
		//현재 파일 업로드는 여러 파일을 동시에 업로드하므로 List<AttachFileDTO>를 받도록 처리합니다.
		List<BoardAttachVO> list = new ArrayList<>();
		
		// 어떤 폴도에 저장할것인지 위치지정
		String uploadFolder =  "C:\\upload_data\\temp";
		
		// 폴더 경로 받아오기
		String uploadFolderPath = getFolder();
		
		//폴더 생성
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
			
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		for(MultipartFile multipartFile : uploadFile) { // 반목문 사용으로 업로드 파일에 들어있는 파일을 multipartFile에 담아둠.
			log.info("----------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());
			
			//파일정보를 저장할 DTO 생성
			BoardAttachVO attachVO = new BoardAttachVO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("last file name: " + uploadFileName);
			
			//상단에 만든 DTO에 파일이름 저장
			attachVO.setFileName(uploadFileName);
			
			//uuid 발급 부분 // 같은 이름의 파일을 계속 업로드해도 정상 작동하게 만듬. (계속 uuid를 부여)
			UUID uuid= UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			//File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename()); //자바의 File객체를 생성 
			//File saveFile = new File(uploadPath, uploadFileName);	↓
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);	
				multipartFile.transferTo(saveFile); // 파일 저장. //동일한 파일 존재시 덮어 씌움.
				
				// uuid와 저장할 폴더 경로를 setter로 입력받기
				attachVO.setUuid(uuid.toString());
				attachVO.setUploadPath(uploadFolderPath);
				
				// 파일 업로드는 먼저 하고 업로드 된 파일이 이미지라면 썸네일을 만들어 다시 올리는 코드
				if(checkImageType(saveFile)) {
					attachVO.setFileType(true); 
					
					FileOutputStream thumbnail = 
							new FileOutputStream(
									new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(
							multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				// ArrayList에 개별 DTO를 집어넣어줘야 출력됨
				list.add(attachVO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}			
		} //end for
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	// ajax로 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
	}
	
	@PostMapping(value="/uploadAjaxAction",
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		log.info("ajax post update!");
		
		List<BoardAttachVO> list = new ArrayList<>();
		
		// 어떤 폴더에 저장할지 위치 지정
		String uploadFolder = "C:\\upload_data\\temp";
		
		String uploadFolderPath = getFolder();
		
		//폴더 생성
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
					
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("===============================");
			log.info("Upload file name: " + multipartFile.getOriginalFilename());
			log.info("Upload file size: " + multipartFile.getSize());
			
			//파일정보를 저장할 DTO 생성
			BoardAttachVO attachVO = new BoardAttachVO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			log.info("last file name: " + uploadFileName);
			
			//상단에 만든 DTO에 파일이름 저장
			attachVO.setFileName(uploadFileName);
			
			//uuid 발급 부분 // 같은 이름의 파일을 계속 업로드해도 정상 작동하게 만듬. (계속 uuid를 부여)
			UUID uuid= UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			//File saveFile = new File(uploadFolder, uploadFileName);
			//File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				// uuid와 저장할 폴더 경로를 setter로 입력받기
				attachVO.setUuid(uuid.toString());
				attachVO.setUploadPath(uploadFolderPath);
				
				
				if(checkImageType(saveFile)) {
					attachVO.setFileType(true);
					
					FileOutputStream thumbnail = 
							new FileOutputStream(
									new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(
							multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
			}
				
				// ArrayList에 개별 DTO를 집어넣어줘야 출력됨
				list.add(attachVO);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
			
			
		}//end for
		
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	// 업로드 된 날짜와 파일 이름이 입력되면 내부에 있는 파일을 자바 내부자료로 변환하고 정보를 리턴.  
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("fileName: " + fileName);
		// 자바 내부 자료로 변환 1. 파일 생성
		File file = new File("c:\\upload_data\\temp\\" + fileName);
		
		log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try { 
			// 2. json대신 파일을 줘야하는데 http방식 통신이므로 헤더를 생성
			HttpHeaders header = new HttpHeaders(); //임폴트는 스프링프레임워크의 httpheaders로 잡아야 함. 
			// 3. 컨텐츠 타임이 json이 아닌 파일임을 헤더에 명시
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			// 다른 유저가 파일을 다운받을수 있게 만듬.   4. ResponseEntity에 피일을 포함시켜서 전달 
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 업로드한 파일을 다운받게 하는 기능					// 다운받을 수 있도록 스트리밍 octet은 http방식으로 데이터를 주고받을 때 쪼개서 나누는 단위.
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		
		log.info("download file: " +fileName);
		// 다운받을 수 있도록 제공
		Resource resource = new FileSystemResource("C:\\upload_data\\temp\\" + fileName);
		
		log.info("resource: " + resource);
		
		String resourceName = resource.getFilename();
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			headers.add("Content-Disposition", "attachment; filename=" +
						new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
		}catch(UnsupportedEncodingException e) { //인코딩 지원이 안되는 것이 나오면 에러처리.
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK); 
	}
	// 파일 삭제버튼 적용
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		log.info("deleteFile: " + fileName);
		
		File file = null;
		
		try {
			// 자바내부로 정보 얻어오기
			file = new File("c:\\upload_data\\temp\\" + URLDecoder.decode(fileName, "UTF-8"));
			// 지워버리기
			file.delete();
			
			if(type.equals("image")) { // 타입이 이미지라면 썸네일과 일반파일 삭제
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: " +largeFileName);
				
				file = new File(largeFileName);
				
				file.delete();
			}
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	

}

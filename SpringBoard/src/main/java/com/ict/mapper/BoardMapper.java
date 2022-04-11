package com.ict.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ict.domain.BoardVO;

public interface BoardMapper {
	
	// board_tbl에서 글번호 3번 이하만 조회하는 쿼리문을
	// 어노테이션을 이용해 작성해주세요
	// @Select("SELECT * FROM board_tbl WHERE bno < 4")
	public List<BoardVO> getList(long pageNum);
	
	public void insert(BoardVO vo);
	
	// select구문은 글 번호를 입력받아서 해당 글 "하나" 에 대한 정보만 얻어올 예정이므로
	// 리턴자료형은 글 하나를 담당할 수 있는 BoardVO로 해야 함.
	public BoardVO select(long bno);
	
	// 글삭제는 DELETE구문으로 하는데 , 비 SELECT구문이므로 리턴자료를 void로 적습니다
	// 하나의 글만 삭제할 예정이므로, 삭제할 글 정보를 호출시 같이 입력하게 합니다. 
	public void delete(long bno);
	
	
	// 글 수정은 UPDATE 구문으로 합니다. 메서드를 선언해주세요.
	// 전달변수가 title, content, bno이므로, 단일 자료가 아닌 묶음으로 전달합니다.
	public void update(BoardVO vo);
	
	// vo안쓰고 데이터 전달하기
	// 2개이상의 파라미터를 따로따로 전달할때는 각 파라미터 왼쪽에 @Param을 붙여줍니다.
	public void update2(@Param("title") String title,
						@Param("content")String content,
						@Param("bno") long bno);
}

package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;

public interface BoardMapper { //DAO 대신에 사용할 수 있음, mybatis3.0부터 제공, DAO보다 편리함을 제공함
	
	//@Select("select * from tbl_board where bno > 0") //주의: 세미콜론 없이 sql문을 써야함
	//xml페이지에서 sql문 처리 했다면 해당 annnotation을 쓸 필요가 없음
	public List<BoardVO> getList();
	public void insert(BoardVO board);
	public void insertSelectKey(BoardVO board);
	public BoardVO read(Long bno);
	public int delete(Long bno);
	public int update(BoardVO board);
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	public void deleteAll(Long bno);
}

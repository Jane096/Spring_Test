package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;

public interface BoardMapper {
	
	@Select("select * from tbl_board where bno > 0") //주의: 세미콜론 없이 sql문을 써야함 
	public List<BoardVO> getList();
}

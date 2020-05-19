package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class BoardMapperTest {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로작성");
		board.setContent("새로작성내용");
		board.setWriter("testuser2");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test //@SelectKey를 이용하는 테스트 코드
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("select key 새로운 글");
		board.setContent("select key 새로운 내용");
		board.setWriter("testuser3");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
}

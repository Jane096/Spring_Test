package org.zerock.service;

import static org.junit.Assert.assertNotNull;

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
public class BoardServieTest {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	/*
	 * @Test public void testExists() { log.info(service); assertNotNull(service); }
	 */
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("비즈니스제목");
		board.setContent("비즈니스내용");
		board.setWriter("testUser4");
		
		service.register(board);
		log.info("생성된 게시물번호: " + board.getBno());
	}
	
	@Test
	public void testGetList() {
		service.getList().forEach(board -> log.info(board));
	}
	
	@Test 
	public void testGet() {
		log.info(service.get(1L));
	}
	
	@Test 
	public void testDelete() {
		log.info("Remove result: " + service.remove(2L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(1L);
		
		if(board == null) {
			return;
		}
		
		board.setTitle("제목수정!");
		log.info("Modify result: " + service.modify(board));
	}
}

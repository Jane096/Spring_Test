package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class})
@Log4j
public class ReplyMapperTest {
	
	//테스트 할 게시물 번호 목록
	private Long[] bnoArr = {55L, 53L};
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	/*
	 * @Test public void testCreate() { IntStream.rangeClosed(1, 10).forEach(i ->{
	 * ReplyVO vo = new ReplyVO();
	 * 
	 * //게시물 번호 vo.setBno(bnoArr[i%2]); vo.setReply("댓글테스트" + i);
	 * vo.setReplyer("replyer" + i);
	 * 
	 * mapper.insert(vo); }); }
	 */
	/*
	 * @Test public void testList() { Criteria cri = new Criteria(); List<ReplyVO>
	 * replies = mapper.getListWithPaging(cri, bnoArr[0]); replies.forEach(reply ->
	 * log.info(reply)); }
	 */
	/*
	 * @Test public void testRead() { Long targetRno = 27L;
	 * 
	 * ReplyVO vo = mapper.read(targetRno); log.info(vo); }
	 */
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(1, 10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 15L);
		replies.forEach(reply -> log.info(reply));
	}
}

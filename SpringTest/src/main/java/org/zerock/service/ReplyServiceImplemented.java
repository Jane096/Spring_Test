package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImplemented implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional //트랜잭션 처리
	@Override
	public int register(ReplyVO vo) {
		log.info("/register called");
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("/get called");
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("/modify called");
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("/remove called: " + rno);
		
		ReplyVO vo = mapper.read(rno); //해당 댓글의 게시물을 알아내는 과정이 필요함
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("ReplyList of current Board "+bno);
		return mapper.getListWithPaging(cri, bno);
	}

	/*
	 * @Override public ReplyPageDTO getListPage(Criteria cri, Long bno) {
	 * 
	 * return new ReplyPageDTO(mapper.getCountByBno(bno),
	 * mapper.getListWithPaging(cri, bno)); }
	 */

}
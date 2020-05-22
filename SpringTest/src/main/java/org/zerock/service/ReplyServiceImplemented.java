package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImplemented implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		log.info("/register called");
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

	@Override
	public int remove(Long rno) {
		log.info("/remove called: " + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("ReplyList of current Board "+bno);
		return mapper.getListWithPaging(cri, bno);
	}
}
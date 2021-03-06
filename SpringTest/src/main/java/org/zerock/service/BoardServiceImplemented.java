package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service //비즈니스 영역임을 표시 
//@AllArgsConstructor 두개를 받아야해서 setter로 처리 (autowired보단 권장하는 방식임)
public class BoardServiceImplemented implements BoardService{
	
	//해당 클래스가 잘 동작하려면 BoardMapper가 필요함
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("/register called: " + board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			log.info("failed");
			return;
		}
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("/get called: " + bno);
		
		return mapper.read(bno);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("/modify called: " + board);
		attachMapper.deleteAll(board.getBno());
		
		//board 글 업데이트 
		boolean modifyResult = mapper.update(board) == 1;
		
		//첨부파일 업데이트 
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("/remove called: " + bno);
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		log.info("/getList called");
		
		return mapper.getList();
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("/getAttachList w/ bno called: " + bno);
		return attachMapper.findByBno(bno);
	}
}
package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor //아니면 @Setter(onMethod_) 처리해서 생성자 만들어 주입 
public class BoardController {
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("/list called");
		model.addAttribute("list", service.getList());
	}
	
	@PostMapping("/register") 
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("==========================");
		log.info("/register called " + board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("==========================");
		service.register(board); 
		rttr.addFlashAttribute("result", board.getBno());
	  
	return "redirect:/board/list"; 
	  //등록 작업이 끝난 후 다시 목록화면으로 이동, response.sendRedirect()와 같은 개념
	  
	}
	
	@GetMapping("/register") //입력페이지 보여주기 용도 별도 처리x
	@PreAuthorize("isAuthenticated()") //로그인 성공한 사용자만 해당 기능 사용가능
	public void register() {
		  
	}
	 
	@GetMapping({"/get", "/modify"}) //조회는 특별한 경우가 아니면 get으로 함
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or /modify called");
		model.addAttribute("board", service.get(bno));
		
		//화면쪽으로 해당 번호의 게시물을 전달하기 때문에 Model을 parameter로 지정
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify: " + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list"; //수정 후 목록으로 이동
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("/deleteFiles() called");
		log.info(attachList + " will removed");
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\attach\\" + attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\attach\\" + attach.getUploadPath()+"\\s_" + attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				log.error("cannot delete" + e.getMessage());
			}
		});
	}
	
	@PreAuthorize("principal.username == #writer")
	@RequestMapping(value="/remove", method = {RequestMethod.GET, RequestMethod.POST})
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {
		log.info("/remove called" + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "삭제되었습니다");
		}
		return "redirect:/board/list";
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("/getAttachList called: " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
}

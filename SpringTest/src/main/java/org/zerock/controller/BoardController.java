package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
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
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("/register called" + board);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list"; 
		//등록 작업이 끝난 후 다시 목록화면으로 이동, response.sendRedirect()와 같은 개념
	}
	
	@GetMapping("/get") //조회는 특별한 경우가 아니면 get으로 함
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("/get called");
		model.addAttribute("board", service.get(bno));
		
		//화면쪽으로 해당 번호의 게시물을 전달하기 때문에 Model을 parameter로 지정
	}
}

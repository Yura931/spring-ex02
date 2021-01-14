package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController { // 컨트롤러는 서비스가 한 일을 모델에 옮겨닮는 일을 해야 함 
	private BoardService service;  // 얘를 파라미터로 받는 생성자 생성/ 컨트롤러는 서비스에게 일을 시켜야 함! 
	
	/*
	@Autowired
	public BoardController(BoardService service) {
		super();
		this.service = service;
	}
	*/
	
	// 211 page 표
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@GetMapping("/list")
	public void list(Model model) { // DispatcherServlet이 관리하도록 / jsp로 포워딩 당할 때 Model에 있는 Attribute들이 그대로 옮겨져가게 됨
		List<BoardVO> list = service.getList();
		model.addAttribute("list", list);
	}
	
//	@RequestMapping(value = "/register", method = ReqeuestMethod.POST)
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) { // 명시해주는 것 만으로 board가 가지고 있는 프로퍼티에 잘 담아줌
		
		/*
		BoardVO board = new BoardVO(); // 이 네줄의 코드를 39해의 파라미터를 넣어주므로 해결할 수 있다.
		board.setContent(request.getParameter("content"));
		board.setWriter(request.getPrameter("writer"));
		board.setTitle(request.getParameter("title"));
		*/
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno()); // redirect했을 때 한번 있다 사라 짐
		
		return "redirect:/board/list";
		
	}
	
	@GetMapping("/get")
	public void get() {
		
	}
	
	@PostMapping("/remove")
	public String remove() {
		return null;
	}
	
	@PostMapping("modify")
	public String modify() {
		return null;
	}
}

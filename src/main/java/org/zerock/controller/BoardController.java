package org.zerock.controller;

import java.util.List;


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
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
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
	
	@GetMapping("/register")
	public void register() {
		
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
		rttr.addFlashAttribute("message", board.getBno() + "번 글이 등록되었습니다.");
		
		
		/*
		addAttribute -> 쿼리스트링
		addFlashAttribute -> sessionattribute처럼? 객체를 보내 줌/ redirect한 순간에 딱 한 번만 사용할 수 있음, 새로고침하면 사라짐
		*/
		
		return "redirect:/board/list";
		
	}
	
	@GetMapping({"/get", "/modify"}) 
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("get method - bno: " + bno);
		BoardVO vo = service.get(bno);
		model.addAttribute("board", vo);
	}
	
	/*
	@GetMapping("/modify")
	public void modify(Long bno, Model model) {
		BoardVO vo = service.get(bno);
		model.addAttribute("board", vo);
	}
	*/
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", board.getBno() + "번 글이 수정되었습니다.");
		}
		
//		return "board/list"; // redirect하지 않고 board/list로 포워드 , 포스트로 요청이 온 후 적절하게 리다이렉트 해 줄 필요가 있다. 리다이렉트가 아닌 포워드로 요청이 된 경우 새로고침 했을 때 post요청이 한번 더 보내지게 됨
		return "redirect:/board/list";
	}
	
	@PostMapping("/modify2")
	public String modify2(BoardVO board, RedirectAttributes rttr) {
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addAttribute("bno", board.getBno());
			rttr.addFlashAttribute("message", board.getBno() + "번 글이 수정되었습니다.");
		}
		
		return "redirect:/board/get";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", bno + "번 글이 삭제되었습니다.");
		}
		
		System.out.println(bno);
		
		return "redirect:/board/list";
	}
	
	
}

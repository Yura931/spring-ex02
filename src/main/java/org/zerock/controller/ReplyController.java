package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController // 응답자체가 body가 됨
@RequestMapping("/replies")
@Log4j
@AllArgsConstructor 
public class ReplyController {
	
	private ReplyService service; // ReplyService타입의 bean은 ReplyServiceImpl 하나뿐이므로 자동으로 인젝션 됨
	 
	@PostMapping(value = "/new",
			consumes = MediaType.APPLICATION_JSON_VALUE, // "application/json" <- MediaType에 상수로 존재 consumes는 header의 Content-Type과 관련되어 있음
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) { // 상태코드도 함께 나타내기위해 ResponseEntity사용, 요청본문이 바로 ReplyVO가 될 수있도록 requestBody 어노테이션 사용
		
		log.info("vo: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("count: " + insertCount);
		
		if (insertCount == 1) { 
			return new ResponseEntity<>("success", HttpStatus.OK); // 성공시 상태코드를 성공으로 주면 됨
		} else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR); 
		}
	}
	
	@GetMapping(value = "/pages/{bno}/{page}", // Mapping어노테이션 값으로 변수 지정 / PathVariable 어노테이션에 Mapping에 지정한 변수와 동일한 이름을 갖는 파라미터를 추가하면 됨
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // pathvariable
	public ResponseEntity<List<ReplyVO>> getList(
			@PathVariable("page") int page, 
			@PathVariable("bno") Long bno) {
		
		Criteria cri = new Criteria(page, 10);
		List<ReplyVO> list = service.getList(cri, bno);
		
		log.info(list);
		
		return new ResponseEntity<List<ReplyVO>> (list, HttpStatus.OK); // list를 얻어와 응답본문 완성한 것을 리턴해주는 것
	}
	
	@GetMapping(value="/{rno}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) { // json은 날짜타입 없음, 숫자로 표현 됨
		ReplyVO vo = service.get(rno);
		
		log.info(vo);
		
		return new ResponseEntity<ReplyVO>(vo, HttpStatus.OK);
	}
	
	@DeleteMapping(value="/{rno}", // delete라는 메소드로 왔을 때 일을 시킬 것 , RequestMapping에 따라 만들어진 mapping이 있는데 delete역시 DeleteMapping이라는 어노테이션이 있음 / @DeleteMapping = method = RequestMethod.DELETE와 같은 것
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(
			@PathVariable("rno") Long rno) {
		
		int removeCount = service.remove(rno); // insert쿼리오 마찬가지로 영향을 미친 행의 갯수, 하나가 잘 지워지면 1이 return 됨 
		
		log.info(removeCount);
		
		if (removeCount == 1) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR); // 500번때의 상태코드 리턴
		}
		
	}
	
	@RequestMapping(value="/{rno}",
			method = {RequestMethod.PUT, RequestMethod.PATCH}, // put과 patch 메소드타입으로 요청이 왔을 경우 일을 시킴
			consumes = MediaType.APPLICATION_JSON_UTF8_VALUE, // json의 content 타입을 가지고 보냄
			produces = MediaType.TEXT_PLAIN_VALUE) // client에서 server로 json타입으로 데이터가 넘어 옴
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,
			@PathVariable Long rno) { // 본문이 body로 넘어오도록
		
		vo.setRno(rno);
		
		int modifyCount = service.modify(vo);
		
		log.info(modifyCount);
		log.info(vo);
		
		if (modifyCount == 1) {
			return new ResponseEntity<>("modify success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
	}
}

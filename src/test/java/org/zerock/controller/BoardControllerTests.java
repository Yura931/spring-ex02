package org.zerock.controller;

import static org.junit.Assert.*;


import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration //Dispatcher가 일 할 수 있도록 준비 시키는 것
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}) // 이 경로에서 빈도 만들고 디펜던시 인젝션도 일어남 
@Log4j
public class BoardControllerTests {  
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	// 우리가 일하는 환경은 interface ApplicationContext -> WebApplicationContext
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;	
	
	private MockMvc mockMvc; // 서버를 실행시키지 않아도 요청을 할 수 있도록, 서버대신에 요청을 날릴 수 있음, 테스트하기 전에 객체를 
	
	@Before // junit의 Before어노테이션을 사용하면 다른 메소드 실행 이전에 무조건 제일 먼저 실행될 수 있도록 한다.
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build(); // 인젝션으로 받은 webapplicationcontext를 파라미터로 넣어 얘를 활용해 build를 하라고 명령, servlet에게 요청을 날릴 수 있는 가짜 서버가 만들어짐 
	}
	
	@Test
	public void testExist() {
		assertNotNull(ctx);
		assertNotNull(mockMvc);
	}
	 
	@Test
	public void testList() throws Exception {
		ModelAndView mv = mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView();
		
		Map<String, Object> model = mv.getModel();
		Object o = model.get("list");
		
		String viewName = mv.getViewName();
		
		log.info(viewName + "###############################");
		assertNotNull(o);
		assertTrue(o instanceof List);
		assertNotEquals(((List) o).size(), 0);
	}
	
	/*
	@Test
	public void testRegister() throws Exception {
		int before = mapper.getList().size();
		
		ModelAndView result = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "테스트 새글 제목")
				.param("content", "테스트 새글 내용")
				.param("writer", "user00")) // 브라우저 흉내 submit버튼 누르는 행동을 대신 해주는 것
			.andReturn()
			.getModelAndView();
		
		int after = mapper.getList().size();
		
		assertEquals(before + 1, after);
		assertEquals("redirect:/board/list", result.getViewName());
		FlashMap map = result.getFlashMap();
		
	}
	*/
}

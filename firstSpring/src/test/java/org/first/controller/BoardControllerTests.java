package org.first.controller;

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

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration//Test for Controller
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
					"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {

	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before//모든 메서드가 실행되기 전에 Before가 먼저 실행됨.
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	@Test
	public void testListPaging() throws Exception{
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "1")
				.param("amount", "10"))
				.andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testRegister() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "title for Test register")
				.param("content", "content for Test register")
				.param("writer", "RegTestWriter")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	@Test
	public void testGet() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/board/get")
				.param("bno", "8"))
				.andReturn()
				.getModelAndView().getModelMap());
	} 
	
	@Test
	public void testModify() throws Exception {
		  String resultPage = mockMvc
				  .perform(MockMvcRequestBuilders.post("/board/modify")
						 .param("bno", "7")
						 .param("title", "modify title")
						 .param("content", "modify content")
						 .param("writer", "user01"))
				  .andReturn().getModelAndView().getViewName();
		  
		  log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "7"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
}

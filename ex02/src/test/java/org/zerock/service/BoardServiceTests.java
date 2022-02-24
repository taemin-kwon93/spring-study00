package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_ =@Autowired)
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("new Title");
		board.setContent("new Content");
		board.setWriter("new Writer");
		
		service.register(board);
		log.info("게시글의 번호: " + board.getBno());
	}
	
	@Test
	public void testGetList() {
		service.getList().forEach(board -> log.info(board));	
	}
	
	@Test
	public void testRead() {
		log.info(service.get(6L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(7L);
		
		if(board == null) {
			return;
		}
		
		board.setTitle("update Title");
		board.setContent("update Content");
		board.setWriter("update Writer");
		
		log.info("Modify Result: " + service.modify(board));
		
	}
}

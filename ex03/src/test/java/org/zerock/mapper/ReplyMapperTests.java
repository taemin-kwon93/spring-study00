package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	private Long[] bnoArr= {3932196L, 3932195L, 3932194L, 3932193L, 3932192L};
	
	@Test
	public void testMapper() {
	
	}
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트"+i);
			vo.setReplyer("Replyer"+ i);
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {
		Long targetBno = 5L;
		ReplyVO vo = mapper.read(targetBno);
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		Long targetRno = 3L;
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		Long targetRno = 2L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("update Reply");
		int count = mapper.update(vo);
		log.info("Update Count: " + count);
	}

	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(3, 10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 3934249L);
		replies.forEach(reply -> log.info(reply));
	}
}

package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)//test용으로 쓴다.
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")//설정정보는 file아래의 경로로 부터 얻는다.
@Log4j//기록한다.
public class HotelTests {
	
	@Setter(onMethod_ = {@Autowired})//의존성 주입
	private SampleHotel hotel;
	
	@Test//jUnit 상에서 단위테스트의 대상
	public void testExist() {
		assertNotNull(hotel);
		
		log.info(hotel);
		log.info("------------");
		log.info(hotel.getChef());
	}
}

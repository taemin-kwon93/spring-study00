package org.zerock.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Setter;

@Component
@Data
public class Restaurant {
	
	@Setter(onMethod_ = @Autowired)
	private Chef chef;//Restaurant는 Chef클래스를 주입받는다.
}

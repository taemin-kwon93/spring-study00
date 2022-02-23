package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@Component
@ToString
@Getter
@AllArgsConstructor//인스턴스 변수로 선언된 모든것을 파라미터로 받는 생성자를 작성.
public class SampleHotel2 {
	private Chef chef;
}

package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Component
@ToString
@Getter
@RequiredArgsConstructor//특정한 인스턴스변수에 대해서만 생성자를 작성.
public class SampleHotel3 {
	
	@NonNull
	private Chef chef;
}

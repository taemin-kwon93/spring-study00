package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Component
@ToString
@Getter
@Setter
public class SampleHotel {
	private Chef chef;
	public SampleHotel(Chef chef) {
		this.chef = chef;
	}
}

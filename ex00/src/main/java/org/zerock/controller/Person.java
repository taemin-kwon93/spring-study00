package org.zerock.controller;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class Person {
	
	private String name;
	private String age;
	private String height;

}

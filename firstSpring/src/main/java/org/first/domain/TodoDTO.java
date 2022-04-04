package org.first.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoDTO {
	
	private String title;
	/*
	 * @DateTimeFormat 어노테이션 적용시 SampleController에서는
	 * @initBinder 어노테이션이 필요 없다.
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dueDate;
}

package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class TodoDTO {

	private String title;
	//@DateTimeFormat(pattern = "yyyy/MM/dd")
	//위 어노테이션을 적용해줘도 InitBinder와 같은 역할을 얻을 수 있음.
	private Date dueDate;
}

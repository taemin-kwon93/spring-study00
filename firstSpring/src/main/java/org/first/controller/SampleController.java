package org.first.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

import org.first.domain.SampleDTO;
import org.first.domain.SampleDTOList;
import org.first.domain.TodoDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	
	@RequestMapping("test")
	public void test() {
		log.info("basic...........");
	}
	
	@GetMapping("/basic")
	public void test2() {
		log.info("basic2...........");
	}
	
	//요청이 들어온 이름에 맞게 jsp 페이지를 찾는다. viewResolver
	@GetMapping("/person")
	public void tomtom(SampleDTO dto, Model model) {
		log.info("나이 : " + dto.getAge());
		log.info("이름 : " + dto.getName());
		
		model.addAttribute("name", dto.getName());
	}
	
	@GetMapping("/person2")
	public String tomtom2(@RequestParam("age") int age, @RequestParam("name") String name) {
		SampleDTO dto = new SampleDTO();
		log.info("나이 : " + age);
		log.info("이름 : " + name);
		dto.setAge(age);
		dto.setName(name);
		
		return "/sample/person";
		// URL -> http://localhost/sample/person2?age=30&name=tom 
		// JSP -> /sample/person 요청에 맞춰 이동.
	}
	
	@GetMapping("/exList01")
	public String listSample(@RequestParam("id") String[] id) {
		for (int i = 0; i < id.length; i++) {
			log.info("id: " + id[i]);
		}
		 
		return "/sample/person";
	}
	
	@GetMapping("/exList02")
	public String listSample2(@RequestParam("id") ArrayList<String> id) {
		log.info("exList02_ id값 : " + id);
		return "/sample/person";
	}

	@GetMapping("/exList03")
	public String listSample2(SampleDTOList list) {
		log.info("exList03_ id값 : " + list.getList().toString());
		log.info("exList03_ id값 원문 : " + list);
		//exList03?list%5B0%5D.age=12&list%5B0%5D.name=12
		return "/sample/person";
	}
	
	/*
	 * @InitBinder public void initBinder(WebDataBinder binder) { SimpleDateFormat
	 * sdf = new SimpleDateFormat("yyyy-MM-dd");
	 * binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(sdf,
	 * false)); }
	 * 
	 * TodoDTO Class에 DateTimeFormat 어노테이션을 적용하고
	 * InitBinder를 주석처리 함.
	 * @DateTimeFormat(pattern = "yyyy-MM-dd")
	 * private Date dueDate;
	 */
	
	@GetMapping("/initExam")
	public String initExam(TodoDTO todo) {
		
		log.info("todo 내용: " + todo);
		return "/sample/person";
	}

	@GetMapping("/initExam2")
	public String initExam2(SampleDTO dto, @ModelAttribute("page") int page) {
		log.info("todo 내용: " + dto);
		log.info("page의 값은? -> " + page);
		return "/sample/person";
	}

	@GetMapping("/initExam3")
	public String initExam3(SampleDTO dto, @ModelAttribute("test") String test) {
		log.info("todo 내용: " + dto);
		log.info("test의 값은? -> " + test);
		
		RedirectAttributes rttr = new RedirectAttributesModelMap();
		rttr.addAttribute("dto", dto);
		return "redirect:/sample/person?" + "test=" + test;
	}
	
	@GetMapping("/initExam4")
	public @ResponseBody SampleDTO initExam4() {
		SampleDTO dto = new SampleDTO();
		dto.setAge(30);
		dto.setName("kwon");
		return dto; 
	}
	
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("/ex06......");

		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("kwon");

		return dto;
	}
	
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07() {
		log.info("/ex07......");
		String message = "{\"name\" : \"kwon\"}";
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(message, header, HttpStatus.OK) ;
	}
}

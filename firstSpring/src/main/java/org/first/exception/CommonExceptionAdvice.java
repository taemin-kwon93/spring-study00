package org.first.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	@ExceptionHandler(Exception.class)
	public String ex1(Exception ex, Model model) {
		log.error("Error_Message : " + ex.getMessage());
		model.addAttribute("except", ex);
		log.error(model);
		
		return "error_page1";//select error page
	}
	
	@ExceptionHandler(ArrayIndexOutOfBoundsException.class)
	public String ex2(ArrayIndexOutOfBoundsException ex, Model model) {
		log.error("Error_Message : " + ex.getMessage());
		model.addAttribute("except", ex);
		log.error(model);
		
		return "error_page2";//select error page
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String ex3(NoHandlerFoundException ex) {
		return "custom404";
	}
}

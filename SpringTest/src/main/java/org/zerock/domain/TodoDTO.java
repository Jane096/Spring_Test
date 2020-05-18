package org.zerock.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

//숫자와 문자열이 같이 전달된 경우 처리하는 방법 InitBinder(또는 DateTimeFormat)사용!

@Data
public class TodoDTO {
	private String title;
	
	@DateTimeFormat(pattern = "yyyy/MM/dd") //자꾸 null이 들어감...뭐징
	private Date dueDate;
}

package org.zerock.domain;

import lombok.Data;

//controller의 parameter 수집(request.getParameter 안해도됨)
@Data
public class SampleDTO {
	private String name;
	private int age;
}

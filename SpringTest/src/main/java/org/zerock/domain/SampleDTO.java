package org.zerock.domain;

import lombok.Data;

//controller의 parameter 수집(request.getParameter 안해도됨)
//Data annotation 사용하면 getter/setter, equals, toString이 자동생성되어 편리함 
@Data
public class SampleDTO {
	private String name;
	private int age;
}

package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

//Mapper 인터페이스
// - sql과 그에 대한 처리를 지정, mybatis-spring이 mapper를 xml과 어노테이션 형태로 생성시켜줌

public interface TimeMapper {
	@Select("select sysdate from dual")
	public String getTime();
	public String getTime2();
}

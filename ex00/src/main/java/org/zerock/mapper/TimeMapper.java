package org.zerock.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	@Select("select sysdate from dual")
	String getTime();
	String getTime2();
	
	@Insert("insert into \"member_test\" (MEMBER_NUM, MEMBER_NAME) values(2, 2)")
	String insertTest();
}

package com.ict.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class OracleConnectionPoolTest {
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	// SpringBasic복붙
	// 마이바티스트 연결만 확인하면됨. 다른거 하나하나 확인하고 간 이유는 히카리부터 배웠어야 됐기 때문임.
	@Test
	public void testMyBatis() {
		try(SqlSession session=sqlSessionFactory.openSession();
			Connection con = session.getConnection();){
			log.info("마이바티스 연결 시작!");
			log.info(session);
			log.info(con);
		}catch(Exception e) {
			fail(e.getMessage());
		}
	}
}

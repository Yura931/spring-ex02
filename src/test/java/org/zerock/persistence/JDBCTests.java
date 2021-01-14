package org.zerock.persistence;

import static org.junit.Assert.assertNotNull;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); // JDBCTests라는 클래스가 언급되면 , 로딩 되면 바로 실행이 된다. static때문에 항상 실행이 됨															  
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}
	@Test
	public void testConnection() {
		// local oracle
		/*
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "c##mydbms";
		String password = "admin";
		*/
		
		
		String url = "jdbc:oracle:thin:@db202101121103_high?TNS_ADMIN=/home/opc/wallet";
		String user = "admin";
		String password = "$dbfkDbfk1010$";
		
		
		try (
			Connection con = DriverManager.getConnection(url, user, password)
				) {
			assertNotNull(con);
		} catch (Exception e) {
			fail(e.getMessage());
			log.info(e);
		}
		
	}
}

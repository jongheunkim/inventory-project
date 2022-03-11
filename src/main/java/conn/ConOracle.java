package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class ConOracle {

	public static Statement dbconnect() throws Exception {
		/* 1. 드라이버연결
		 * 2. 연결메소드세팅
		 * 3. 연결정보의 인스턴스화
		 */
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		String username = "inventory";
		String userpass = "1234";
		
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection(url,username,userpass);
		Statement stmt = con.createStatement();

		return stmt;
	}
	
}


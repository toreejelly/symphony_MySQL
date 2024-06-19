package net.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBOpen {

	public Connection getConnection() {
		Connection con = null;
		try {
			String url = "jdbc:mysql://localhost:3306/lesson";
			String user = "root";
			String password = "1234";
			String driver = "com.mysql.cj.jdbc.Driver";
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			// out.println("오라클DB 서버 연결 성공");

		} catch (Exception e) {
			System.out.println("mysql DB 연결 실패 : " + e);
		}

		return con;
	}
	
}

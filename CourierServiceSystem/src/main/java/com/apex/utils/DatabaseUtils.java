package com.apex.utils;

import java.sql.*;

public class DatabaseUtils {
	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection connection = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/Apex", "root", "password");

		return connection;
	}
}

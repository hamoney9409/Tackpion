package thinkonweb.util;

import java.sql.*;
import javax.naming.*;
import javax.sql.DataSource;

public class ConnectionContext {
	private static String jndiName = "jdbc/mysql";
	private static Connection conn = null;
	
	private static final String ip = "192.168.174.129";
	private static final String port = "3306";
	private static final String dbname = "tackpion";
	
	public static Connection getConnection_old() 
	{
		if (conn != null) 
			return conn;
		
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://" + ip + ":" + port + "/" + dbname
					+ "?characterEncoding=UTF-8"
					, "root", "admin");
		} 
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		return conn;
	}
	
	public static Connection getConnection() 
	{
		if (conn!= null) 
			return conn;
		
		try 
		{
			Context initContext = (Context)new InitialContext().lookup("java:comp/env/");
			DataSource ds = (DataSource)initContext.lookup(jndiName);
			
			conn = ds.getConnection();
		} 
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		return conn;
	}
}

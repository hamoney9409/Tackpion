package thinkonweb.util;

import java.sql.*;
import javax.naming.*;
import javax.sql.DataSource;

public class ConnectionContext {
	private static String jndiName = "jdbc/mysql";
	private static Connection conn = null;
	
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

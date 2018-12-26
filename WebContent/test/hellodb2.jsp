<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<html>
	<body>
	<%
	Connection connection = null;
    Statement st = null;
    
	   String msg = "none";
       String sql;
       
       Class.forName("com.mysql.jdbc.Driver");
       connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/tackpion" , "root", "admin");
       st = connection.createStatement();

       sql = "SELECT 'hello jspbookdb!' AS msg";

       ResultSet rs = st.executeQuery(sql);
	   if (rs.next())
	      msg = rs.getString("msg");

       rs.close();
       st.close();
       connection.close();
	%>
	쿼리문: <%=sql%><br/>
	쿼리결과: <%=msg%><br/>
	</body>
</html>

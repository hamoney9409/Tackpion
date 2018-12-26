<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="thinkonweb.util.ConnectionContext" %>
<%@ page import="java.sql.*" %>

<% 
	String id = (String)session.getAttribute("loginId");
	boolean isLogin = false;
%>

<!DOCTYPE html>
	<html>
		<head>
		 <meta charset="utf-8">
		<title>Insert title here</title>
		</head>
	<body>
<% 
	do
	{
		
		if (id != null)
		{
			// 로그인 세션 남아있음
			isLogin = true;
			break;
		}
		
		id = request.getParameter("id");
		// 원래는 비밀번호를 해시 함수를 이용해서 암호화 시켜야  DB 해킹에서 회원들의 비밀번호를 보호할 수 있다.
		// 이 웹사이트를 실전에서 쓰고 싶다면 SHA-256을 검색해서 적용하도록 하자.
		// 그러나 본 SW융합설계 과목의 텀 프로젝트에서는 정보보호론 지식을 요구하지 않으므로
		// 시간상의 문제로 비밀번호의 암호화를 구현하지 않았다.
		String password = request.getParameter("password");
		if (id == null || password == null)
		{
			// 로그인 안함
%>
		<form method="post">
			ID : <input type="text" name="id"><br/>
			Password : <input type="password" name="password"><br/>
		<input type="submit" value="전송">
		
<%
			break;
		}
		
		// 로그인 시도
		Connection conn = ConnectionContext.getConnection();
		CallableStatement stmt = conn.prepareCall("{call SP_GET_ADMIN_INFO(?)}");
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		
		String correctPassword = null;
		int privileges;
		
		while (rs.next()) 
		{
			correctPassword = rs.getString("password");
			privileges = rs.getInt("privileges");
		}
		
		if (correctPassword == null)
		{
			// 계정이 없음
%>
		계정이 없다
<% 
			break;
		}
		if (!password.equals(correctPassword))
		{
			// 비번 틀림
%>
		비밀번호를 제대로 적지 못할까!
<% 
			break;
		}
		
		// 로그인 완료
		session.setAttribute("loginId", id);
		isLogin = true;
		
	} while(false);

	// 로그인 페이지
	if (isLogin)
	{
%>
		비밀번호를 제대로 적지 못할까!
<% 
	}
	
	// 여기서부터 관리자 페이지
%>
	</body>
</html>
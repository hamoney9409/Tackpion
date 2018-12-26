<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="thinkonweb.util.ConnectionContext" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<% 
	String id = (String)session.getAttribute("loginId");
	boolean isLogin = false;
	
	class Game
	{
		public int gameId;
		public int[][] playerScore = new int[2][4];
		public String[] playerName = new String[2];
		
		
		public int getPlayerSetScore(int playerNum)
		{
			int setScore = 0;
			for(int i = 0; i < playerScore[playerNum].length; i++)
			{
				int otherPlayerScore = 0;
				for(int j=0; j < playerScore.length; j++)
				{
					otherPlayerScore += playerScore[j][i];
				}
				
				otherPlayerScore -= playerScore[playerNum][i];
				
				if (otherPlayerScore < playerScore[playerNum][i])
				{
					setScore++;
				}
			}
			
			return setScore;
		}
		
	}
%>

<!DOCTYPE html>
	<html>
		<head>
			<meta charset="utf-8">
			<title>Insert title here</title>
		</head>
		<script type="text/javascript">

			function AjaxRequest(callback, url, callbackParams, urlParams)
			{
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() 
				{ 
					callback.apply(this, callbackParams);
				};
				xhttp.open("POST", url, true);
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhttp.send(urlParams.join('&'));
			}
			
		</script>
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
		</form>
		
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

	// 여기서부터 관리자 페이지
	if (isLogin)
	{
%>
		<%=id%> 님 환영합니다!<br/>
<% 
		Vector<Game> gamelist = new Vector<Game>(2);
	
		{
			Connection conn = ConnectionContext.getConnection();
			CallableStatement stmt = conn.prepareCall("{call SP_GET_UNDERWAY_GAMES_INFO()}");
			ResultSet rs = stmt.executeQuery();
			
			while (rs.next()) 
			{
				Game element = new Game();
				
				element.gameId = rs.getInt("id");
				element.playerName[0] = rs.getString("player1_name");
				element.playerName[1] = rs.getString("player2_name");
				element.playerScore[0][0] = rs.getInt("score1_p1");
				element.playerScore[0][1] = rs.getInt("score2_p1");
				element.playerScore[0][2] = rs.getInt("score3_p1");
				element.playerScore[0][3] = rs.getInt("score4_p1");
				element.playerScore[1][0] = rs.getInt("score1_p2");
				element.playerScore[1][1] = rs.getInt("score2_p2");
				element.playerScore[1][2] = rs.getInt("score3_p2");
				element.playerScore[1][3] = rs.getInt("score4_p2");
				
				gamelist.add(element);
			}
		}
	
		for(Game game : gamelist)
		{
			int[] setScore = new int[2];
			for(int i=0; i<setScore.length; i++)
			{
				setScore[i] = game.getPlayerSetScore(i);
			}
			
			int set = setScore[0] + setScore[1];
%>
		<span class="underway_game_<%= game.gameId %>">
		<%= game.playerName[0] %> : <span class="player1_score"><%= game.playerScore[0][set] %></span> 점 
		<button type="button" onclick="alert('Hello world!')">+</button>
		<br/>
		<span class="player1_setscore"><%= setScore[0] %></span> SET 
		<span class="player2_setscore"><%= setScore[1] %></span>
		<br/>
		<%= game.playerName[1] %> :  <span class="player2_score"><%= game.playerScore[1][set] %></span> 점 
		<button type="button" onclick="alert('Hello world!')">+</button>
		<br/>
		
		</span>
		<br/>
<% 
		}
%>
	<button type="button" onclick="alert('Hello world!')">새 경기 개설</button>
<%
	}
%>
	</body>
</html>
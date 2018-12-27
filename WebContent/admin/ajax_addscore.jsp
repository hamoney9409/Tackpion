<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="thinkonweb.util.ConnectionContext" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% 
	class Game
	{
		public int[][] playerScore = new int[2][4];
		
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
				
				if (otherPlayerScore < 11)
					continue;
				
				otherPlayerScore -= playerScore[playerNum][i];
				
				if (otherPlayerScore < playerScore[playerNum][i])
				{
					setScore++;
				}
			}
			
			return setScore;
		}
	}
	
	String id = (String)session.getAttribute("loginId");
	if (id == null)
	{
		return;
	}
	
	
	int gameId = -1;
	int player = -1;
	try
	{
		gameId = Integer.parseInt(request.getParameter("id"));
		player = Integer.parseInt(request.getParameter("player"));
	}
	catch(Exception e)
	{
		return;
	}

	Game game = new Game();
	{
		Connection conn = ConnectionContext.getConnection();
		CallableStatement stmt = conn.prepareCall("{call SP_GET_SCORE_OF_GAME(?)}");
		stmt.setInt(1, gameId);
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) 
		{
			game.playerScore[0][0] = rs.getInt("score1_p1");
			game.playerScore[0][1] = rs.getInt("score2_p1");
			game.playerScore[0][2] = rs.getInt("score3_p1");
			game.playerScore[0][3] = rs.getInt("score4_p1");
			game.playerScore[1][0] = rs.getInt("score1_p2");
			game.playerScore[1][1] = rs.getInt("score2_p2");
			game.playerScore[1][2] = rs.getInt("score3_p2");
			game.playerScore[1][3] = rs.getInt("score4_p2");
		}
	}

	int[] setScore = new int[2];
	for(int i=0; i<setScore.length; i++)
	{
		setScore[i] = game.getPlayerSetScore(i);
	}
	
	int set = setScore[0] + setScore[1];
	
	if (4 <= set)
		return;
	
	switch(player)
	{
	case 1:
		game.playerScore[0][set]++;
		break;
	case 2:
		game.playerScore[1][set]++;
		break;
	}
	
	int sum = game.playerScore[0][set] + game.playerScore[1][set];
	{
		Connection conn = ConnectionContext.getConnection();
		CallableStatement stmt = conn.prepareCall("{call SP_SET_SCORE(?,?,?,?,?,?)}");
		stmt.setString(1, id);
		stmt.setInt(2, gameId);
		stmt.setInt(3, set+1);
		stmt.setInt(4, game.playerScore[0][set] + game.playerScore[1][set]);
		stmt.setInt(5, game.playerScore[0][set]);
		stmt.setInt(6, game.playerScore[1][set]);
		stmt.execute();	
	}
	
	for(int i=0; i<setScore.length; i++)
	{
		setScore[i] = game.getPlayerSetScore(i);
	}
%>
<%=gameId%>,
<%=setScore[0]%>,
<%=setScore[1]%>,
<%=game.playerScore[0][set]%>,
<%=game.playerScore[1][set]%>


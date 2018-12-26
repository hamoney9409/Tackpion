<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import="thinkonweb.util.ConnectionContext" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<% 
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
%>
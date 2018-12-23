<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	for(Map.Entry<String,String[]> elem : request.getParameterMap().entrySet())
	{
		for (String value : elem.getValue())
		{
			out.println("key:"+elem.getKey() + ", value:" + value);
		}
	}
%>
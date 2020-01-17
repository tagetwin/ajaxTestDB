<%@ page import="db.beans.*, java.sql.*, java.util.*, java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="QueryBean" scope="page" class="db.beans.QueryBean" />
<jsp:setProperty property="*" name="QueryBean"/>
<%
	//캐쉬제거?
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("user_id") == null ? "999" : request.getParameter("user_id").trim();
	
	QueryBean.getConnection();
	
	int res = 0;

	try
	{
		//resArr = QueryBean.addUser(id);
		res = QueryBean.delUser(id);
	}
	catch(SQLException e)
	{
		System.out.print(e.toString());
	}
	finally
	{
		QueryBean.closeConnection();
	}
	
	out.println("[");
	out.println("{");
	out.println("\"RESULT_OK\": \"" + res + "\" ");
	out.println("} ");
	out.println("]");
	
	System.out.println("res: " + res);
%>

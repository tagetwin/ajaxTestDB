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
	
	String id, name, tel, grade, id2;
	id = request.getParameter("user_id") == null ? "" : request.getParameter("user_id").trim();
	//id2 = request.getParameter("id") == null ? "" : request.getParameter("id").trim();
	name = request.getParameter("user_name") == null ? "" : request.getParameter("user_name").trim();
	tel = request.getParameter("user_tel") == null ? "" : request.getParameter("user_tel").trim();
	grade = request.getParameter("user_grade") == null ? "" : request.getParameter("user_grade").trim();
	
	QueryBean.getConnection();
	
	int res = 0;
	
	try
	{
		res = QueryBean.addUser(id, name, tel, grade);
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

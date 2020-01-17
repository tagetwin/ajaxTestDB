package db.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class QueryBean
{
	Connection conn; // 연결 객체
	Statement stmt;  // 질의 객체
	ResultSet rs;    // 결과 객체
	
	public QueryBean()
	{
		conn = null;
		stmt = null;
		rs = null;
	}
	
	public void getConnection() // 연결하기
	{
		try
		{
			conn = DBConnection.getConnection();
		}
		catch (Exception e1)
		{
			e1.printStackTrace();
		}
		try
		{
			stmt = conn.createStatement();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	public void  closeConnection() //연결끊기
	{
		if (stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
		
		if (conn != null)
		{
			try
			{
				conn.close();
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	public ArrayList getUserInfo(String id) throws Exception
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append(" SELECT ");
		sb.append("		U_ID, U_NAME, U_PHONE, U_GRADE, WRITE_TIME ");
		sb.append(" FROM ");
		sb.append("		USER_INFO_SAMPLE ");
		sb.append(" WHERE ");
		sb.append(" U_ID LIKE '%" + id + "%'");
		sb.append("	ORDER BY ");
		sb.append("		WRITE_TIME ");
		sb.append(" DESC ");
		
		rs = stmt.executeQuery(sb.toString());
		
		ArrayList res = new ArrayList();
		while (rs.next())
		{
			res.add(rs.getString(1));
			res.add(rs.getString(2));
			res.add(rs.getString(3));
			res.add(rs.getString(4));
			res.add(rs.getString(5));
		}
		System.out.print(sb.toString());
		return res;
	}
	
	public int addUser(String id, String name, String tel, String grade) throws Exception
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append(" INSERT ");
		sb.append(" INTO ");
		sb.append("		USER_INFO_SAMPLE ");
		sb.append(" VALUES ");
		sb.append("('"+id+"', '"+name+"','"+tel+"','"+grade+"', sysdate)");
		
		
		System.out.println(sb.toString());
		
		int cnt = stmt.executeUpdate(sb.toString());
		
		System.out.println(cnt>0?cnt+" -성공":" -실패");
		return cnt;
	}
	
	public int updateUser(String id, String name, String tel, String grade) {
		int result =0;
		PreparedStatement pstmt = null;
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" UPDATE ");
		sb.append("		USER_INFO_SAMPLE ");
		sb.append(" SET ");
		sb.append(" 	U_NAME = ?, U_PHONE = ?, U_GRADE = ?, WRITE_TIME = sysdate ");
		sb.append(" WHERE ");
		sb.append(" 	U_ID ");
		
		System.out.println(sb.toString());
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.clearParameters();
			pstmt.setString(1, name);
			pstmt.setString(2, tel);
			pstmt.setString(3, grade);
			pstmt.setString(4, id);
			
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	public int delUser(String id) throws Exception
	{
		StringBuffer sb = new StringBuffer();
		
		sb.append(" DELETE ");
		sb.append(" FROM ");
		sb.append("		USER_INFO_SAMPLE ");
		sb.append(" WHERE ");
		sb.append(" U_ID= ");
		sb.append("('"+id+"')");
		
		
		System.out.println(sb.toString());
		
		int cnt = stmt.executeUpdate(sb.toString());
		
		System.out.println(cnt>0?cnt+" -성공":" -실패");
		
		return cnt;
	}
}


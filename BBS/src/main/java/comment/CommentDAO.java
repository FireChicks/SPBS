package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class CommentDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public CommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext() {
		String SQL = "SELECT comID FROM comment ORDER BY comID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String getContent(int comID) {
		String SQL = "SELECT comContent FROM comment WHERE comID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int write(int bbsID, String comContent, String userID) {
		String SQL = "INSERT INTO comment VALUE (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, comContent);
			pstmt.setString(3, getDate());
			pstmt.setString(4, userID);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, bbsID);					
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Comment> getList(int pageNumber, int bbsID) {
		String SQL = "SELECT * FROM comment WHERE comAvailable = 1 AND bbsID = " +  bbsID + " ORDER BY comDate DESC LIMIT 5 OFFSET ?";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Comment com = new Comment();
				com.setComID(rs.getInt(1));
				com.setComContent(rs.getString(2));
				com.setComDate(rs.getString(3));
				com.setUserID(rs.getString(4));
				com.setComAvailable(rs.getInt(5));
				com.setBbsID(rs.getInt(6));				
				list.add(com);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber, int bbsID) {
		String SQL = "SELECT * FROM comment WHERE comAvailable = 1 AND bbsID = " +  bbsID + " ORDER BY comDate DESC LIMIT 5 OFFSET ?";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Comment com = new Comment();
				com.setComID(rs.getInt(1));
				com.setComContent(rs.getString(2));
				com.setComDate(rs.getString(3));
				com.setUserID(rs.getString(4));
				com.setComAvailable(rs.getInt(5));
				com.setBbsID(rs.getInt(6));				
				list.add(com);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(list.size() == 5) {
			return true;
		}
		return false;
		
	}
	
	public int delete(int comID) {
		String SQL = "UPDATE comment SET comAvailable = 0 WHERE comID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comID);		
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int update(int comID, String comContent) {
		String SQL = "UPDATE comment SET comContent = ? Where comID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, comContent);
			pstmt.setInt(2, comID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}

package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public BbsDAO() {
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
	
	public int getNext() {
		String SQL = "SELECT bbsID  FROM BBS ORDER BY bbsID DESC";
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
	
	public int write(String bbsTitle, String userID, String bbsContent, String bbsTag, String bbsImagePath, String bbsImageRealPath, String bbsImageContent, String youtbueLink) {
		String SQL = "INSERT INTO BBS VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			pstmt.setString(7, bbsTag);
			pstmt.setString(8, bbsImageContent);	
			pstmt.setString(9, bbsImagePath);	
			pstmt.setString(10, bbsImageRealPath);
			pstmt.setString(11, youtbueLink);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10 OFFSET ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsTag(rs.getString(7));
				list.add(bbs);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber,String search,String searchText) {
		if(searchText.equals("")) {
			String SQL = "select * from bbs where bbsID < ? AND bbsAVailable = 1";
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10 );
				rs = pstmt.executeQuery();
				if (rs.next()) {
					return true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		ArrayList<Bbs> bbsList = null;
		bbsList = checkListSize((pageNumber-1), search, searchText);
		int size = bbsList.size() - ((pageNumber - 1) * 10);
		while(size > 0) {
			return true;
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "select * from bbs where bbsID = ? ";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbsTag(rs.getString(7));
				bbs.setBbsImageContent(rs.getString(8));
				bbs.setBbsImagePath(rs.getString(9));
				bbs.setBbsImageRealPath(rs.getString(10));
				bbs.setYoutubeLink(rs.getString(11));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String bbsTag, String bbsImagePath, String bbsImageRealPath, String bbsImageContent, String youtubeLink) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ?, bbsTag = ?, bbsImageContent = ?, bbsImagePath = ?, bbsImageRealPath = ?, youtubeLink = ? Where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, bbsTag);
			pstmt.setString(4, bbsImageContent);
			pstmt.setString(5, bbsImagePath);
			pstmt.setString(6, bbsImageRealPath);
			pstmt.setString(7, youtubeLink);
			pstmt.setInt(8, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);		
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> searchList(int pageNumber, String search, String searchText ) {				 	
		if(search.equals("bbsID")) {
			return searchByIDList(pageNumber, search,searchText ); 
		} else if(search.equals("bbsContent")) {
			return searchByTitleList(pageNumber, search,searchText );
		} else {
			return searchByContentList(pageNumber, search, searchText );
		} 		
	}
		
	
	public ArrayList<Bbs> searchByIDList(int pageNumber, String search, String searchText ) {				 	
			String SQL = " SELECT * FROM BBS WHERE "+ search +" = ? AND bbsAVailable = 1 ORDER BY bbsID DESC LIMIT 10 OFFSET ?";
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				 if(search.equals("bbsID")) {					 
					 int temp = Integer.parseInt(searchText); 
					 pstmt.setInt(1, temp);	 
				 }else {
					SQL = " SELECT * FROM BBS WHERE "+ search +" LIKE %?% AND bbsAVailable = 1 ORDER BY bbsID DESC LIMIT 10 OFFSET ?";					
					pstmt.setString(1, searchText);
				 } 
				 pstmt.setInt(2, (pageNumber - 1) * 10 );
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;
		}
	
	public ArrayList<Bbs> searchByTitleList(int pageNumber, String search, String searchText ) {				 	
		String SQL = " SELECT * FROM BBS WHERE "+ search +" LIKE ? AND bbsAVailable = 1 ORDER BY bbsID DESC LIMIT 10 OFFSET ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);			 				
			pstmt.setString(1, "%" + searchText + "%");	
			pstmt.setInt(2, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> searchByContentList(int pageNumber, String search, String searchText ) {				 	
		String SQL = " SELECT * FROM BBS WHERE "+ search +" LIKE ? AND bbsAVailable = 1 ORDER BY bbsID DESC LIMIT 10 OFFSET ?";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);			 				
			pstmt.setString(1, "%" + searchText + "%");
			 pstmt.setInt(2, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> checkListSize(int pageNumber, String search, String searchText) {				 	
			String SQL = " SELECT * FROM BBS WHERE "+ search +" LIKE ? AND bbsAVailable = 1 ORDER BY bbsID DESC";
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);			 				
				pstmt.setString(1, "%" + searchText + "%");
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;
	}
}

package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


public class FileDAO {
	private Connection conn;
	
	public FileDAO() {
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
	
	public int upload(String userProfilePath, String userProfile, String userID) {
		String SQL = "UPDATE user SET userProfilePath= ?, userProfile = ? Where userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userProfilePath);
			pstmt.setString(2, userProfile);
			pstmt.setString(3, userID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}

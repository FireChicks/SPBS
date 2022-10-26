package comment;

public class Comment {
	private int comID;
	private String comContent;
	private String comDate;
	private String userID;
	private int comAvailable;
	private int bbsID;
	public int getComID() {
		return comID;
	}
	public void setComID(int comID) {
		this.comID = comID;
	}
	public String getComContent() {
		return comContent;
	}
	public void setComContent(String comContent) {
		this.comContent = comContent;
	}
	public String getComDate() {
		return comDate;
	}
	public void setComDate(String comDate) {
		this.comDate = comDate;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getComAvailable() {
		return comAvailable;
	}
	public void setComAvailable(int comAvailable) {
		this.comAvailable = comAvailable;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
}

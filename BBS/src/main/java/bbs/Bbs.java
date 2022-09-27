package bbs;

public class Bbs {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private String bbsTag;
	private String bbsImageContent;
	private String bbsImagePath;
	private String bbsImageRealPath;
	private String youtubeLink;
	
	
	public String getYoutubeLink() {
		return youtubeLink;
	}
	public void setYoutubeLink(String youtubeLink) {
		this.youtubeLink = youtubeLink;
	}
	public String getBbsImageContent() {
		return bbsImageContent;
	}
	public void setBbsImageContent(String bbsImageContent) {
		this.bbsImageContent = bbsImageContent;
	}
	public String getBbsImagePath() {
		return bbsImagePath;
	}
	public void setBbsImagePath(String bbsImagePath) {
		this.bbsImagePath = bbsImagePath;
	}
	public String getBbsImageRealPath() {
		return bbsImageRealPath;
	}
	public void setBbsImageRealPath(String bbsImageRealPath) {
		this.bbsImageRealPath = bbsImageRealPath;
	}
	public String getBbsTag() {
		return bbsTag;
	}
	public void setBbsTag(String bbsTag) {
		this.bbsTag = bbsTag;
	}
	
	private int bbsAvailable;
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
}

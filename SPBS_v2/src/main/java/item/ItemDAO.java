package item;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import item.Item;

public class ItemDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ItemDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/SPBS";
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
		String SQL = "SELECT itemID  FROM item ORDER BY itemID DESC";
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
	
	public int write(Item item) {
		String SQL = "INSERT INTO item VALUE (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, item.getItemName());
			pstmt.setString(3, item.getItemContent());
			pstmt.setInt(4, item.getItemStock());
			pstmt.setInt(5, item.getItemPrice());
			pstmt.setString(6, item.getItemSeason());
			pstmt.setString(7, item.getItemContentImagePath());
			pstmt.setString(8, item.getItemContentImageRealPath());
			pstmt.setInt(9, 0);	
			pstmt.setInt(10, 1);	
			pstmt.setString(11, item.getItemBigCategory());
			pstmt.setString(12, item.getItemSmallCategory());
			pstmt.setInt(13, 0);
			pstmt.setString(14, item.getItemUnit());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int update(Item item, int itemID) {
		String SQL = "UPDATE item SET  itemName = ?, itemContent = ?, itemStock = ?, itemPrice = ?, itemSeason = ?, itemContentImagePath = ?, itemContentImageRealPath = ?, itemSale = ?, itemAvailable = ?, itemBigCategory = ?, itemSmallCategory = ?, itemSaleCount = ?, itemUnit = ? WHERE itemID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, item.getItemName());
			pstmt.setString(2, item.getItemContent());
			pstmt.setInt(3, item.getItemStock());
			pstmt.setInt(4, item.getItemPrice());
			pstmt.setString(5, item.getItemSeason());
			pstmt.setString(6, item.getItemContentImagePath());
			pstmt.setString(7, item.getItemContentImageRealPath());
			pstmt.setInt(8, item.getItemSale());	
			pstmt.setInt(9, item.getItemAvailable());	
			pstmt.setString(10, item.getItemBigCategory());
			pstmt.setString(11, item.getItemSmallCategory());
			pstmt.setInt(12, item.getItemSaleCount());
			pstmt.setString(13, item.getItemUnit());
			pstmt.setInt(14, itemID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public int deleteItem(int itemID) {
		String SQL = "DELETE FROM item WHERE itemID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, itemID);		
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int hideItem(int itemID) {
		String SQL = "UPDATE item SET itemAvailable = 0 WHERE itemID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, itemID);		
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int notHideItem(int itemID) {
		String SQL = "UPDATE item SET itemAvailable = 1 WHERE itemID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, itemID);		
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int maxPageNum() {
		String SQL = "select count(itemID) from item";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int num = rs.getInt(1);
				if(num % 10 == 0) {
					return num / 10; 
				} else {
					return num / 10 + 1;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public int maxPageNum(int pageNum, String search, String searchText) {
		String SQL = " SELECT count(*) FROM item WHERE "+ search +" LIKE ? ORDER BY itemID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		
			pstmt.setString(1, "%" + searchText + "%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int num = rs.getInt(1);
				if(num % 10 == 0) {
					return num / 10; 
				} else {
					return num / 10 + 1;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public boolean nextPage(int pageNumber,String search,String searchText) {
		if(searchText.equals("")) {
			String SQL = "select count(*) from item";
			ArrayList<Item> list = new ArrayList<Item>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					int num = rs.getInt(1);
					if(num > (pageNumber - 1) * 10) {
						return true;
					} else {
						return false;
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		ArrayList<Item> itemList = null;
		itemList = checkListSize((pageNumber-1), search, searchText);
		int size = itemList.size() - ((pageNumber - 1) * 10);
		while(size > 0) {
			return true;
		}
		return false;
	}
	
	public ArrayList<Item> checkListSize(int pageNumber, String search, String searchText) {				 	
		String SQL = " SELECT * FROM item WHERE "+ search +" LIKE ? ORDER BY itemID DESC";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);			 				
			pstmt.setString(1, "%" + searchText + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item bbs = new Item();
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public ArrayList<Item> searchByIDList(int pageNumber, String search, String searchText ) {				 	
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? ORDER BY itemID DESC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("bbsID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% ORDER BY itemID DESC LIMIT 10 OFFSET ?";					
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Item> searchByIDList(int pageNumber, String search, String searchText, boolean isDesc ) {				 	
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? ORDER BY itemID ASC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("itemID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {				
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% ORDER BY itemID ASC LIMIT 10 OFFSET ?";	
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Item> sortByIDList(int pageNumber, String search, String searchText, String sortBY) {				 	
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? ORDER BY "+ sortBY + " DESC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("itemID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% ORDER BY " + sortBY + " DESC LIMIT 10 OFFSET ?";					
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Item> sortByIDList(int pageNumber, String search, String searchText, String sortBY, boolean isDesc) {				 	
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? ORDER BY"+ sortBY + "ASC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("bbsID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% ORDER BY" + sortBY + "ASC LIMIT 10 OFFSET ?";					
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public ArrayList<Item> getList(int pageNumber) {
		String SQL = "SELECT * FROM item ORDER BY itemID DESC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Item> getList(int pageNumber, boolean isDesc) {
		String SQL = "SELECT * FROM item ORDER BY itemID ASC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Item> getList(int pageNumber, String sortBy) {
		String SQL = "SELECT * FROM item ORDER BY "+ sortBy + " DESC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Item> getList(int pageNumber, String sortBy, boolean isDesc) {
		String SQL = "SELECT * FROM item ORDER BY "+ sortBy + " ASC LIMIT 10 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10 );
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				list.add(item);
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Item getItem(int itemID) {
		String SQL = "SELECT * FROM item WHERE itemID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, itemID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Item item = new Item();
				item.setItemID(rs.getInt(1));
				item.setItemName(rs.getString(2));
				item.setItemContent(rs.getString(3));
				item.setItemStock(rs.getInt(4));
				item.setItemPrice(rs.getInt(5));
				item.setItemSeason(rs.getString(6));
				item.setItemContentImagePath(rs.getString(7));
				item.setItemContentImageRealPath(rs.getString(8));
				item.setItemSale(rs.getInt(9));
				item.setItemAvailable(rs.getInt(10));
				item.setItemBigCategory(rs.getString(11));
				item.setItemSmallCategory(rs.getString(12));
				item.setItemSaleCount(rs.getInt(13));
				item.setItemUnit(rs.getString(14));
				return item;
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}

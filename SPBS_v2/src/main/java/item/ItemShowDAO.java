package item;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import item.Item;
import parameter.ItemPageParameter;

public class ItemShowDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public ItemShowDAO() {
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
	
	public int bigCategoryCount() {
		String SQL = "select count(distinct itemBigCategory) from item WHERE itemAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
					return rs.getInt(1);				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public int smallCategoryCount(String bigCategory) {
		String SQL = "select count(distinct itemSmallCategory) from item WHERE itemAvailable = 1 AND itemBigCategory LIKE ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bigCategory);
			rs = pstmt.executeQuery();
			if(rs.next()) {
					return rs.getInt(1);				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public String bigCategorys() {
		String SQL = "select distinct itemBigCategory from item WHERE itemAvailable = 1";
		String categorys = "";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				categorys += rs.getString(1) + "#";				
			}
			categorys = categorys.substring(0, categorys.length() - 1);
			return categorys;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String smallCategorys(String bigCategory) {
		String SQL = "select distinct itemSmallCategory from item WHERE itemAvailable = 1 AND itemBigCategory LIKE ?";
		String categorys = "";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bigCategory);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				categorys += rs.getString(1) + "#";				
			}
			categorys = categorys.substring(0, categorys.length() - 1);
			return categorys;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	public int maxPageNum() {
		String SQL = "select count(itemID) from item WHERE itemAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int num = rs.getInt(1);
				if(num % 12 == 0) {
					return num / 12; 
				} else {
					return num / 12 + 1;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public int maxPageNum(int pageNum, String search, String searchText) {
		String SQL = " SELECT count(*) FROM item WHERE "+ search +" LIKE ? AND itemAvailable = 1 ORDER BY itemID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		
			pstmt.setString(1, "%" + searchText + "%");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int num = rs.getInt(1);
				if(num % 12 == 0) {
					return num / 12; 
				} else {
					return num / 12 + 1;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	public boolean nextPage(ItemPageParameter itemPara) {
		if(itemPara.isSearch()) {
			String SQL = "select count(*) from item WHERE itemAvailable = 1";
			ArrayList<Item> list = new ArrayList<Item>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					int num = rs.getInt(1);
					if(num > (itemPara.getPageNumber() - 1) * 12) {
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
		itemList = checkListSize(itemPara);
		int size = itemList.size() - ((itemPara.getPageNumber() - 1) * 12);
		while(size > 0) {
			return true;
		}
		return false;
	}
	
	public ArrayList<Item> checkListSize(ItemPageParameter itemPara) {				 	
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			String SQL = " SELECT * FROM item WHERE "+ itemPara.getSearch() +" LIKE ? AND itemAvailable = 1 ORDER BY itemID DESC";
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + itemPara.getSearchText() + "%");
			if(itemPara.isBigSort()) {
				SQL = " SELECT * FROM item WHERE "+ itemPara.getSearch() +" LIKE ? AND itemBigCategory LIKE ? AND itemAvailable = 1 ORDER BY itemID DESC";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + itemPara.getSearchText() + "%");
				pstmt.setString(2, itemPara.getItemBigCategory());
				if(itemPara.isSmallSort()) {
				SQL = " SELECT * FROM item WHERE "+ itemPara.getSearch() +" LIKE ? AND itemBigCategory LIKE ? AND itemSmallCategory LIKE ? AND itemAvailable = 1 ORDER BY itemID DESC";	
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, "%" + itemPara.getSearchText() + "%");
				pstmt.setString(2, itemPara.getItemBigCategory());
				pstmt.setString(3, itemPara.getItemSmallCategory());
				}
			}
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
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? AND itemAvailable = 1 ORDER BY itemID  DESC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("bbsID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% AND itemAvailable = 1 ORDER BY itemID DESC LIMIT 12 OFFSET ?";					
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 12 );
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
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? AND itemAvailable = 1 ORDER BY itemID ASC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("itemID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% AND itemAvailable = 1 ORDER BY itemID ASC LIMIT 12 OFFSET ?";					
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 12 );
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
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? AND itemAvailable = 1 ORDER BY "+ sortBY + " DESC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("itemID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% AND itemAvailable = 1 ORDER BY " + sortBY + " DESC LIMIT 12 OFFSET ?";					
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 12 );
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
		String SQL = " SELECT * FROM item WHERE "+ search +" = ? AND itemAvailable = 1 ORDER BY"+ sortBY + "ASC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			 if(search.equals("bbsID")) {					 
				 int temp = Integer.parseInt(searchText); 
				 pstmt.setInt(1, temp);	 
			 }else {
				SQL = " SELECT * FROM item WHERE "+ search +" LIKE %?% AND itemAvailable = 1 ORDER BY" + sortBY + "ASC LIMIT 12 OFFSET ?";					
				pstmt.setString(1, searchText);
			 } 
			 pstmt.setInt(2, (pageNumber - 1) * 12 );
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
		String SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY itemID DESC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 12 );
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
		String SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY itemID ASC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 12 );
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
		String SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY "+ sortBy + " DESC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 12 );
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
		String SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY "+ sortBy + " ASC LIMIT 12 OFFSET ?";
		ArrayList<Item> list = new ArrayList<Item>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 12 );
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
	
	public ArrayList<Item> getList(ItemPageParameter itemPara) {
		ArrayList<Item> list = new ArrayList<Item>();
		try {
		String SQL = "SELECT * FROM item WHERE itemAvailable = 1ORDER BY itemID DESC LIMIT 12 OFFSET ?";
		if(itemPara.isSearch()) { //search o
			SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?% ORDER BY itemID DESC LIMIT 12 OFFSET ?";			
			if(itemPara.isDesc()) {
				SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?% ORDER BY itemID DESC LIMIT 12 OFFSET ?";			
				if(itemPara.isSortBy()) {
					SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?% ORDER BY "+ itemPara.getSortBy() +" DESC LIMIT 12 OFFSET ?";
					if(itemPara.isBigSort()) {
						SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?% AND ItemBigCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" DESC LIMIT 12 OFFSET ?";

						if(itemPara.isSmallSort()) {
							SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?%  AND ItemBigCategory LIKE ?  AND ItemSmallCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" DESC LIMIT 12 OFFSET ?";			
						}
					}
				}
			} else {
				if(itemPara.isSortBy()) {
					SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?% ORDER BY "+ itemPara.getSortBy() +" ASC LIMIT 12 OFFSET ?";
					if(itemPara.isBigSort()) {
						SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?%  AND ItemBigCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" ASC LIMIT 12 OFFSET ?";						
						if(itemPara.isSmallSort()) {
							SQL = "SELECT * FROM item WHERE itemAvailable = 1 AND " + itemPara.getSearch() + " LIKE %?% AND ItemBigCategory LIKE ?  AND ItemSmallCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" ASC LIMIT 12 OFFSET ?";
													
						}
					}
				}			
			}				
		  } else { //search X
			  if(itemPara.isDesc()) {
				  	  SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY DESC LIMIT 12 OFFSET ?";
				  if(itemPara.isSortBy()) { //정렬O
					  SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY "+ itemPara.getSortBy() +" DESC LIMIT 12 OFFSET ?";
					  if(itemPara.isBigSort()) { //1차 카테고리
						  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" DESC LIMIT 12 OFFSET ?";
						  if(itemPara.isSmallSort()) { //2차 카테고리
							  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ?  AND ItemSmallCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" DESC LIMIT 12 OFFSET ?";	  
						  }
					  
					  }
				  } else {//정렬X
					  if(itemPara.isBigSort()) { //1차 카테고리
						  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ? ORDER BY itemID DESC LIMIT 12 OFFSET ?";
						  if(itemPara.isSmallSort()) { //2차 카테고리
							  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ?  AND ItemSmallCategory LIKE ? ORDER BY itemID DESC LIMIT 12 OFFSET ?";	  
					  
						  }					 
					  }	
				  }
			  } else {
				  	SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY ASC LIMIT 12 OFFSET ?";
				  if(itemPara.isSortBy()) { //정렬O
					  SQL = "SELECT * FROM item WHERE itemAvailable = 1 ORDER BY "+ itemPara.getSortBy() +" ASC LIMIT 12 OFFSET ?";
					  if(itemPara.isBigSort()) { //1차 카테고리
						  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" ASC LIMIT 12 OFFSET ?";
						  if(itemPara.isSmallSort()) { //2차 카테고리
						  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ?  AND ItemSmallCategory LIKE ? ORDER BY "+ itemPara.getSortBy() +" ASC LIMIT 12 OFFSET ?";  
						  }					 
					  }					  
				  } else { //정렬X
					  if(itemPara.isBigSort()) { //1차 카테고리
						  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ? ORDER BY itemID ASC LIMIT 12 OFFSET ?";
						  if(itemPara.isSmallSort()) { //2차 카테고리
							  SQL = "SELECT * FROM item WHERE itemAvailable = 1  AND ItemBigCategory LIKE ?  AND ItemSmallCategory LIKE ? ORDER BY itemID ASC LIMIT 12 OFFSET ?";		  
						  }					 
					  }	
				  }
			  }			  
		  }
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			if(itemPara.isSearch()) { //search o							
				pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
				pstmt.setString(1, itemPara.getSearchText());
				if(itemPara.isDesc()) {					
					pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
					pstmt.setString(1, itemPara.getSearchText());
					if(itemPara.isSortBy()) {												
						pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
						pstmt.setString(1, itemPara.getSearchText());
						if(itemPara.isBigSort()) {				
							pstmt.setInt(3, (itemPara.getPageNumber() - 1) * 12 );
							pstmt.setString(1, itemPara.getSearchText());
							pstmt.setString(2, itemPara.getItemBigCategory());
							if(itemPara.isSmallSort()) {							
								pstmt.setInt(4, (itemPara.getPageNumber() - 1) * 12 );
								pstmt.setString(1, itemPara.getSearchText());
								pstmt.setString(2, itemPara.getItemBigCategory());
								pstmt.setString(3, itemPara.getItemSmallCategory());						
							}
						}
					}
				} else {
					if(itemPara.isSortBy()) {
						pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
						pstmt.setString(1, itemPara.getSearchText());
						if(itemPara.isBigSort()) {				
							pstmt.setInt(3, (itemPara.getPageNumber() - 1) * 12 );
							pstmt.setString(1, itemPara.getSearchText());
							pstmt.setString(2, itemPara.getItemBigCategory());
							if(itemPara.isSmallSort()) {								
								pstmt.setInt(4, (itemPara.getPageNumber() - 1) * 12 );
								pstmt.setString(1, itemPara.getSearchText());
								pstmt.setString(2, itemPara.getItemBigCategory());
								pstmt.setString(3, itemPara.getItemSmallCategory());						
							}
						}
					}			
				}				
			  } else { //search X
				  if(itemPara.isDesc()) {					  	  
					  	  pstmt.setInt(1, (itemPara.getPageNumber() - 1) * 12 );
					  if(itemPara.isSortBy()) { //정렬O						
						  pstmt.setInt(1, (itemPara.getPageNumber() - 1) * 12 );
						  if(itemPara.isBigSort()) { //1차 카테고리
							  pstmt.setString(1, itemPara.getItemBigCategory());
							  pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
							  if(itemPara.isSmallSort()) { //2차 카테고리						  
								  pstmt.setString(1, itemPara.getItemBigCategory());
								  pstmt.setString(2, itemPara.getItemSmallCategory());
								  pstmt.setInt(3, (itemPara.getPageNumber() - 1) * 12 );								  
							  }
						  
						  }
					  } else {//정렬X
						  if(itemPara.isBigSort()) { //1차 카테고리							  
							  pstmt.setString(1, itemPara.getItemBigCategory());
							  pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
							  if(itemPara.isSmallSort()) { //2차 카테고리
								  pstmt.setString(1, itemPara.getItemBigCategory());
								  pstmt.setString(2, itemPara.getItemSmallCategory());
								  pstmt.setInt(3, (itemPara.getPageNumber() - 1) * 12 );	
							  }					 
						  }	
					  }
				  } else {
					  if(itemPara.isSortBy()) { //정렬O						  
						  pstmt.setInt(1, (itemPara.getPageNumber() - 1) * 12 );
						  if(itemPara.isBigSort()) { //1차 카테고리		
							  pstmt.setString(1, itemPara.getItemBigCategory());
							  pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
							  if(itemPara.isSmallSort()) { //2차 카테고리
							  pstmt.setString(1, itemPara.getItemBigCategory());
							  pstmt.setString(2, itemPara.getItemSmallCategory());
							  pstmt.setInt(3, (itemPara.getPageNumber() - 1) * 12 );
							  }					 
						  }					  
					  } else { //정렬X
						  if(itemPara.isBigSort()) { //1차 카테고리					  
							  pstmt.setString(1, itemPara.getItemBigCategory());
							  pstmt.setInt(2, (itemPara.getPageNumber() - 1) * 12 );
							  if(itemPara.isSmallSort()) { //2차 카테고리
								  		  
								  pstmt.setString(1, itemPara.getItemBigCategory());
								  pstmt.setString(2, itemPara.getItemSmallCategory());
								  pstmt.setInt(3, (itemPara.getPageNumber() - 1) * 12 );
							  }					 
						  }	
					  }
				  }			  
			  }
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

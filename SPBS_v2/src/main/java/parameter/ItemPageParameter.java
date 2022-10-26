package parameter;

public class ItemPageParameter {
	private int pageNumber;
	private boolean isSearch;
	private boolean isSortBy;
	private boolean isBigSort;
	private boolean isSmallSort;
	private boolean isDesc;
	private String itemBigCategory;
	private String itemSmallCategory;
	private String sortBy;
	private String search;
	private String searchText;
		
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public boolean isDesc() {
		return isDesc;
	}
	public void setDesc(boolean isDesc) {
		this.isDesc = isDesc;
	}
	public String getItemBigCategory() {
		return itemBigCategory;
	}
	public void setItemBigCategory(String itemBigCategory) {
		this.itemBigCategory = itemBigCategory;
	}
	public String getItemSmallCategory() {
		return itemSmallCategory;
	}
	public void setItemSmallCategory(String itemSmallCategory) {
		this.itemSmallCategory = itemSmallCategory;
	}
	public String getSortby() {
		return sortBy;
	}
	public void setSortBy(String sortBy) {
		this.sortBy = sortBy;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public boolean isSearch() {
		return isSearch;
	}
	public void setSearch(boolean isSearch) {
		this.isSearch = isSearch;
	}
	public boolean isBigSort() {
		return isBigSort;
	}
	public void setBigSort(boolean isBigSort) {
		this.isBigSort = isBigSort;
	}
	public boolean isSmallSort() {
		return isSmallSort;
	}
	public void setSmallSort(boolean isSmallSort) {
		this.isSmallSort = isSmallSort;
	}
	public String getSortBy() {
		return sortBy;
	}
	public boolean isSortBy() {
		return isSortBy;
	}
	public void setSortBy(boolean isSortBy) {
		this.isSortBy = isSortBy;
	}	
	
	
}

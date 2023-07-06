package com.kh.mw.vo;

import lombok.Data;

@Data
public class PagingDto {
	private int page = 1;
	private int startRow = 1;
	private int endRow = 10;
	private int startPage = 1;
	private int endPage = 10;
	private int totalPage;
	private int count;
	private int perPage = 10;
	private final int BLOCK_COUNT = 10;
	private String searchType;
	private String keyword;

	public void setPagingInfo(int page, int perPage, int count) {
		if(page > 0) {
			this.page = page;
		}
		this.perPage = perPage;
		this.count = count;
		
		this.page = page;
		this.endRow = page * perPage;
		this.startRow = this.endRow - (perPage - 1);
		
		this.startPage = ((page - 1) / BLOCK_COUNT) * BLOCK_COUNT + 1;
		this.endPage = this.startPage + (BLOCK_COUNT-1);
		
		this.count = count;
		this.totalPage = (int)Math.ceil((float)count / perPage);
		if(this.endPage > this.totalPage) {
			this.endPage = this.totalPage;
		}
	}
}

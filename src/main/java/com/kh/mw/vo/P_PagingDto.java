package com.kh.mw.vo;

import lombok.Data;

@Data
public class P_PagingDto {
	private int page = 1; // 현재 페이지
	private int startPage = 1; // 시작 페이지
	private int endPage = 10; // 마지막 페이지
	private int totalPage; // 총 페이지
	private int startRow = 1; // 시작 리스트 번호
	private int endRow = 10; // 마지막 리스트 번호
	private int count; // 총 리스트 수
	private int perPage = 12; // 한 페이지당 출력할 리스트 수
	private final int BLOCK_COUNT = 10; // 하단 페이지 버튼 갯수
	
	private int search_type; // 유형으로 검색
	private int search_region; // 지역으로 검색
	private String orderby; // 정렬	
	
	public void setPagingInfo(int page, int count) {
		this.page = page;
		this.count = count;
		
		this.endRow = page * perPage;
		this.startRow = this.endRow - (perPage-1);
		
		this.startPage = ((page-1)/BLOCK_COUNT) * BLOCK_COUNT + 1;
		this.endPage = startPage+(BLOCK_COUNT-1);
		
		this.totalPage = (int)Math.ceil((float)count/perPage); // 올림
		if (this.endPage > this.totalPage) {
			// ex)현재 페이지가 1페이지고 총 페이지가 3페이지인 경우 : 10>3
			// -> endPage = 3(3페이지까지만 표시)
			this.endPage = this.totalPage;
		}	
	}
}

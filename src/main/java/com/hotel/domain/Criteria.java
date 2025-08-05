package com.hotel.domain;

import lombok.Data;

@Data
public class Criteria {
	private int page;
	private int perPageNum;
	
	/**
	 * Criteria 생성자
	 * default page = 1, perPageNum(화면에 표시할 총 페이지 수) = 10
	 */
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	/**
	 * DB 쿼리에서 사용할 시작 페이지 번호 리턴
	 * return = 시작 페이지 번호
	 */
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	/**
	 * DB 쿼리에서 사용할 끝 페이지 번호 리턴
	 * return = 끝 페이지 번호
	 */
	public int getPageEnd() {
		return this.page * perPageNum;
	}
}

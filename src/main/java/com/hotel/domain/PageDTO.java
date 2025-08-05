package com.hotel.domain;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri;

	/**
	 * Criteria, total을 가지고 PageDTO를 생성
	 * param cri
	 * param total
	 */
	public PageDTO(Criteria cri, int total) {
	        this.cri = cri;
	        this.total = total;

	        // 끝 페이지
	        this.endPage = (int)(Math.ceil(cri.getPage() / 10.0)) * 10;
	        // 시작 페이지
	        this.startPage = this.endPage - 9;

	        // 실제 끝 페이지
	        int realEnd = (int)(Math.ceil((total * 1.0) / cri.getPerPageNum()));
	        // 실제 끝 페이지가 작다면 끝 페이지를 실제 끝 페이지로
	        if(realEnd < this.endPage) this.endPage = realEnd;

	        // 이전, 다음 버튼
	        this.prev = this.startPage > 1;
	        this.next = this.endPage < realEnd;
	    }
}

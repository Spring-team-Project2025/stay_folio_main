package com.hotel.service;

import java.util.*;
import com.hotel.domain.MemberVO;
import com.hotel.domain.Criteria;

public interface AdminService {
	
	/**
	 * 총 회원의 수를 반환
	 * 
	 * param cri (page, perPageNum) - page: 현재 페이지, perPageNum: 페이지당 보여주는 회원의 수
	 * return 총 회원의 수
	 */
	int getTotalMemberCount(Criteria cri);

	/**
	 * cri에 담겨진 조건에 맞는 회원의 목록을 반환
	 * 
	 * param cri (page, perPageNum) - page: 현재 페이지, perPageNum: 페이지당 보여주는 회원의 수
	 * return cri에 담겨진 조건에 맞는 회원의 목록
	 */
	List<MemberVO> getMemberList(Criteria cri);
}

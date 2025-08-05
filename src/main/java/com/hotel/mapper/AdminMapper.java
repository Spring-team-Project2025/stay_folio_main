package com.hotel.mapper;

import java.util.List;

import com.hotel.domain.Criteria;
import com.hotel.domain.MemberVO;

public interface AdminMapper {
	
	// cri에 담겨진 조건에 맞는 회원의 총 개수를 반환
	public int getTotalMemberCount(Criteria cri);

	// cri에 담겨진 조건에 맞는 회원의 목록을 반환
	List<MemberVO> selectMembersWithPaging(Criteria cri);
	
}


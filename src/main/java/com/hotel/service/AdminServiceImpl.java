package com.hotel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.Criteria;
import com.hotel.domain.MemberVO;
import com.hotel.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {
	 
	@Autowired
	private AdminMapper adminMapper;
	
	/**
	 * cri에 담겨진 조건에 맞는 회원의 총 개수를 반환
	 * 
	 * param cri page, perPageNum
	 * return 총 회원의 수
	 */
	@Override
	public int getTotalMemberCount(Criteria cri) {
	    return adminMapper.getTotalMemberCount(cri);
	}
	/**
	 * cri에 담겨진 조건에 맞는 회원의 목록을 반환
	 * 
	 * param cri page, perPageNum
	 * return cri에 담겨진 조건에 맞는 회원의 목록
	 */
	@Override
	public List<MemberVO> getMemberList(Criteria cri) {
	    return adminMapper.selectMembersWithPaging(cri);
	}
}
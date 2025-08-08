package com.hotel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.Criteria;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.MemberVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationStatsDTO;
import com.hotel.domain.StayVO;
import com.hotel.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;

	@Override
	public int getTotalMemberCount(Criteria cri) {
		return adminMapper.getTotalMemberCount(cri);
	}

	@Override
	public List<MemberVO> getMemberList(Criteria cri) {
		return adminMapper.selectMembersWithPaging(cri);
	}

	@Override
	public List<RecommendCategoryVO> getAllCategoryTopDetails() {
		return adminMapper.getAllCategoryTopDetails();
	}

	@Override
	public List<RecommendCategoryVO> getRecommendKeyword() {
		return adminMapper.getRecommendKeyword();
	}

	@Override
	public ReservationStatsDTO getReservationStats() {
		return adminMapper.getReservationStats();
	}
	
	@Override
	public Map<String, Integer> getMemberVsGuestRatio() {
		Map<String, Integer> result = adminMapper.getMemberVsGuestRatio();
		return result;
	}

	@Override
	public double getReservationCancelRate() {
		return adminMapper.getReservationCancelRate();
	}

	@Override
	public List<LocationCategoryVO> getStayCountByRegion() {
		return adminMapper.getStayCountByRegion();
	}
	
	@Override
	public List<StayVO> getTopReservedStays() {
	    return adminMapper.getTopReservedStays();
	}

	@Override
	public List<StayVO> getTopBookmarkedStays() {
		return adminMapper.getTopBookmarkedStays();
	}
	
	@Override
	public int getTotalReservationCount(Criteria cri) {
		return adminMapper.getTotalReservationCount(cri);
	}
	
	@Override
	public List<ReservationDetailVO> getReservationList(Criteria cri) {
		return adminMapper.getReservationList(cri);
	}
}
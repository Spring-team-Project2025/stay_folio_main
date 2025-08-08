package com.hotel.mapper;

import java.util.List;
import java.util.Map;

import com.hotel.domain.Criteria;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.MemberVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationStatsDTO;
import com.hotel.domain.StayVO;

public interface AdminMapper {
	
	public int getTotalMemberCount(Criteria cri);

	List<MemberVO> selectMembersWithPaging(Criteria cri);
	
	public List<RecommendCategoryVO> getAllCategoryTopDetails();
	
	List<RecommendCategoryVO> getRecommendKeyword();
	
	ReservationStatsDTO getReservationStats();
	
	Map<String, Integer> getMemberVsGuestRatio();
	
	double getReservationCancelRate();
	
	List<LocationCategoryVO> getStayCountByRegion();
	
	List<StayVO> getTopReservedStays();
	
	List<StayVO> getTopBookmarkedStays();
	
	int getTotalReservationCount(Criteria cri);
	
	List<ReservationDetailVO> getReservationList(Criteria cri);
}


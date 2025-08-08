package com.hotel.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.Criteria;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.MemberVO;
import com.hotel.domain.PageDTO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.AdminService;
import com.hotel.service.RoomService;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private StayService stayService;

	@Autowired
	private RoomService roomService;

	@Autowired
	private AdminService adminService;

	// 숙소 등록 페이지
	@GetMapping("/stay/add")
	public String StayForm(Model model) {
		// 지역 선택 목록
		model.addAttribute("locationList", stayService.getAllLocations());
		// 편의 시설 선택 목록
		model.addAttribute("facilityList", stayService.getAllFacilities());
		return "admin/room/stayRegister";
	}

	// 숙소 등록
	@PostMapping("/stay/add")
	public String addStay(StayVO stay, StayDetailVO detail,
			@RequestParam(value = "facilities", required = false) List<Integer> facilities, Model model) {

		// 숙소 정보 insert
		stayService.insertStayInfo(stay, detail, facilities);

		// 최근 si_id 가져오기
		int siId = stayService.getLastInsertId();

		if (facilities == null) {
			facilities = new ArrayList<>();
		}

		List<FacilityVO> facilityList = stayService.getAllFacilities();

		
		model.addAttribute("stay", stay); // 숙소 기본 정보
		model.addAttribute("detail", detail);	// 숙소 상세 정보
		model.addAttribute("facilityList", facilityList);	// 모든 편의 시설 목록
		model.addAttribute("selectedFacilityIds", facilities);	// 선택된 편의 시설
		model.addAttribute("newSiId", siId);	// insert 된 숙소 id

		return "/admin/room/stayRegister"; // 같은 페이지로 돌아가서 이미지 등록 진행
	}

	@GetMapping("/rooms") // 숙소 등록에서 객실 등록 페이지 이동
	public String showRoomRegister(@RequestParam("siId") int siId,
			@RequestParam(value = "riId", required = false) Integer riId, Model model) {
		model.addAttribute("siId", siId);
		model.addAttribute("riId", riId);
		model.addAttribute("facilityList", stayService.getAllFacilities());
		model.addAttribute("amenityList", roomService.getAllAmenities());
		return "admin/room/roomRegister";
	}

	@PostMapping("/stay/rooms/add") // 객실 등록
	public String addRoom(RoomVO vo, @RequestParam(value = "facilities", required = false) List<Integer> facilities,
			@RequestParam(value = "amenities", required = false) List<Integer> amenities, RedirectAttributes rttr) {

		int riId = roomService.insertRoom(vo, facilities, amenities);

		// 등록 된 객실, 숙소 마지막 id
		rttr.addAttribute("siId", vo.getSiId());
		rttr.addAttribute("riId", riId);

		return "redirect:/admin/rooms";
	}

	// 등록 완료된 객실 리스트 출력
	@GetMapping(value = "/stay/rooms/list", produces = "application/json")
	@ResponseBody
	public List<RoomVO> getRoomList(@RequestParam("siId") int siId) {
		return stayService.getRoomsByStayId(siId);
	}

	@GetMapping("/member/list")
	public String memberList(Criteria cri, Model model) {
		List<MemberVO> memberList = adminService.getMemberList(cri);
		int total = adminService.getTotalMemberCount(cri); // 총 회원 수

		model.addAttribute("memberList", memberList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("cri", cri);
		return "admin/member/memberList";
	}

	@GetMapping("/reservation/list")
	public String reservationList(Criteria cri, Model model) {
		List<ReservationDetailVO> reservationList = adminService.getReservationList(cri);
		int total = adminService.getTotalReservationCount(cri); // 총 예약 수

		model.addAttribute("reservationList", reservationList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("cri", cri);
		return "admin/reservation/reservationList";
	}
}

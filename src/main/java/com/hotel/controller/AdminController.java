package com.hotel.controller;

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
import com.hotel.domain.MemberVO;
import com.hotel.domain.PageDTO;
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
	
	@GetMapping("/stay/add")
	public String StayForm(Model model) {
		model.addAttribute("locationList", stayService.getAllLocations());
		model.addAttribute("facilityList", stayService.getAllFacilities());
		return "admin/room/stayRegister";
	}

	@PostMapping("/stay/add")
	public String addStay(StayVO stay, StayDetailVO detail,
			@RequestParam(value = "facilities", required = false) List<Integer> facilities, Model model) {

		// 숙소 정보 insert
		stayService.insertStayInfo(stay, detail, facilities);

		// 최근 si_id 가져오기
		int siId = stayService.getLastInsertId();

		model.addAttribute("newSiId", siId);

		return "/admin/room/stayRegister"; // 같은 페이지로 돌아가서 이미지 등록 진행
	}

	@GetMapping("/rooms") // 숙소 등록에서 객실 등록 페이지 이동
	public String showRoomRegister(@RequestParam("siId") int siId,@RequestParam(value = "riId", required = false) Integer riId, Model model) {
		model.addAttribute("siId", siId);
		model.addAttribute("riId", riId);
		model.addAttribute("facilityList", stayService.getAllFacilities());
		model.addAttribute("amenityList", roomService.getAllAmenities());
		return "admin/room/roomRegister";
	}

	@PostMapping("/stay/rooms/add") // 객실 등록하기
	public String addRoom(RoomVO vo, @RequestParam(value = "facilities", required = false) List<Integer> facilities,
			@RequestParam(value = "amenities", required = false) List<Integer> amenities, RedirectAttributes rttr) {

		int riId = roomService.insertRoom(vo, facilities, amenities);

		System.out.println("==== success ====");

		// 등록 된 객실 숙소 아이디, 마지막 id
		rttr.addAttribute("siId", vo.getSiId());
		rttr.addAttribute("riId", riId);
		
		return "redirect:/admin/rooms";
	}

	@GetMapping(value = "/stay/rooms/list", produces = "application/json")
	@ResponseBody
	public List<RoomVO> getRoomList(@RequestParam("siId") int siId) {
		return stayService.getRoomsByStayId(siId);
	}

	// 관리자 회원 리스트
	@GetMapping("/member/list")
	public String memberList(Criteria cri, Model model) {
		// 페이지당 보여주는 회원의 수 (cri) 만큼의 회원 정보를 가져옴
		List<MemberVO> memberList = adminService.getMemberList(cri);
	    // 총 회원의 수
	    int total = adminService.getTotalMemberCount(cri); 
	    // 전달할 데이터 모델에 저장
	    model.addAttribute("memberList", memberList);
	    // 페이징 정보 저장 (cri - 현재 페이지, total - 총 회원 수)
	    model.addAttribute("pageMaker", new PageDTO(cri, total));
	    // 페이지네이션을 위해 cri 모델에 저장
	    model.addAttribute("cri", cri); 
	    // view return
	    return "admin/member/memberList";
	}

}

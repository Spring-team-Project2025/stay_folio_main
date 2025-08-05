function wishEvent() {
  // 찜 버튼 이벤트 위임 (fetch 사용)
  $(document).off("click", ".stay-wishlist").on("click", ".stay-wishlist", function (e) {
    e.preventDefault();
    e.stopPropagation();

    const isWishlisted = $(this).attr("data-wishlist") === "true";
    const siId = $(this).closest(".stay-item").data("stay-id");

    const url = isWishlisted ? "/api/bookmark/remove" : "/api/bookmark/add";

    fetch(url + "?siId=" + siId, {
      method: isWishlisted ? "DELETE" : "POST",
      headers: {
        "Accept": "application/json"
      }
    })
      .then((res) => {
        if (!res.ok) {
          if (res.status === 400) {
            openModal(); // 로그인 필요
            return null; // 다음 then 방지
          } else if (res.ok) {
            return res.json(); // 정상 응답만 처리
          } else {
            alert("요청 실패");
            return null;
          }
        }
        return res.json();
      })
      .then((data) => {
        if (!data) return;
        
        if (data.success) {
          this.setAttribute("data-wishlist", !isWishlisted);
        } else {
          alert("찜 처리에 실패했습니다.");
        }
      })
      .catch((err) => {
        console.error("요청 중 오류 발생:", err);
        alert("찜 처리 중 오류가 발생했습니다.");
      });

      function openModal() {
    		document.getElementById("commonModal").style.display = "flex";
    	}

    	function closeModal() {
    		document.getElementById("commonModal").style.display = "none";
    	}
  });

  // 숙소 카드 클릭 이벤트
  $(document).off("click", ".stay-item").on("click", ".stay-item", function (e) {
    // 찜 버튼 클릭 방지
    if ($(e.target).closest(".stay-wishlist").length > 0) return;

    const stayId = $(this).data("stay-id");
    console.log(`숙소 ${stayId} 상세 페이지로 이동`);
    window.location.href = `/stay/${stayId}`;
  });
}
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>숙소 상세 - STAY FOLIO</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/stay/stayCarousel.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/stay/stayDetail.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/stay/stayDetailFillter.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
<!-- Carousel JS -->
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayCarousel.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayNavigation.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stay.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayDetailBooking.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayDetail.js"></script>
</head>
<body>
	<!-- 헤더 인클루드 -->
	<jsp:include page="../includes/header.jsp" />

	<!-- 메인 컨텐츠 -->
	<main class="main-content">
		<!-- 이미지 캐러셀 -->
		<section class="image-carousel-section">
			<div class="image-carousel-container">
				<div class="image-carousel">
					<div class="carousel-track">
						<div class="carousel-slide active">
							<img
								src="${pageContext.request.contextPath}/resources/img/stay/stayDetail1.png"
								alt="숙소 이미지 1" />
						</div>
						<div class="carousel-slide">
							<img
								src="${pageContext.request.contextPath}/resources/img/stay/stayDetail2.png"
								alt="숙소 이미지 2" />
						</div>
						<div class="carousel-slide">
							<img
								src="${pageContext.request.contextPath}/resources/img/stay/stayDetail3.png"
								alt="숙소 이미지 3" />
						</div>
						<div class="carousel-slide">
							<img
								src="${pageContext.request.contextPath}/resources/img/stay/stayDetail4.png"
								alt="숙소 이미지 4" />
						</div>
						<div class="carousel-slide">
							<img
								src="${pageContext.request.contextPath}/resources/img/stay/stayDetail5.png"
								alt="숙소 이미지 5" />
						</div>
					</div>
					<button class="carousel-btn prev-btn">
						<i class="ph ph-caret-left"></i>
					</button>
					<button class="carousel-btn next-btn">
						<i class="ph ph-caret-right"></i>
					</button>
					<div class="carousel-indicators">
						<span class="indicator active" data-slide="0"></span> <span
							class="indicator" data-slide="1"></span> <span class="indicator"
							data-slide="2"></span> <span class="indicator" data-slide="3"></span>
						<span class="indicator" data-slide="4"></span>
					</div>
				</div>
			</div>
		</section>

		<!-- 숙소 상세 정보 -->
		<div class="room-detail-container">
			<div class="room-detail-content">
				<!-- 좌측 영역 (70%) -->
				<div class="room-detail-left">
					<!-- 1. 숙소 제목 -->
					<section class="room-header-section">
						<h1 class="room-title">${room.riName}</h1>
						<p class="room-description">${room.riDesc}</p>
					</section>

					<!-- 2. 객실 규정 -->
					<section class="room-info-section">
						<div class="amenity-title">객실 규정</div>
						<div class="room-info-grid">
							<div class="info-item">
								<span class="info-label">체크인</span> <span class="info-value">${detail.siCheckin}</span>
							</div>
							<div class="info-item">
								<span class="info-label">체크아웃</span> <span class="info-value">${detail.siCheckout}</span>
							</div>
							<div class="info-item">
								<span class="info-label">기준 인원</span> <span class="info-value">${room.riPerson}명</span>
							</div>
							<div class="info-item">
								<span class="info-label">최대 인원</span> <span class="info-value">${room.riMaxperson}명</span>
							</div>
						</div>
					</section>

					<!-- 3. 공간정보 -->
					<section class="space-info-section">
						<div class="amenity-title">공간정보</div>
						<c:if test="${room.riArea != 0 or not empty room.riBed}">
							<div class="space-info-grid">
								<div class="space-item">
									<span class="space-value"> <c:if
											test="${room.riArea != 0}">${room.riArea}㎡</c:if> <c:if
											test="${room.riArea != 0 and not empty room.riBed}"> / </c:if>
										<c:if test="${not empty room.riBed}">${room.riBed}</c:if>
									</span>
								</div>
							</div>
						</c:if>
					</section>

					<!-- 4. 편의시설 -->
					<section class="facilities-section">
						<div class="amenity-title">편의시설</div>
						<c:if test="${not empty roomFacilities}">
							<div class="stay-amenities">
								<c:forEach var="fac" items="${roomFacilities}">
									<div class="amenity">
										<i class="ph ${fac.fiIcon}"></i><span>${fac.fiName}</span>
									</div>
								</c:forEach>
							</div>
						</c:if>
					</section>

					<!-- 5. 어메니티 -->
					<section class="amenities-section">
						<div class="amenity-title">어메니티</div>
						<c:if test="${not empty roomAmenities}">
							<div class="amenities-list">
								<c:forEach var="ame" items="${roomAmenities}">
									<div class="amenity-item">• ${ame.raName}</div>
								</c:forEach>
							</div>
						</c:if>
					</section>

					<!-- 6. 이 스테이의 다른 객실 -->
					<section id="room-select" class="stay-section">
						<c:if test="${not empty otherRooms}">
							<div class="amenity-title1">이 스테이의 다른 객실</div>
							<div class="room-list">
								<c:forEach var="room" items="${otherRooms}">
									<div class="room-card"
										onclick="location.href='/stay/${stay.siId}/${room.riId}'">
										<div class="room-image">
											<img
												src="${pageContext.request.contextPath}/resources/img/stay/stayimg1.jpg"
												alt="${room.riName}" />
										</div>
										<div class="room-info">
											<h3 class="room-name">${room.riName}</h3>
											<p>
												형태:
												<c:choose>
													<c:when test="${room.riType == 'a'}">기본형</c:when>
													<c:when test="${room.riType == 'b'}">독채형</c:when>
													<c:when test="${room.riType == 'c'}">원룸형</c:when>
													<c:when test="${room.riType == 'd'}">도미토리</c:when>
													<c:when test="${room.riType == 'e'}">복층형</c:when>
													<c:otherwise>기타</c:otherwise>
												</c:choose>
											</p>
											<p class="room-desc">/ 기준 ${room.riPerson} (최대
												${room.riMaxperson} 명)</p>
											<p>침실 ${room.riBedroom} | 침대 ${room.riBedcnt} | 욕실
												${room.riBathroom}</p>
											<div class="room-price">
												<span class="price"> ₩<fmt:formatNumber
														value="${room.riPrice}" type="number" /></span> <span
													class="per-night">/박</span>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:if>
					</section>

					<!-- 7. 안내사항 -->
					<section id="guidelines" class="stay-section">
						<div class="amenity-title">안내사항</div>
						<div class="guidelines-content">
							<!-- 예약 안내 아코디언 -->
							<div class="accordion-item">
								<div class="accordion-header">
									<h3>예약 안내</h3>
									<i class="ph ph-caret-down"></i>
								</div>
								<div class="accordion-content">
									<ul>
										<li>체크인은 오후 3시부터 가능합니다.</li>
										<li>체크아웃은 오전 11시까지 완료해주세요.</li>
										<li>기준 인원 초과 시 추가 요금이 발생할 수 있습니다.</li>
										<li>반려동물 동반은 사전 문의 후 가능합니다.</li>
									</ul>
								</div>
							</div>

							<!-- 이용 규칙 아코디언 -->
							<div class="accordion-item">
								<div class="accordion-header">
									<h3>이용 규칙</h3>
									<i class="ph ph-caret-down"></i>
								</div>
								<div class="accordion-content">
									<ul>
										<li>숙소 내 금연입니다.</li>
										<li>파티나 이벤트는 금지됩니다.</li>
										<li>조용한 시간(오후 10시~오전 8시)을 지켜주세요.</li>
										<li>쓰레기는 분리수거해주세요.</li>
									</ul>
								</div>
							</div>

							<!-- 취소 정책 아코디언 -->
							<div class="accordion-item">
								<div class="accordion-header">
									<h3>취소 정책</h3>
									<i class="ph ph-caret-down"></i>
								</div>
								<div class="accordion-content">
									<ul>
										<li>체크인 7일 전까지: 100% 환불</li>
										<li>체크인 3일 전까지: 50% 환불</li>
										<li>체크인 1일 전까지: 환불 불가</li>
										<li>노쇼(No-show): 환불 불가</li>
									</ul>
								</div>
							</div>
						</div>
					</section>
				</div>

				<!-- 우측 영역 (30%) -->
				<div class="room-detail-right">
					<!-- 예약 카드 (필터+요약 통합) -->
					<div class="booking-card">
						<!-- 가격 정보 -->
						<div class="booking-price-info">
							<div class="stay-price-main">
								<span class="stay-price-original">150,000원</span>
								<div class="stay-price-current-wrapper">
									<span class="stay-price-discount">20%</span> <span
										class="stay-price-current">120,000원</span> <span
										class="per-night">/ 박</span>
								</div>
							</div>
						</div>

						<!-- 날짜 선택 -->
						<div class="filter-section">
							<div class="filter-item date-filter">
								<label class="filter-label"> <i class="ph ph-calendar"></i>
									일정
								</label>
								<div class="filter-input-wrapper">
									<input type="text" id="dateRange" class="filter-input"
										placeholder="날짜 선택" readonly /> <i
										class="ph ph-caret-down filter-arrow"></i>
								</div>
							</div>

							<!-- 인원 선택 -->
							<div class="filter-item guest-filter">
								<label class="filter-label"> <i class="ph ph-users"></i>
									인원
								</label>
								<div class="filter-input-wrapper" id="guestSelector">
									<input type="text" class="filter-input" id="guestInput"
										value="성인 2명" readonly /> <i
										class="ph ph-caret-down filter-arrow"></i>
								</div>

								<!-- 인원 선택 드롭다운 -->
								<div class="guest-dropdown" id="guestDropdown">
									<div class="guest-option">
										<div class="guest-info">
											<span class="guest-type">성인</span> <span class="guest-desc">13세
												이상</span>
										</div>
										<div class="guest-counter">
											<button type="button" class="counter-btn minus"
												data-type="adult">
												<i class="ph ph-minus"></i>
											</button>
											<span class="counter-value" id="adultCount">2</span>
											<button type="button" class="counter-btn plus"
												data-type="adult">
												<i class="ph ph-plus"></i>
											</button>
										</div>
									</div>
									<div class="guest-option">
										<div class="guest-info">
											<span class="guest-type">아동</span> <span class="guest-desc">2~12세</span>
										</div>
										<div class="guest-counter">
											<button type="button" class="counter-btn minus"
												data-type="child">
												<i class="ph ph-minus"></i>
											</button>
											<span class="counter-value" id="childCount">0</span>
											<button type="button" class="counter-btn plus"
												data-type="child">
												<i class="ph ph-plus"></i>
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- 요금 상세 -->
						<div class="booking-price-details">
							<div class="price-detail-row">
								<span class="price-label">120,000원 × <span
									id="nightCount">1</span>박
								</span> <span class="price-value" id="roomTotal">120,000원</span>
							</div>
							<div class="price-detail-row">
								<span class="price-label">추가 인원 요금</span> <span
									class="price-value" id="extraGuestFee">0원</span>
							</div>
							<div class="price-detail-row total">
								<span class="price-label">총액</span> <span class="price-value"
									id="totalPrice">120,000원</span>
							</div>
						</div>

						<!-- 예약 버튼 -->
						<button class="booking-button" type="button">예약하기</button>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- 푸터 인클루드 -->
	<jsp:include page="../includes/footer.jsp" />
</body>
</html>

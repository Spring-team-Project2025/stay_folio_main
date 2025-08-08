<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>객실 상세 - STAY FOLIO</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomDetail.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
<script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
	<div class="admin-container">
		<aside class="admin-sidebar">
			<div class="admin-logo">
				<div class="logo-text">
					STAY<br />FOLIO
				</div>
				<div class="admin-text">ADMIN</div>
			</div>
			<nav class="admin-nav">
				<ul>
					<li><a href="/admin/dashboard" class="nav-item">대시보드</a></li>
					<li><a href="/admin/reservation/reservationList" class="nav-item">예약관리</a></li>
					<li><a href="/admin/stay/staylist" class="nav-item active">숙소관리</a></li>
					<li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
					<li><a href="/admin/review" class="nav-item">리뷰관리</a></li>
				</ul>
			</nav>
		</aside>

		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">객실 상세</h1>
						<p class="page-subtitle">등록된 객실 정보를 확인하세요.</p>
					</div>
					<div class="header-right">
						<form action="/admin/rooms/form" method="get"
							style="display: inline-block; margin-right: 1rem;">
							<input type="hidden" name="siId" value="${siId}" />
							<input type="hidden" name="riId" value="${room.riId}" />
							<button type="submit" class="btn-save">객실 수정</button>
						</form>

						<form action="/admin/room/roomlist" method="get"
							style="display: inline-block;">
							<input type="hidden" name="siId" value="${siId}" />
							<button type="submit" class="btn-save">객실 목록 보기</button>
						</form>
					</div>
				</div>
			</div>

			<div class="register-form-container">
				<div class="register-form">
					<section class="form-section">
						<h2 class="section-title">객실 기본 정보</h2>
						<div class="form-grid">
							<div class="form-group">
								<label class="form-label">객실명</label>
								<div class="form-text-readonly">${room.riName}</div>
							</div>

							<c:set var="typeLabel" value="" />
							<c:if test="${room.riType == 'a'}">
								<c:set var="typeLabel" value="기본형" />
							</c:if>
							<c:if test="${room.riType == 'b'}">
								<c:set var="typeLabel" value="독채형" />
							</c:if>
							<c:if test="${room.riType == 'c'}">
								<c:set var="typeLabel" value="원룸형" />
							</c:if>
							<c:if test="${room.riType == 'd'}">
								<c:set var="typeLabel" value="도미토리" />
							</c:if>
							<c:if test="${room.riType == 'e'}">
								<c:set var="typeLabel" value="복층형" />
							</c:if>

							<div class="form-group">
								<label class="form-label">객실 형태</label>
								<div class="form-text-readonly">${room.riType}. ${typeLabel}</div>
							</div>

							<div class="form-group">
								<label class="form-label">기준 인원</label>
								<div class="form-text-readonly">${room.riPerson}</div>
							</div>
							<div class="form-group">
								<label class="form-label">최대 인원</label>
								<div class="form-text-readonly">${room.riMaxperson}</div>
							</div>
							<div class="form-group">
								<label class="form-label">면적(m²)</label>
								<div class="form-text-readonly">${room.riArea}</div>
							</div>
							<div class="form-group">
								<label class="form-label">기본 가격</label>
								<div class="form-text-readonly">${room.riPrice}</div>
							</div>
							<div class="form-group">
								<label class="form-label">침대 종류</label>
								<div class="form-text-readonly">${room.riBed}</div>
							</div>
							<div class="form-group">
								<label class="form-label">침대 수</label>
								<div class="form-text-readonly">${room.riBedcnt}</div>
							</div>
							<div class="form-group">
								<label class="form-label">침실 수</label>
								<div class="form-text-readonly">${room.riBedroom}</div>
							</div>
							<div class="form-group">
								<label class="form-label">욕실 수</label>
								<div class="form-text-readonly">${room.riBathroom}</div>
							</div>
						</div>

						<div class="form-group full-width">
							<label class="form-label">객실 설명</label>
							<div class="form-text-readonly">${room.riDesc}</div>
						</div>
					</section>

					<section class="form-section">
						<h2 class="section-title">편의시설</h2>
						<div class="facility-list">
							<c:forEach var="fac" items="${roomFacilities}">
								<div class="facility-item">
									<i class="ph ${fac.fiIcon}"></i> <span>${fac.fiName}</span>
								</div>
							</c:forEach>
						</div>
					</section>

					<section class="form-section">
						<h2 class="section-title">어메니티</h2>
						<div class="facility-list">
							<c:forEach var="ame" items="${roomAmenities}">
								<div class="facility-item">
									<span>${ame.raName}</span>
								</div>
							</c:forEach>
						</div>
					</section>

					<!-- 이미지 -->
					<div class="form-section">
						<h2 class="section-title">숙소 이미지</h2>

						<label class="form-label">대표 이미지</label>
						<c:forEach var="photo" items="${roomPhotos.main}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="대표 이미지" />
						</c:forEach>

						<label class="form-label">추가 이미지</label>
						<c:forEach var="photo" items="${roomPhotos.additional}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="추가 이미지" />
						</c:forEach>

						<label class="form-label">주요 특징 이미지</label>
						<c:forEach var="photo" items="${roomPhotos.feature}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="주요 특징 이미지" />
						</c:forEach>

						<label class="form-label">특징1 이미지</label>
						<c:forEach var="photo" items="${roomPhotos.feat1}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="특징1 이미지" />
						</c:forEach>

						<label class="form-label">특징2 이미지</label>
						<c:forEach var="photo" items="${roomPhotos.feat2}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="특징2 이미지" />
						</c:forEach>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
</html>

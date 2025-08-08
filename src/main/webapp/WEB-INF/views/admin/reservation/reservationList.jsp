<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>예약관리 - Stay Folio Admin</title>

    <!-- CSS -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/common.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/reservation/adminReservation.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/admin/reservation/reservationList.js"></script>
  </head>
  <body>
    <div class="admin-container">
      <!-- 좌측 사이드바 -->
      <aside class="admin-sidebar">
        <div class="admin-logo">
          <h1 class="logo-text">
            STAY<br />FOLIO<br /><span class="admin-text">ADMIN</span>
          </h1>
        </div>

        <nav class="admin-nav">
          <ul>
            <li><a href="/admin/dashboard" class="nav-item">대시보드</a></li>
            <li><a href="/admin/reservation" class="nav-item">예약관리</a></li>
            <li>
              <a href="/admin/stay/staylist" class="nav-item">숙소관리</a>
            </li>
            <li>
              <a href="/admin/member" class="nav-item active">회원관리</a>
            </li>
            <li><a href="/admin/review" class="nav-item">리뷰관리</a></li>
          </ul>
        </nav>
      </aside>

      <!-- 우측 메인 컨텐츠 -->
      <main class="admin-main">
        <!-- 관리자 헤더 -->
        <div class="admin-header">
          <div class="header-content">
            <div class="header-left">
              <h2 class="page-title">예약관리</h2>
              <p class="page-subtitle">예약 정보를 관리하는 페이지입니다.</p>
            </div>
          </div>
        </div>

        <!-- 검색 및 필터 영역 -->
        <div class="search-filter-section">
          <div class="search-container">
            <input
              type="text"
              id="member-search"
              class="search-input"
              placeholder="회원 이름, 숙소이름으로 검색..."
            />
            <button class="search-btn" id="search-btn">검색</button>
          </div>

          <div class="filter-container">
            <select id="region-filter" class="region-filter"></select>
            <button class="reset-btn" id="reset-btn">초기화</button>
          </div>
        </div>

        <div class="admin-content">
          <!-- 숙소 테이블 -->
          <div class="room-table-container">
            <table class="room-table">
              <thead>
                <tr>
                  <th>번호</th>
                  <th>숙소명</th>
                  <th>예약자 이름</th>
                  <th>이메일</th>
                  <th>예약일자</th>
                  <th>예약상태</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach
                  var="reservation"
                  items="${reservationList}"
                  varStatus="status"
                >
                  <tr>
                    <td>
                      ${pageMaker.total - (pageMaker.cri.page - 1) *
                      pageMaker.cri.perPageNum - status.index}
                    </td>
                    <td>${reservation.reservationStayName}</td>
                    <td>${reservation.reservationName}</td>
                    <td>${reservation.reservationEmail}</td>
                    <td>
                      <fmt:formatDate
                        value="${reservation.reservationDate}"
                        pattern="yyyy-MM-dd"
                      />
                    </td>
                    <td>${reservation.reservationStatus}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <!-- 페이지네이션 -->
          <div class="pagination">
            <c:if test="${not empty pageMaker && pageMaker.prev}">
              <a href="?page=${pageMaker.startPage - 1}">&laquo;</a>
            </c:if>

            <c:forEach
              var="i"
              begin="${pageMaker.startPage}"
              end="${pageMaker.endPage}"
            >
              <c:choose>
                <c:when test="${i == cri.page}">
                  <a class="active" href="?page=${i}">${i}</a>
                </c:when>
                <c:otherwise>
                  <a href="?page=${i}">${i}</a>
                </c:otherwise>
              </c:choose>
            </c:forEach>

            <c:if test="${pageMaker.next}">
              <a href="?page=${pageMaker.endPage + 1}">&raquo;</a>
            </c:if>
          </div>
        </div>
      </main>
    </div>
  </body>
</html>

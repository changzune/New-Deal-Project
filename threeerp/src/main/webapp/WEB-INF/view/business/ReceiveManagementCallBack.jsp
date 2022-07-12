<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- tbody 제거 , comnGrpList.jsp 참고  -->
<c:if test="${receiveCnt eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>


<c:if test="${receiveCnt > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />

	<c:forEach items="${receiveList}" var="list">
		<tr>
			<td>${erp_copnm}</td>
			<td>${list.name}</td>
			<td>${list.clientNm}</td>
			<td>${list.empNm}</td>
			<td>${list.receiveNo}</td>
			<td>${list.receiveDate}</td>
			<td><fmt:formatNumber value="${list.sumTotal}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.supplyAmount}" pattern="#,###"/></td>
			<td>
				<a href="javascript:receiveOne('${list.receiveNo}','${list.estimateNo}', '${list.clientCd}')" >
					<span>상세보기</span>
				</a>
			</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
		<!-- 페이징 네비게이션 -->
	</c:forEach>
</c:if>

<!-- 단건조회시 카운트와 연관 깊음 -->
<input type="hidden" id="receiveCnt" name="receiveCnt" value="${receiveCnt}" />

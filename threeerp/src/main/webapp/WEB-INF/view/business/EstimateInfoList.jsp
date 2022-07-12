<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${estDetailCnt eq 0}">
	<tr>
		<td colspan="7">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<!-- 모달이 여러개라 id값 name값 다르게-->

<c:if test="${estDetailCnt > 0}">
	<c:set var = "totalCnt" value="0" />
	<c:set var = "totalUnitCost" value="0" />
	<c:set var = "totalPrice" value="0" />
	<c:set var = "totalTax" value="0" />
	<c:set var = "totalSumAmount" value="0" />
	<c:forEach items="${estListDetail}" var="list">
		<tr>
			<td>${list.productNm}</td>
			<td>${list.ourDeadline}</td>
			<td><fmt:formatNumber value="${list.estimateCnt}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.unitCost}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.price}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.tax}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${list.sumAmount}" pattern="#,###"/></td>
		</tr>
		<c:set var="totalCnt" value="${totalCnt + list.estimateCnt}"/>
		<c:set var="totalUnitCost" value="${totalUnitCost + list.unitCost}"/>
		<c:set var="totalPrice" value="${totalPrice + list.price}"/>
		<c:set var="totalTax" value="${totalTax + list.tax}"/>
		<c:set var="totalSumAmount" value="${totalSumAmount + list.sumAmount}"/>
	</c:forEach>
	<tr style="font-weight: bold">
		<td colspan="2">합계</td>
		<td><fmt:formatNumber value="${totalCnt}" pattern="#,###"/></td>
		<td><fmt:formatNumber value="${totalUnitCost}" pattern="#,###"/></td>
		<td><fmt:formatNumber value="${totalPrice}" pattern="#,###"/></td>
		<td><fmt:formatNumber value="${totalTax}" pattern="#,###"/></td>
		<td><fmt:formatNumber value="${totalSumAmount}" pattern="#,###"/></td>
	</tr>
</c:if>
<!-- 모달2 끝 -->

<!-- 단건조회시 카운트와 연관 깊음 -->
<input type="hidden" id="estDetailCnt" name="estDetailCnt" value="${estDetailCnt}"/>

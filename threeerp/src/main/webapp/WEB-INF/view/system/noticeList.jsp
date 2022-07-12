
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<c:if test="${totalcnt eq 0}">
		<tr>
			<td colspan="4">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalcnt > 0 }">
		<c:forEach items="${result}" var="list">
			<tr>
				<td>${list.no}</td>
				<td><a href="javascript:fn_writemodal('${list.no}');">${list.title}</a></td>
				<td>${list.loginID}</td>
				<td>${list.regdate}</td>
			</tr>
		</c:forEach>
	</c:if>


	<input type="hidden" id="totalcnt" name="totalcnt" value="${totalcnt}" />



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">		
							<%-- <c:set var="nRow" value="${pageSize*(pagenum-1)}" /> --%>						
								<c:forEach items="${searchlist}" var="list">
									<tr>
										
										<td>${list.sales_reg_date}</td>
										
									<c:if test="${userType eq 'B'}">
										<td>${list.loginID}</td>
									</c:if>
										<td>${list.l_ct_nm}</td>
										<td>${list.m_ct_nm}</td>
										
										<td>${list.product_nm}</td>
										<td>${list.goal_amt}</td>
										<td>${list.estimate_cnt}</td>
									<c:if test="${userType eq 'B'}">
										<td>${list.a_rate}</td>
									</c:if>
										<td>${list.memo}</td>
										<%-- <c:set var="nRow" value="${nRow + 1}" /> --%>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
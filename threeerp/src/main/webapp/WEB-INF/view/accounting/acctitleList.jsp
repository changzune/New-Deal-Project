<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">	
								<c:forEach items="${searchlist}" var="list">
									<tr>
										
										<td>${list.bigSelect}</td>
										<td>${list.accSmall}</td>
										<td>${list.payment}</td>
										<td>${list.note}</td>
										<td>${list.useYn}</td>
										<td>${list.etc}
										<div class="icontainer">
											<a href="javascript:fn_selectOne('${list.bigSelect}','${list.accSmall}');"><i class="fa-solid fa-pencil" style="margin-right: 10px; color:#50508C;" ></i></a>
											<a href="javascript:fn_delete('${list.bigSelect}','${list.accSmall}')""><i class="fa-regular fa-trash-can" style="margin-left: 10px; color:#50508C;"></i></a>
										
										</div>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>
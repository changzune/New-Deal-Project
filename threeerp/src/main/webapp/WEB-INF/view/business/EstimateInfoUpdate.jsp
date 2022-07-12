<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 모달팝업 ==  견적서 Info 수정 -->
<div id="UpdateLayer" class="layerPop layerType2"  style="width: 1200px; overflow-y: scroll;">
	<dl>
		<dt>
			<div id="divtitle" style="color:white">견적서 수정</div>
		</dt>
		<dd class="content">
			<!-- s : 여기에 내용입력 -->
			<p style="font-size: large; font-weight: bold; padding-bottom: 1%;"><i class="fa-solid fa-align-justify"></i>  견적서정보</p>
			<table class="row">
				<caption>caption</caption>
				<colgroup>
					<col width="10%">
					<col width="23%">
					<col width="10%">
					<col width="23%">
					<col width="10%">
					<col width="24%">
				</colgroup>

				<tbody>
					<tr>
						<th scope="row">회사</th>
						<td>
							<div id="UpdateErpCopnm"></div>
						</td>
						<th scope="row">사업자등록번호</th>
						<td>
							<div id="UpdateErpCopnum"></div>
						</td>
						<th scope="row">견적서등록번호</th>
						<td>
							<div id="UpdateEstimateNo"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">담당자</th>
						<td>
							<div id="UpdateErpEmp"></div>
						</td>
						<th scope="row">담당자 연락처</td>
						<td>
							<div id="UpdateErpTel"></div>
						</td>
						<th scope="row">담당자 이메일</td>
						<td>
							<div id="UpdateErpEmail"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">거래처<span class="font_red">*</span></td>
						<td>
							<input type="hidden" id="UpdateClientCd">
							<select name="UpdateClientSearch" id ='UpdateClientSearch' onchange="UpdateSearchClient()"></select>
						</td>
						<th scope="row">거래처 담당자</td>
						<td>
							<div id="UpdateClientName"></div>
						</td>
						<th scope="row">거래처 연락처</td>
						<td>
							<div id="UpdateClientTell"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">비고</th>
						<td colspan="5">
							<textarea placeholder="내용을 입력해주세요." id="UpdateRemarks" name="UpdateRemarks" style="width: 100%; height: 6.25em; border: none; resize: none;"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn_areaC mt30">
				<a href="" class="btnType blue" id="btnUpdateEstimate" name="btn"><span>수정</span></a>
				<a href="" class="btnType gray" id="btnCloseEst" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
<!-- 수정 모달 끝 -->

		  

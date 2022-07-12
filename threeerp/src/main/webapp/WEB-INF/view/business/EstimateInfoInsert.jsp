<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 모달팝업 ==  신규 등록 1 -->
<div id="layer1" class="layerPop layerType2"  style="width: 1200px; overflow-y: scroll;">
	<dl>
		<dt>
			<div id="divtitle" style="color:white">견적서 등록</div>
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
							<div id="erpCopnm"></div>
						</td>
						<th scope="row">사업자등록번호</th>
						<td>
							<div id="erpCopnum"></div>
						</td>
						<td colspan="2" hidden=""></td>
					</tr>
					<tr>
						<th scope="row">담당자</th>
						<td>
							<div id="erpEmp"></div>
						</td>
						<th scope="row">담당자 연락처</td>
						<td>
							<div id="erpTel"></div>
						</td>
						<th scope="row">담당자 이메일</td>
						<td>
							<div id="erpEmail"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">거래처<span class="font_red">*</span></td>
						<td>
							<input type="hidden" id="clientNm">
							<select name="client_search1" id ='client_search1' onchange="searchClient()"></select>
						</td>
						<th scope="row">거래처 담당자</td>
						<td>
							<div id="clientName"></div>
						</td>
						<th scope="row">거래처 연락처</td>
						<td>
							<div id="clientTell"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">비고</th>
						<td colspan="5">
							<textarea placeholder="내용을 입력해주세요." id="remarks" name="remarks" style="width: 100%; height: 6.25em; border: none; resize: none;"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn_areaC mt30">
				<a href="" class="btnType blue" id="btnInsertEst" name="btn"><span>등록</span></a>
				<a href="" class="btnType gray" id="btnCloseEst" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
<!-- 모달1 끝 -->

		  

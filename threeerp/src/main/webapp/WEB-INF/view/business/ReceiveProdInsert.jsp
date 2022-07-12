<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 모달팝업 ==  신규 등록 1 -->
<div id="receiveModal2" class="layerPop layerType2"  style="width: 1200px; overflow-y: scroll;">
	<dl>
		<dt>
			<div id="divtitle" style="color:white">수주서 등록</div>
		</dt>
		<dd class="content">
			<!-- s : 여기에 내용입력 -->
			<p style="font-size: large; font-weight: bold; padding-bottom: 1%;"><i class="fa-solid fa-align-justify"></i> 수주서정보</p>
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
							<div id="erpCopnm2"></div>
						</td>
						<th scope="row">사업자등록번호</th>
						<td>
							<div id="erpCopnum2"></div>
						</td>
						<th scope="row">수주서번호</th>
						<td>
							<div id="receiveNum2"></div>
							<input type="hidden" id="estimateNo2">
						</td>
					</tr>
					<tr>
						<th scope="row">담당자</th>
						<td>
							<div id="erpEmp2"></div>
						</td>
						<th scope="row">담당자 연락처</td>
						<td>
							<div id="erpTel2"></div>
						</td>
						<th scope="row">담당자 이메일</td>
						<td>
							<div id="erpEmail2"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">거래처</td>
						<td>
							<div id="clientNm2"></div>
							<input type="hidden" id="clientCd2" />
						</td>
						<th scope="row">거래처 담당자</td>
						<td>
							<div id="clientName2"></div>
						</td>
						<th scope="row">거래처 연락처</td>
						<td>
							<div id="clientTell2"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">비고</th>
						<td colspan="5">
							<div id="remarks2" />
						</td>
					</tr>
				</tbody>
			</table>
			<p style="font-size: large; font-weight: bold; padding-bottom: 1%; padding-top: 1%;"><i class="fa-solid fa-align-justify"></i>  상세정보</p>
			<table class="col">
				<caption>caption</caption>
				<colgroup>
					<col width="30%">
					<col width="15%">
					<col width="8%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="7%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">품목정보</th>
						<th rowspan="2">납기일</th>
						<th colspan="5">공급가액</th>
						<th rowspan="2">&nbsp;</th>
					</tr>
					<tr>
						<th scope="col">제품명</th>
						<th scope="col">수량</th>
						<th scope="col">단가</th>
						<th scope="col">공급가액</th>
						<th scope="col">부가세</th>
						<th scope="col">총금액</th>
					</tr>
				</thead>
				<!--  detail 끼워넣기  -->
				<tbody id="receiveProductList"></tbody>
			</table>
			<div class="btn_areaC mt30">
				<a href="" class="btnType blue" id="btnReceiveComplete" name="btn"><span>등록</span></a>
				<a href="" class="btnType gray" id="btnReceiveClose" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
<!-- 모달1 끝 -->

		  

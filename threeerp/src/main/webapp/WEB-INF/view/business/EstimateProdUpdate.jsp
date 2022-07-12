<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	#layer1,#layer2 {
		overflow-y: scroll;
	}
</style>

<!-- 모달이 여러개라 id값 name값 다르게-->


<!-- 모달팝업 ==  신규 등록 1 -->
<div id="UpdateLayer2" class="layerPop layerType2"  style="width: 1200px;">
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
							<div id="updateErpCopnm2"></div>
						</td>
						<th scope="row">사업자등록번호</th>
						<td>
							<div id="updateErpCopnum2"></div>
						</td>
						<th scope="row">견적서번호</th>
						<td>
							<div id="updateEstimateNo2"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">담당자</th>
						<td>
							<div id="updateErpEmp2"></div>
						</td>
						<th scope="row">담당자 연락처</td>
						<td>
							<div id="updateErpTel2"></div>
						</td>
						<th scope="row">담당자 이메일</td>
						<td>
							<div id="updateErpEmail2"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">거래처</td>
						<td>
							<div id="updateClientNm2"></div>
							<input type="hidden" id="updateClientCd2" />
						</td>
						<th scope="row">거래처 담당자</td>
						<td>
							<div id="updateClientName2"></div>
						</td>
						<th scope="row">거래처 연락처</td>
						<td>
							<div id="updateClientTell2"></div>
						</td>
					</tr>
					<tr>
						<th scope="row">비고</th>
						<td colspan="5">
							<div id="updateRemarks2" />
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
				<tbody id="updateEstProductList"></tbody>
			</table>
			<br><br><br><br><br><br>
			<div id="reloadTable">
				<table style="background-color: #F3F3F3;">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="5%">
						<col width="10%">
						<col width="8%">
						<col width="7%">
					</colgroup>
					<thead>
						<tr style="background-color: #fdfdfe">
							<th scope="row">대분류</th>
							<td>
								<select id="updateScmBigClass" name="updateScmBigClass" onChange="javascript:updateSelectmidcat();"></select>
							</td>
							<th scope="row">중분류</th>
							<td>
								<select id="updateScmMiddleClass" name="updateScmMiddleClass" onChange="javascript:updateSelectproductlistcombo();"></select>
							</td>
							<th scope="row">제품</th>
							<td>
								<select id="updateProductCd" name="updateProductCd"></select>
							</td>
							<th scope="row">수량</th>
							<td>
								<input type="number" name="updateEstimateCnt" id="updateEstimateCnt"/>
							</td>
							<th scope="row">납기일</th>
							<td>
								<input type="text" name="updateOurDeadline" id="updateOurDeadline"  style="padding : 0.5%;">
							</td>
							<td style="float: right;">
								<a href="javascript:UpdateProd()" class="btnType2 color4"><span>추가</span></a>
							</td>
						</tr>
					</thead>
				</table>
			</div>
			<div class="btn_areaC mt30">
				<a href="" class="btnType blue" id="btnUpdateComplete" name="btn"><span>수정</span></a>
				<a href="" class="btnType gray" id="btnCloseEst" name="btn"><span>취소</span></a>
			</div>
		</dd>
	</dl>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
<!-- 모달1 끝 -->

		  

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- 다음 api   -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	// 페이징 설정 
   	var pageSizeEstList = 8; // 행 다섯개
   	var pageBlockSizeEstList = 5;  // 블록 갯수 일단 출력

	// 금액 => 한글로 치환 해주는 함수 
	
	// 1 ~ 9 한글 표시
    var arrNumberWord = new Array("","일","이","삼","사","오","육","칠","팔","구");
    // 10, 100, 100 자리수 한글 표시
    var arrDigitWord = new  Array("","십","백","천");
    // 만단위 한글 표시
    var arrManWord = new  Array("","만","억", "조");

 /* -------------------------------------------------------------------  */
 /* -------------------------------------------------------------------  */

	// 함수 시작
	$(document).ready(function(){
		//견적서 목록 조회 
		estList();
			
		// 버튼 이벤트 등록
		eRegisterButtonClickEvent();
		
		// 콤보박스 함수
		// 조회 종류  
		// 부서 : dept 	// acc : 회계계정  		//cli:거래처
		// pro:싱품  //whp: 창고담당자 //wh: 창고
		// Combo Name, Option("all" : 전체     "sel" : 선택 , NULL)         
		// -> 처음목록 & 검색용  거래처이름 
		selectComCombo("cli", "client_search", "all", "");

		// -> 견적서등록 모달용 거래처 이름
		selectComCombo("cli", "client_search1", "all", "");

		selectComCombo("cli", "UpdateClientSearch", "all", "");

		productCombo("l", "scm_big_class", "all", "");

		productCombo("l", "updateScmBigClass", "all", "");

		// 달력api datepicker 사용 선언 
		$('#from_date').datepicker();
		$('#to_date').datepicker();
		$('#ourDeadline').datepicker();
		$('#updateOurDeadline').datepicker();
	});
   
	/* -------------------------------------------------------------------  */
	/* -------------------------------------------------------------------  */

	/** 버튼 이벤트 등록 */
	function eRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnIdEst = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

			switch (btnIdEst) {
				case 'btnInsertEst' : // 신규등록 , 저장
					eInsertEst();
					break;
				case 'btnSearchEst': // 검색 
					eSearchEst();
					break;
				case 'btnCloseEst' : // 모달 닫기 함수 [나는 하나로 썼음 ]
					gfCloseModal();
					break;
				case 'btnInsertEstProd' : // 상세정보 저장
					InsertProd();
					break;
				case 'btnUpdateComplete' : // 견적서 수정 최종 저장
					estimateUpdateComplete();
					break;
				case 'btnComplete' :	// 견적서 최종 저장
					estimateComplete();
					break;
				case 'btnUpdateEstimate' : // 최종 업데이트
					estimateInfoUpdate2();
					break;
			}
		});
	}

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  1. 견적서 신규 등록 모달  :  모달 실행 */
	function estModal1() {
		// 모달 팝업
		gfModalPop("#layer1");

		var param = {
			SUCCESS : "SUCCESS"
		};

		// 콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========" + data);
			estModal3(data);
		};

		callAjax("/business/estCreateModal.do", "post", "json", true, param, resultCallback);
	}

	function estModal3(data){
		$("#erpCopnm").text(data.erp_copnm);
		$("#erpCopnum").text(data.erp_copnum);
		$("#erpEmp").text(data.user.name);
		$("#erpTel").text(data.user.tel);
		$("#erpEmail").text(data.user.mail);
	}

	/** 견적서 정보에 거래처를 셀렉하면 옆에 거래처 담당자랑 거래처 연락처가 뜬다 Ajax로 */
	function searchClient() {
		var clientCd = $('#client_search1').val();
		var param = {
			clientCd : clientCd
		}

		//콜백
		var resultCallback = function(data) {
			console.log("=======여기까지 왔느냐========" + JSON.stringify(data));
			searchClient2(data);
		};

		callAjax("/business/searchClient.do", "post", "json", true, param, resultCallback);
	}

	/** 바로 위 함수의 콜백값을 받아 뿌려주기 */
	function searchClient2(data) {
		$('#clientName').empty();
		$('#clientTell').empty();

		document.querySelector("#clientTell").innerHTML = data.client.empHp;
		document.querySelector("#clientName").innerHTML = data.client.empNm;
	}
	/* 신규 등록모달 끝   */

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */
   
	/*  2 .단건조회 등등  모달창 값 초기화  */
	function estInitForm(data) {
		$("#estCnt").focus();

		//2 - 2 단건 상세조회 모달창
		var copNo = data.copNo1 + " - " + data.copNo2 + " - " + data.copNo3;

		$("#cliName").text(data.clientNm);
		$("#copNo").text(copNo);
		$("#empNm").text(data.empNm);
		$("#addr").text(data.addr);
		$("#addrDetail").text(data.addrDetail);
		$("#empHp").text(data.empHp);
		$("#estimateDate").text(data.estimateDate);
		$("#bigo").text(data.remarks);
		$("#UclientCd").val(data.clientCd);
		$("#UestimateNo").val(data.estimateNo);

		var loginId1 = <%=(String)session.getAttribute("loginId")%>;
		var loginId2 = data.loginId;

		// 작성자 본인일때만 수정,삭제영역 보임
		if(loginId1 == loginId2) {
			$("#btnUpdateEst").show();
			$("#btnDeleteEst").show();
		} else {
			$("#btnUpdateEst").hide();
			$("#btnDeleteEst").hide();
		}
	}
	
	/**  3.  처음 견적서 목록 뿌려주기 */
	function estList(currentPage) {  
		currentPage = currentPage || 1;

		// 거래처 리스트 셀렉창
		var client_search = $("#client_search").val();
		// 시작 날짜
		var to_date = $("#to_date").val().toLocaleString().replace(/\./g, "");
		// 끝 날짜
		var from_date = $("#from_date").val().toLocaleString().replace(/\./g, "");
		
        var param = {
        	currentPage : currentPage,
        	pageSize : pageSizeEstList,
			client_search : client_search,
        	to_date : to_date,
        	from_date : from_date
        }

		//콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========");
		
			//목록 조회 결과 
			estListResult(data, currentPage);
		};
		
		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터, 비동기? 동기, 돌려 줄 함수  */
		callAjax("/business/estManagementList.do", "post", "text", true, param, resultCallback); //text
	}

	/**  3-1.목록조회 콜백 함수 */
	function estListResult(data, currentPage) {
		// 기존 목록 삭제
		$('#listEstManage').empty(); 
		// 신규 목록 생성
		$("#listEstManage").append(data);
		// 총 갯수 추출
		var estCnt = $("#estCnt").val();
		
		console.log("estCnt ", estCnt);
		console.log("currentPage ", currentPage);

		// 네비게이션
		//	현재페이지  , 행 갯수 , 리스트사이즈 , 블록 갯수 , 목록리스트함수 
		var estManageHtml = getPaginationHtml(
			currentPage, 
			estCnt,
			pageSizeEstList ,  
			pageBlockSizeEstList,
			'estList'
		);
		
		console.log("estManageHtml  : " + estManageHtml );

		//네비게이션 비우고 다시 채우기
		$("#EstPagination").empty().append( estManageHtml );
		
		// BizCurrentPage 에 현재 페이지 설정
		$("#EstCurrentPage").val(currentPage);
		
		// 값이제대로 왔다 확인 
		var EstCurrentPage = $("#EstCurrentPage").val();
		console.log("EstCurrentPage " +  EstCurrentPage);
	}

	//검색구현
	function eSearchEst(currentPage) {
		/* 달력=>datepicker 사용했음
		document.ready에서
		$('#from_date').datepicker();
		$('#to_date').datepicker();  작성 후 검색구현 함수에서 값 가져오기  */

		currentPage = currentPage || 1;

		// 날짜 1
		var to_date = $("#to_date").val().toLocaleString().replace(/\./g, "");
		// 날짜 2
		var from_date = $("#from_date").val().toLocaleString().replace(/\./g, "");

		console.log('to_date' , to_date);
		console.log('from_date' , from_date);

		// 거래처 넘기기
		var client_search = $("#client_search").val();

		var param = {
			client_search : client_search,
			currentPage : currentPage,
			pageSize : pageSizeEstList,
			from_date : from_date,
			to_date : to_date
		}

		console.log(" param : " , param);
		console.log("param.valueOf()",  param.valueOf());

		var resultCallback = function(data) {
			console.log("=======resultCallback========");

			//목록 조회 결과
			estListResult(data, currentPage);
			console.log(" 검색 조회결과 data ", data);
		};

		// 목록조회에 던져준다.
		/*  순서 주의 :  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/estManagementList.do", "post", "text", true, param, resultCallback); //text
	}

	/** 4-1. 단건 조회 */
	function estOne(estimate_no, client_cd) {
		var param = {
			estimateNo : estimate_no,
			clientCd : client_cd
		};
		
		var resultCallback = function(data) {
			estOneResult(data);
		};
		
		callAjax("/business/estManagementSelect.do", "post", "json", true, param, resultCallback);
	}
	
	/**  4-2 단건 조회 콜백 함수*/
	function estOneResult(data) {
		// 모달 팝업
		gfModalPop("#layer2");

		// 그룹코드 폼 데이터 설정
		estInitForm(data.estpart);

		// 프로퍼티
		$("#erp_copnm").text(data.erp_copnm);
		$("#erp_copnum").text(data.erp_copnum);
		$("#erp_addr").text(data.erp_addr);
		$("#erp_addrDetail").text(data.erp_addrDetail);
		$("#erp_emp").text(data.estpart.name);
		$("#erp_tel").text(data.estpart.tel);

		// 단건조회의 foreach문으로 리스트 뿌리기
		estimatedetaillist(data.estpart.estimateNo, data.estpart.clientCd);
	}
	
	// 4-3 단건조회의 리스트 뿌리기 
	function estimatedetaillist(estimate_no, client_cd){
		var param = {
			estimateNo : estimate_no,
			clientCd : client_cd
		}

		//콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========");
			
			//목록 조회 결과
			estDetailListResult(data);
		};
			
		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/estDetaillist.do", "post", "text", true, param, resultCallback); //text
	}
	
	// 4-4 단건조회의 리스트 뿌리기 콜백
	function estDetailListResult(data){
		// 기존 목록 삭제
		$('#EstDetaillist').empty();
		// 신규 목록 생성
		$("#EstDetaillist").append(data);
	}
	 
	/* 팝업내 수정, 저장 validation */
	function eValidatePopup(){
	
		var chk = checkNotEmpty(
			[
				["client_search1", "업체명을 체크해주세요!"]
			]
		);
	 
	 	if(!chk){return;}
	 	return true;
	}
	/* 팝업내 수정, 저장 validation 끝 */

	/*  신규 등록 및 저장  */
	function eInsertEst() {
		var clientCd = $('#client_search1').val();
		var remarks = $('#remarks').val();

		var param = {
			clientCd : clientCd,
			remarks : remarks

		}
		// validation 체크
		if(!(eValidatePopup())){ return; }

		var resultCallback = function(data){
			eInsertResult(data); // 저장 콜백 함수
		};

		// 폼이름 =>$("#myNotice").serialize() => 직렬화해서 name 값들을 그냥 넘김.
		// callAjax("/business/estManagementSave.do", "post", "json", true, $("#estForm1").serialize(), resultCallback);
		callAjax("/business/estManagementSave.do", "post", "json", true, param, resultCallback);
	}

	/*  저장 & 수정  & 삭제 함수 콜백 함수 */
	function eInsertResult(data) {
		gfCloseModal();	// 모달 닫기

		// 모달 팝업
		gfModalPop("#layer1-2");
		eInsertEst2(data.estInfo.clientCd);
	}

	function eInsertEst2(clientCd) {
		var param = {
			clientCd : clientCd
		}

		var resultCallback = function(data){
			eInsertResult2(data); // 저장 콜백 함수
		};

		callAjax("/business/estManagementSave2.do", "post", "json", true, param, resultCallback);
	}

	function eInsertResult2(data) {
		$("#erpCopnm2").text(data.erp_copnm);
		$("#erpCopnum2").text(data.erp_copnum);
		$("#estimateNo2").text(data.estInfo.estimateNo);
		$("#erpEmp2").text(data.user.name);
		$("#erpTel2").text(data.user.tel);
		$("#erpEmail2").text(data.user.mail);
		$("#clientCd2").val(data.estInfo.clientCd);
		$("#clientNm2").text(data.estInfo.clientNm);
		$("#clientName2").text(data.estInfo.empNm);
		$("#clientTell2").text(data.estInfo.tel);
		$("#remarks2").text(data.estInfo.remarks);
	}

	function InsertProd() {
		// validation 체크
		// if(!(eValidatePopup2())){ return; }

		var estimateNo = $("#estimateNo2").text();
		var clientCd = $("#clientCd2").val();
		var productCd = $("#productCd").val();
		var estimateCnt = $("#estimateCnt").val();
		var ourDeadline = $("#ourDeadline").val();

		var param = {
			estimateNo : estimateNo,
			clientCd : clientCd,
			productCd : productCd,
			estimateCnt : estimateCnt,
			ourDeadline : ourDeadline
		}

		//콜백
		var resultCallback = function(data) {
			console.log("======================estInsertProdCallBack=====================");

			//목록 조회 결과
			estInsertProd(data);
			console.log(" estInsertProdCallBack 뿌려주기 조회결과 data ", data);
		};

		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/estInsertProdCallBack.do", "post", "text", true, param, resultCallback); //text
	}

	function estInsertProd(data) {
		// 상품 추가 목록 비우기
		$('#estimateCnt').val(null);
		$('#ourDeadline').val(null);
		$('#scm_big_class').val(null);
		$('#scm_middle_class').val(null);
		$('#productCd').val(null);

		// 기존 목록 삭제
		$('#EstProductList').empty();
		// 신규 목록 생성
		$("#EstProductList").append(data);
	}

	function estDeleteProd(estimateNo, clientCd, productCd) {
		let param = {
			estimateNo : estimateNo,
			clientCd : clientCd,
			productCd : productCd
		};

		var resultCallback = function(data) {
			estDeleteResult(data);
			estimateProdDeleteResult(data);
		};

		callAjax("/business/estDeleteProd.do", "post", "text", true, param, resultCallback);
	}

	function estDeleteResult(data) {
		// 기존 목록 삭제
		$('#EstProductList').empty();
		// 신규 목록 생성
		$("#EstProductList").append(data);
	}

	function estimateProdDeleteResult(data) {
		// 기존 목록 삭제
		$('#updateEstProductList').empty();
		// 신규 목록 생성
		$("#updateEstProductList").append(data);
	}
	
	function estimateComplete() {
		var sumTotal = $("#sumTotal").text();
		var supplyCost = $("#supplyCost").text();
		var supplyVal = $("#supplyVal").text();
		var supplyTax = $("#supplyTax").text();
		var supplyAmount = $("#supplyAmount").text();

		var estimateNo = $("#estimateNo2").text();
		var clientCd = $("#clientCd2").val();

		var param = {
			sumTotal : sumTotal,
			supplyCost : supplyCost,
			supplyVal : supplyVal,
			supplyTax : supplyTax,
			supplyAmount : supplyAmount,
			estimateNo : estimateNo,
			clientCd : clientCd
		}

		var resultCallback = function(data){
			eCompleteResult(data); // 저장 콜백 함수
		};

		callAjax("/business/estUpdateInfo.do", "post", "json", true, param, resultCallback);
	}

	function eCompleteResult(data) {
		alert(data.resultMsg);

		gfCloseModal();
		location.reload(); // 새로고침
	}

	/**  견적서 모달 안 리스트  */
	function estDetailList(currentPage) {
		currentPage = currentPage || 1;

		// 날짜 1
		var to_date = $("#to_date").val();
		// 날짜 2
		var from_date = $("#from_date").val();

		var param = {
			currentPage : currentPage,
			pageSize : pageSizeEstList,
			to_date : to_date, // 뷰단에 남아있는 날짜 데이터 넣어줘서 다시 조회
			from_date : from_date
		}

		console.log(" param : " ,param);
		console.log("param.valueOf()",  param.valueOf());

		//콜백
		var resultCallback = function(data, currentPage) {
			console.log("=======resultCallback========");

			//목록 조회 결과
			estListDetailResult(data, currentPage);
		};

		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/estManagementList.do", "post", "text",  true,param, resultCallback); //text
	}

	/**  견적서 모달 안 리스트  함수  */
	function estListDetailResult(data,currentPage) {

		console.log("목록조회 콜백함수 ",data);

		// 기존 목록 삭제
		$('#listEstManage').empty();
		// 신규 목록 생성
		$("#listEstManage").append(data);
		// 총 갯수 추출
		var estCnt = $("#estCnt").val();

		console.log("estCnt ", estCnt);

		// 네비게이션
		// 현재페이지  , 행 갯수 , 리스트사이즈 , 블록 갯수 , 목록리스트함수
		var estManageHtml = getPaginationHtml(
			currentPage,
			estCnt,
			pageSizeEstList ,
			pageBlockSizeEstList,
			'estList'
		);

		console.log("estManageHtml  : " + estManageHtml );

		//네비게이션 비우고 다시 채우기
		$("#EstPagination").empty().append(estManageHtml);

		// BizCurrentPage 에 현재 페이지 설정

		// 값이제대로 왔다 확인
		var EstCurrentPage = $("#EstCurrentPage").val();
		console.log("EstCurrentPage " +  EstCurrentPage);
	}

	// scm 대분류,중분류,제품 콤보박스
	function selectmidcat(){
	    var largecd = $("#scm_big_class").val();
		// 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
	    productCombo("m", "scm_middle_class", "all", largecd);

	    $("#scm_middle_class").find("option").remove();
	    $("#scm_product").find("option").remove();
	}

	function selectproductlistcombo(){
	    var margecd = $("#scm_middle_class").val();
		// 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
		productCombo("p", "productCd", "all", margecd);
	}

	// 수정용!!! scm 대분류,중분류,제품 콤보박스
	function updateSelectmidcat(){
		var largecd = $("#updateScmBigClass").val();
		// 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
		productCombo("m", "updateScmMiddleClass", "all", largecd);

		$("#updateScmMiddleClass").find("option").remove();
		$("#updateProductCd").find("option").remove();
	}

	function updateSelectproductlistcombo(){
		var margecd = $("#updateScmMiddleClass").val();
		// 조회 종류   l : 대분류  m : 중분류  p:중분류 제품,   Combo Name, Option("all" : 전체     "sel" : 선택 ,  중분류 코드(제품 목록 조회시 필수))
		productCombo("p", "updateProductCd", "all", margecd);
	}

	/** EstimateInfo 수정 */
	function estimateInfoUpdate() {
		// 모달 팝업
		let estimateNo = $("#UestimateNo").val();
		let clientCd = $("#UclientCd").val();

		gfModalPop("#UpdateLayer");

		var param = {
			SUCCESS : "SUCCESS",
			clientCd : clientCd,
			estimateNo : estimateNo
		};

		// 콜백
		var resultCallback = function(data) {
			estUpdateModal(data);
		};

		callAjax("/business/estUpdateModal.do", "post", "json", true, param, resultCallback);
	}

	function estUpdateModal(data){
		$('#UpdateErpCopnm').text(data.erp_copnm);
		$('#UpdateErpCopnum').text(data.erp_copnum);
		$('#UpdateEstimateNo').text(data.update.estimateNo);
		$('#UpdateErpEmp').text(data.user.name);
		$('#UpdateErpTel').text(data.user.tel);
		$('#UpdateErpEmail').text(data.user.mail);

		$('#UpdateClientCd').val(data.client.clientCd);
		$('#UpdateClientSearch').val(data.client.clientCd);
		$('#UpdateClientName').text(data.client.empNm);
		$('#UpdateClientTell').text(data.client.empHp);
		$('#UpdateRemarks').val(data.update.remarks);
	}

	function UpdateSearchClient() {
		var clientCd = $('#UpdateClientSearch').val();
		var param = {
			clientCd : clientCd
		}

		//콜백
		var resultCallback = function(data) {
			console.log("=======여기까지 왔느냐========" + JSON.stringify(data));
			UpdateSearchClient2(data);
		};

		callAjax("/business/searchClient.do", "post", "json", true, param, resultCallback);
	}

	/** 바로 위 함수의 콜백값을 받아 뿌려주기 */
	function UpdateSearchClient2(data) {
		$('#UpdateClientName').empty();
		$('#UpdateClientTell').empty();

		$('#UpdateClientTell').text(data.client.empHp);
		$('#UpdateClientName').text(data.client.empNm);
	}

	function estimateInfoUpdate2() {
		let estimateNo = $("#UpdateEstimateNo").text();
		let clientCd = $("#UpdateClientSearch").val();
		let remarks = $("#UpdateRemarks").val();
		let clientCdBefore = $('#UpdateClientCd').val();

		let param = {
			estimateNo : estimateNo,
			clientCd : clientCd,
			remarks : remarks,
			clientCdBefore : clientCdBefore
		}

		console.log("수정 값 들어감? " + JSON.stringify(param));

		var resultCallback = function(data){
			estimateInfoUpdate3(data); // 저장 콜백 함수
		};

		callAjax("/business/estimateInfoUpdate.do", "post", "json", true, param, resultCallback);
	}

	function estimateInfoUpdate3(data) {
		gfCloseModal();	// 모달 닫기

		// 모달 팝업
		gfModalPop("#UpdateLayer2");

		estimateProdUpdate(data.estInfo.estimateNo, data.estInfo.clientCd);
	}

	function estimateProdUpdate(estimateNo, clientCd) {
		let param = {
			estimateNo : estimateNo,
			clientCd : clientCd
		}

		var resultCallback = function(data){
			estimateProdUpdate2(data); // 저장 콜백 함수
		};

		var resultCallback2 = function(data){
			estimateProdUpdate2_1(data); // 저장 콜백 함수
		};

		callAjax("/business/estimateProdUpdate.do", "post", "json", true, param, resultCallback);
		callAjax("/business/estimateUpdateProdList.do", "post", "text", true, param, resultCallback2);
	}

	function estimateProdUpdate2(data) {
		$("#updateErpCopnm2").text(data.erp_copnm);
		$("#updateErpCopnum2").text(data.erp_copnum);
		$("#updateEstimateNo2").text(data.estInfo.estimateNo);
		$("#updateErpEmp2").text(data.user.name);
		$("#updateErpTel2").text(data.user.tel);
		$("#updateErpEmail2").text(data.user.mail);
		$("#updateClientCd2").val(data.estInfo.clientCd);
		$("#updateClientNm2").text(data.estInfo.clientNm);
		$("#updateClientName2").text(data.estInfo.empNm);
		$("#updateClientTell2").text(data.estInfo.tel);
		$("#updateRemarks2").text(data.estInfo.remarks);
	}

	function estimateProdUpdate2_1(data) {
		// 기존 목록 삭제
		$('#updateEstProductList').empty();
		// 신규 목록 생성
		$("#updateEstProductList").append(data);
	}

	function UpdateProd() {
		// validation 체크
		// if(!(eValidatePopup2())){ return; }

		var estimateNo = $("#updateEstimateNo2").text();
		var clientCd = $("#updateClientCd2").val();
		var productCd = $("#updateProductCd").val();
		var estimateCnt = $("#updateEstimateCnt").val();
		var ourDeadline = $("#updateOurDeadline").val();

		var param = {
			estimateNo : estimateNo,
			clientCd : clientCd,
			productCd : productCd,
			estimateCnt : estimateCnt,
			ourDeadline : ourDeadline
		}

		console.log("파람 값 잘 들어왔나 확인해보자 : " + JSON.stringify(param));
		//콜백
		var resultCallback = function(data) {
			console.log("======================estUpdateProdCallBack=====================");

			//목록 조회 결과
			estUpdateProd(data);
			console.log(" estUpdateProdCallBack 뿌려주기 조회결과 data ", data);
		};

		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/estUpdateProdCallBack.do", "post", "text", true, param, resultCallback); //text
	}

	function estUpdateProd(data) {
		// 상품 추가 목록 비우기
		$('#updateEstimateCnt').val(null);
		$('#updateOurDeadline').val(null);
		$('#updateScmBigClass').val(null);
		$('#updateScmMiddleClass').val(null);
		$('#updateProductCd').val(null);

		// 기존 목록 삭제
		$('#updateEstProductList').empty();
		// 신규 목록 생성
		$("#updateEstProductList").append(data);
	}

	function estimateUpdateComplete() {
		var sumTotal = $("#sumTotal").text();
		var supplyCost = $("#supplyCost").text();
		var supplyVal = $("#supplyVal").text();
		var supplyTax = $("#supplyTax").text();
		var supplyAmount = $("#supplyAmount").text();

		var estimateNo = $("#updateEstimateNo2").text();
		var clientCd = $("#updateClientCd2").val();

		var param = {
			sumTotal : sumTotal,
			supplyCost : supplyCost,
			supplyVal : supplyVal,
			supplyTax : supplyTax,
			supplyAmount : supplyAmount,
			estimateNo : estimateNo,
			clientCd : clientCd
		}

		var resultCallback = function(data){
			eCompleteResult(data); // 저장 콜백 함수
		};

		callAjax("/business/estUpdateInfo.do", "post", "json", true, param, resultCallback);
	}

	function estimateInfoDelete() {
		let estimateNo = $("#UestimateNo").val();
		let clientCd = $("#UclientCd").val();

		var param = {
			estimateNo : estimateNo,
			clientCd : clientCd
		}

		let result = confirm("정말 삭제하시겠습니까?");

		if(result) {
			let resultCallback = function(data) {
				console.log("=======여기까지 왔느냐========" + JSON.stringify(data));
				estimateInfoDelete2(data);
			};

			callAjax("/business/estimateInfoDelete.do", "post", "json", true, param, resultCallback);
		} else {
			alert("취소 했습니다.");
		}
	}

	function estimateInfoDelete2(data) {
		alert(data.resultMsg);	// 받은 메세지 출력

		gfCloseModal();
		location.reload();
	}
</script>
</head>
<body>
	<form id="estForm1" action=""  method="">
		<input type="hidden" id="EstCurrentPage" value="1">
		<input type="hidden" name="action" id="action" value="">

		<!-- 모달 배경 -->
		<div id="mask"></div>

		<div id="wrap_area">
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 -->
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						<!--// lnb 영역 -->
					</li>

					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">
							<p class="Location">
								<a href="#" class="btn_set home">메인으로</a>
								<a href="#" class="btn_nav">영업</a>
								<span class="btn_nav bold"> 견적서 작성 및 조회</span>
								<a href=javascript:location.reload(); class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>견적서 작성 및 조회</span>
								<span class="fr">
									<a class="btnType blue" href="javascript:estModal1();" name="modal"><span>견적서등록</span></a>
								</span>
							</p>

							<!-- 검색조회 -->
							<!-- 검색 -->
							<br>

							<div style = "padding : 3% 10% 3% 10%  ; border : 3px #CDECFA; border-style : solid ; margin: auto;">
								<!-- 거래처 콤보박스   -->
								<div style ="margin: auto" >
									<b style ="padding: 0 1% 0 1%" >거래처</b>
									<select name="client_search" id ='client_search'></select>
									<!-- 달력 조회  -->
									<b style ="padding: 0 3% 0 5%">날짜 </b>
									<input type="text" id="from_date"  style="padding : 0.5%;"> ~ <input type="text" id="to_date" style="padding : 0.5% 0 0.5% 0;" >

									<a href="" class="btnType blue" id="btnSearchEst" name="btn" style ="float : right; ">
										<span>조회</span>
									</a>
								</div>
							</div>
							<!-- 검색조건 끝 -->

							<!-- 조회목록 윗칸띄우기 -->
							<div class="zldf" style ="padding-top: 2%;margin: auto;"> </div>

							<table class="col">
								<caption>caption</caption>
								<colgroup>
								   <col width="10%">
								   <col width="25%">
								   <col width="25%">
								   <col width="10%">
								   <col width="10%">
								   <col width="10%">
								   <col width="10%">
								</colgroup>

								<thead>
								   <tr>
									   <th scope="col">회사</th>
									   <th scope="col">견적서번호</th>
									   <th scope="col">거래처</th>
									   <th scope="col">담당자</th>
									   <th scope="col">총금액</th>
									   <th scope="col">등록일</th>
									   <th scope="col">&nbsp;</th>
								   </tr>
								</thead>
								<!--EstManagementCallBack으로 넘어감.여기는 틀만 만드는곳  -->
								<tbody id="listEstManage"></tbody>
							</table>
							<!-- 페이징에리어 -->
							<div class="paging_area" id="EstPagination"></div>
						</div>
					</li>
				</ul>
			<!-- content end -->
			</div>
		</div>
		<jsp:include page="/WEB-INF/view/business/EstimateInfoInsert.jsp"></jsp:include>
	</form>
	<jsp:include page="/WEB-INF/view/business/EstimateProdInsert.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/business/EstimateProdUpdate.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/business/EstimateDetailView.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/business/EstimateInfoUpdate.jsp"></jsp:include>
</body>
</html>
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
<!-- 다음 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// 페이징 설정 
	const pageSizeOemList = 8; // 행 다섯개
	const pageBlockSizeOemList = 5;  // 블록 갯수 일단 출력

	// 함수 시작
	$(document).ready(function(){
		//견적서 목록 조회 
		receiveList();
			
		// 버튼 이벤트 등록
		oRegisterButtonClickEvent();

		// -> 처음목록 & 검색용  거래처이름 
		selectComCombo("cli", "client_search", "all", "");   

		// -> 수주서등록 모달용 거래처 이름
		receiveNumSelectCombo("clientSearch1", "all", "");

		productCombo("l", "scm_big_class", "all", "");
		
		// 달력api datepicker 사용 선언 
		$('#from_date').datepicker();
		$('#to_date').datepicker();
	});

	/* -------------------------------------------------------------------  */
	/* -------------------------------------------------------------------  */
	/** 수주서 전용 콤보박스 만들자 */
	function receiveNumSelectCombo(combo_name, type, searchkey, selvalue) {

		console.log("receiveNumSelectCombo Start !!!!!!!!!!!!!! ");

		var selectbox = document.getElementById(combo_name);

		var data = {
			"searchkey" : searchkey
		};

		$(selectbox).find("option").remove();

		$.ajax({
			type: "POST",
			url: "/business/receiveNumSelectCombo.do",
			dataType: "json",
			data : data,
			success: function(data) {
				var json_obj = $.parseJSON(JSON.stringify(data));//parse JSON
				var jsonstr = json_obj.list;
				console.log("jsonstr : " + jsonstr);

				var jsonstr_obj = $.parseJSON(JSON.stringify(jsonstr));//parse JSON
				var listLen = jsonstr_obj.length;

				if(type == "all") {
					$(selectbox).append("<option value=''>전체</option>");
				}

				if(type == "sel") {
					$(selectbox).append("<option value=''>선택</option>");
				}

				console.log(" selvalue : " + JSON.stringify(selvalue));
				for(var i = 0; i < listLen; i++) {
					var eleString = JSON.stringify(jsonstr_obj[i]);
					var item_obj = $.parseJSON(eleString); //parse JSON

					if(selvalue != null && selvalue != null && selvalue != "") {
						if(selvalue == item_obj.dtl_cod) {
							console.log(" item_obj.cd : " + item_obj.clientCd);

							$(selectbox).append("<option value='"+ item_obj.clientCd + "' selected>" + item_obj.clientNm + "</option>");
						} else {
							$(selectbox).append("<option value='"+ item_obj.clientCd + "'>" + item_obj.clientNm + "</option>");
						}
					} else {
						$(selectbox).append("<option value='"+ item_obj.clientCd + "'>" + item_obj.clientNm + "</option>");
					}
				}
				$(selectbox).val(selvalue);
			},
			error:function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
		});
	};

	/** 버튼 이벤트 등록 */
	function oRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnIdEst = $(this).attr('id'); // id값 들어오면 변수에 넣어준다 

			switch (btnIdEst) {
				case 'btnReceiveInfoInsert' : // 신규등록 , 저장
					ReceiveInfoInsert();
					break;
				case 'btnSearchReceive': // 검색
					SearchReceive();
					break;
				case 'btnReceiveClose' : // 모달 닫기 함수 [나는 하나로 썼음 ]
					gfCloseModal();
					break;
				case 'btnReceiveComplete' :	// 수주서 최종 저장
					receiveComplete();
					break;
			}
		});
	}
	
/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  1. 수주서 신규 등록 모달  :  모달 실행 */
	function receiveModal1() {
		// 모달 팝업
		gfModalPop("#receiveModal");

		var param = {
			SUCCESS : "SUCCESS"
		};

		// 콜백
		var resultCallback = function(data) {
			console.log("=======resultCallback========" + JSON.stringify(data));
			receiveModal2(data);
		};

		callAjax("/business/receiveInfoCreateModal.do", "post", "json", true, param, resultCallback);
	}

	function receiveModal2(data){
		$("#erpCopnm").text(data.erp_copnm);
		$("#erpCopnum").text(data.erp_copnum);
		$("#erpEmp").text(data.user.name);
		$("#erpTel").text(data.user.tel);
		$("#erpEmail").text(data.user.mail);
	}

	/** 견적서 정보에 거래처를 셀렉하면 옆에 거래처 담당자랑 거래처 연락처가 뜬다 Ajax로 */
	function receiveSearchClient() {
		var clientCd = $('#clientSearch1').val();
		var clientNm = $('#clientSearch1 option:checked').text();
		let idx = clientNm.indexOf("@");
		let estimateNo = clientNm.substring(0, idx).trim();

		var param = {
			clientCd : clientCd,
			estimateNo : estimateNo
		}

		//콜백
		var resultCallback = function(data) {
			receiveSearchClient2(data);
		};

		callAjax("/business/receiveSearchClient.do", "post", "json", true, param, resultCallback);
	}

	/** 바로 위 함수의 콜백값을 받아 뿌려주기 */
	function receiveSearchClient2(data) {
		$('#clientName').empty();
		$('#clientTell').empty();
		$('#estimateNo').empty();

		$('#clientName').text(data.client.empNm);
		$('#clientTell').text(data.client.empHp);
		$('#estimateNo').text(data.estimateNo);
	}
	/* 신규 등록모달 끝   */

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/*  신규 등록 및 저장  */
	function ReceiveInfoInsert() {
		var clientCd = $('#clientSearch1').val();
		var remarks = $('#remarks').val();
		var estimateNo = $('#estimateNo').text();

		var param = {
			clientCd : clientCd,
			receiveRemarks : remarks,
			estimateNo : estimateNo
		}

		// validation 체크
		if(!(rValidatePopup())){ return; }

		var resultCallback = function(data){
			ReceiveInfoInsertResult(data); // 저장 콜백 함수
		};

		callAjax("/business/receiveManagementInsert.do", "post", "json", true, param, resultCallback);
	}

	/*  저장함수 콜백 함수 */
	function ReceiveInfoInsertResult(data) {
		gfCloseModal();	// 모달 닫기

		// 모달 팝업
		gfModalPop("#receiveModal2");
		ReceiveInfoInsert2(data.receiveInfo.estimateNo, data.receiveInfo.clientCd, data.receiveInfo.receiveNo);
	}

	function ReceiveInfoInsert2(estimateNo, clientCd, receiveNo) {
		var param = {
			estimateNo : estimateNo,
			clientCd : clientCd,
			receiveNo : receiveNo
		}

		var resultCallback = function(data){
			ReceiveInfoInsertResult2(data); // 저장 콜백 함수
		};

		var resultCallback2 = function(data){
			estimateProdUpdate2_1(data); // 저장 콜백 함수
		};

		callAjax("/business/receiveManagementInsert2.do", "post", "json", true, param, resultCallback);
		callAjax("/business/estimateUpdateProdList.do", "post", "text", true, param, resultCallback2);
	}

	function ReceiveInfoInsertResult2(data) {
		$("#erpCopnm2").text(data.erp_copnm);
		$("#erpCopnum2").text(data.erp_copnum);
		$("#receiveNum2").text(data.receiveInfo.receiveNo);
		$("#estimateNo2").val(data.receiveInfo.estimateNo);
		$("#erpEmp2").text(data.user.name);
		$("#erpTel2").text(data.user.tel);
		$("#erpEmail2").text(data.user.mail);
		$("#clientCd2").val(data.receiveInfo.clientCd);
		$("#clientNm2").text(data.receiveInfo.clientNm);
		$("#clientName2").text(data.receiveInfo.empNm);
		$("#clientTell2").text(data.receiveInfo.tel);
		$("#remarks2").text(data.receiveInfo.receiveRemarks);
	}

	function estimateProdUpdate2_1(data) {
		// 기존 목록 삭제
		$('#receiveProductList').empty();
		// 신규 목록 생성
		$("#receiveProductList").append(data);
	}

	// 최종 저장
	function receiveComplete() {
		var receiveNum = $("#receiveNum2").text();
		var estimateNo = $("#estimateNo2").val();
		var clientCd = $("#clientCd2").val();

		var param = {
			estimateNo : estimateNo,
			clientCd : clientCd,
			receiveNo : receiveNum
		}

		var resultCallback = function(data){
			receiveCompleteResult(data); // 저장 콜백 함수
		};

		callAjax("/business/receiveComplete.do", "post", "json", true, param, resultCallback);
	}

	function receiveCompleteResult(data) {
		alert(data.resultMsg);

		gfCloseModal();
		location.reload(); // 새로고침
	}

	/* 팝업내 수정, 저장 validation */
	function rValidatePopup(){

		var chk = checkNotEmpty(
				[
					["clientSearch1", "업체명을 체크해주세요!"]
				]
		);

		if(!chk){return;}
		return true;
	}

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/**  처음 견적서 목록 뿌려주기 */
	function receiveList(currentPage) {
		currentPage = currentPage || 1;

		var client_search = $("#client_search").val();
		// 날짜 1
		var to_date = $("#to_date").val();
		// 날짜 2
		var from_date = $("#from_date").val();
		
        var param = {
        	currentPage : currentPage,
            pageSize : pageSizeOemList,
			client_search : client_search,
            to_date : to_date,
            from_date : from_date
        }
		 
		//콜백
		var resultCallback = function(data) {
			//목록 조회 결과 
			receiveListResult(data, currentPage);
		};
		
		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/receiveManagementList.do", "post", "text", true, param, resultCallback); //text
	}

	/**  목록조회 콜백 함수 */
	function receiveListResult(data, currentPage) {
		console.log("목록조회 콜백함수 ",data);

		// 기존 목록 삭제
		$('#listReceiveManagement').empty();
		// 신규 목록 생성
		$("#listReceiveManagement").append(data);
		// 총 갯수 추출
		var receiveCnt = $("#receiveCnt").val();

		console.log("receiveCnt ", receiveCnt);

		// 네비게이션
		//	현재페이지  , 행 갯수 , 리스트사이즈 , 블록 갯수 , 목록리스트함수 
		var oemManageHtml = getPaginationHtml(
			currentPage,
			receiveCnt,
			pageSizeOemList,
			pageBlockSizeOemList,
			'oemList'
		);
		
		console.log("oemManageHtml  : " + oemManageHtml );

		//네비게이션 비우고 다시 채우기
		$("#OemPagination").empty().append( oemManageHtml );
		
		// BizCurrentPage 에 현재 페이지 설정
		$("#receiveCurrentPage").val(currentPage);
		
		// 값이제대로 왔다 확인 
		var receiveCurrentPage = $("#receiveCurrentPage").val();
		console.log("receiveCurrentPage " +  receiveCurrentPage);
	}

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/** 4-1. 단건 조회 */
	function receiveOne(receiveNum, estimateNo, clientCd) {
		var param = {
			receiveNo : receiveNum,
			estimateNo : estimateNo,
			clientCd : clientCd
		};

		var resultCallback = function(data) {
			receiveOneResult(data);
		};

		callAjax("/business/receiveManagementSelect.do", "post", "json", true, param, resultCallback);
	}

	/**  4-2 단건 조회 콜백 함수*/
	function receiveOneResult(data) {
		// 모달 팝업
		gfModalPop("#receiveDetailView");

		// 그룹코드 폼 데이터 설정
		receiveInitForm(data.receivePart);

		// 프로퍼티
		$("#erp_copnm").text(data.erp_copnm);
		$("#erp_copnum").text(data.erp_copnum);
		$("#erp_addr").text(data.erp_addr);
		$("#erp_addrDetail").text(data.erp_addrDetail);
		$("#erp_emp").text(data.receivePart.name);
		$("#erp_tel").text(data.receivePart.tel);

		// 단건조회의 foreach문으로 리스트 뿌리기
		receiveDetailList(data.receivePart.receiveNo, data.receivePart.estimateNo, data.receivePart.clientCd);
	}

	/*  2 .단건조회 등등  모달창 값 초기화  */
	function receiveInitForm(data) {
		$("#estCnt").focus();

		//2 - 2 단건 상세조회 모달창
		var copNo = data.copNo1 + " - " + data.copNo2 + " - " + data.copNo3;

		$("#cliName").text(data.clientNm);
		$("#copNo").text(copNo);
		$("#empNm").text(data.empNm);
		$("#addr").text(data.addr);
		$("#addrDetail").text(data.addrDetail);
		$("#empHp").text(data.empHp);
		$("#receiveDate").text(data.receiveDate);
		$("#bigo").text(data.receiveRemarks);
		$("#UclientCd").val(data.clientCd);
		$("#UestimateNo").val(data.estimateNo);
		$("#UreceiveNo").val(data.receiveNo);

		var loginId1 = <%=(String)session.getAttribute("loginId")%>;
		var loginId2 = data.loginId;

		// 작성자 본인일때만 수정,삭제영역 보임
		if(loginId1 == loginId2) {
			$("#btnDeleteReceive").show();
		} else {
			$("#btnDeleteReceive").hide();
		}
	}

	// 4-3 단건조회의 리스트 뿌리기
	function receiveDetailList(receiveNum, estimate_no, client_cd) {
		var param = {
			receiveNo : receiveNum,
			estimateNo : estimate_no,
			clientCd : client_cd
		}

		//콜백
		var resultCallback = function(data) {
			//목록 조회 결과
			receiveDetailListResult(data);
		};

		/*  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/receiveListDetail.do", "post", "text", true, param, resultCallback); //text
	}

	// 4-4 단건조회의 리스트 뿌리기 콜백
	function receiveDetailListResult(data){
		// 기존 목록 삭제
		$('#receiveDetailList').empty();
		// 신규 목록 생성
		$("#receiveDetailList").append(data);
	}

	//검색구현
	function SearchReceive(currentPage) {
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
		var client_search =   $("#client_search").val();
			
		// 값 내용물 
		console.log("from_date : " + from_date.valueOf());     
		console.log("to_date : " + to_date.valueOf());     
		
        var param = {
        	client_search : client_search,
            currentPage : currentPage,
            pageSize : pageSizeOemList, 
            from_date : from_date, 
            to_date : to_date 
        }
        
	    console.log(" param : " ,param);
		console.log("param.valueOf()",  param.valueOf());
		
		var resultCallback = function(data) {
			console.log("=======resultCallback========");
		
			//목록 조회 결과 
			receiveListResult(data, currentPage);
			console.log(" 검색 조회결과 data ",data);
		};
		
		// 목록조회에 던져준다.
		/*  순서 주의 :  보낼 링크 / 컨트롤러로 보낼 방식 /  받을 방식 ,데이터,, 비동기? 동기,     돌려 줄 함수  */
		callAjax("/business/receiveManagementList.do", "post", "text",  true,param, resultCallback); //text
	}

/* -------------------------------------------------------------------  */
/* -------------------------------------------------------------------  */

	/** 삭제 */
	function receiveInfoDelete() {
		let clientCd = $("#UclientCd").val();
		let estimateNo = $("#UestimateNo").val();
		let receiveNo = $("#UreceiveNo").val();

		let param = {
			clientCd : clientCd,
			estimateNo : estimateNo,
			receiveNo : receiveNo
		}

		let result = confirm("정말 삭제하시겠습니까?");

		if(result) {
			let resultCallback = function(data) {
				console.log("=======여기까지 왔느냐========" + JSON.stringify(data));
				receiveInfoDelete2(data);
			};

			callAjax("/business/receiveInfoDelete.do", "post", "json", true, param, resultCallback);
		} else {
			alert("취소 했습니다.");
		}
	}

	function receiveInfoDelete2(data) {
		alert(data.resultMsg);	// 받은 메세지 출력

		gfCloseModal();
		location.reload();
	}


</script>
</head>
<body>
	<form id="oemForm1" action=""  method="">
		<input type="hidden" id="receiveCurrentPage" value="1">
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
	                     		<span class="btn_nav bold"> 수주서 작성 및 조회 </span> 
	                        	<a href=javascript:location.reload(); class="btn_set refresh">새로고침</a>
	                  		</p>
	
	                  		<p class="conTitle">
	                     		<span>수주서 작성 및 조회</span> 
	                     		<span class="fr"> 
		                     		<a class="btnType blue" href="javascript:receiveModal1();" name="modal">
		                     			<span>수주서 신규등록</span>
		                     		</a>
	                     		</span>
	                  		</p>
	
					        <!-- 검색조회 -->
					        <!-- form 안에 form이 맞나? 버튼두고 자바스크립트로  보내기  자바스크립트 함수 하나 만들기   xxxxxx안하기로 함  -->        
					        <!--  == 콤보박스로 체크  -->   
		     
	                 		<!--검색   -->
	                 		<br>       
				                    
			  				<div style = "padding : 3% 10% 3% 13%  ; border : 3px #CDECFA; border-style : solid ; margin: auto;">
								<!-- 거래처 콤보박스   -->
								<div style ="margin: auto" >	
									<b style ="padding: 0 1% 0 1%" >거래처</b>
									<select name="client_search" id ='client_search'></select>
		                  			<!-- 달력 조회  -->
									<b style ="padding: 0 3% 0 5%">날짜 </b>
									<input type="text" id="from_date"  style="padding : 0.5%;"> ~ <input type="text" id="to_date"  style="padding : 0.5% 0 0.5% 0;" >
						
									<a href="" class="btnType blue" id="btnSearchReceive" name="btn" style ="float : right; ">
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
		                           <col width="7%">
		                           <col width="15%">
	                               <col width="10%">
		                           <col width="18%">
		                           <col width="15%">
		                           <col width="8%">
		                           <col width="7%">
		                           <col width="10%">
		                        </colgroup>

		                        <thead>
		                        	<tr>
										<th scope="col">회사</th>
										<th scope="col">담당자</th>
			                        	<th scope="col">거래처</th>
			                        	<th scope="col">거래처담당자</th>
			                            <th scope="col">수주번호</th>
			                            <th scope="col">수주일자</th>
			                            <th scope="col">총 갯수</th>
			                            <th scope="col">총 합계</th>
			                            <th scope="col"></th>
		                           	</tr>
		                        </thead>
	
		                        <tbody id="listReceiveManagement"></tbody> <!--BizParnerCallBack으로 넘어감.여기는 틀만 만드는곳  -->
                     		</table>
		                  	<!-- 페이징에리어 -->
							<div class="paging_area" id="OemPagination"></div>
						</div>
					</li>
				</ul> 
	            <!-- content end -->
	        </div>
			<h3 class="hidden">풋터 영역</h3>
	        <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
		</div>
		<jsp:include page="/WEB-INF/view/business/ReceiveInfoInsert.jsp"></jsp:include>
	</form>	   
	<jsp:include page="/WEB-INF/view/business/ReceiveManagementModal.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/view/business/ReceiveProdInsert.jsp"></jsp:include>

</body>
</html>
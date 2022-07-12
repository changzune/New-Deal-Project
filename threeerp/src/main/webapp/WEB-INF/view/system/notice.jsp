<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>



<script type="text/javascript">
//화면 페이징 변수 
var pagesize = 10; // 화면에 보여질 데이터 수 
var pagenavisize = 5; // 페이징 처리 수 

// DOM이 로드되었을 때 실행되는 코드
$(document).ready(function() {

	fn_dateset(this); 
	fn_noticelist();
	fNoticeButtonClickEvent();
	
});	

// 날짜 셋팅 함수 , 날짜선택시 onchange()로 호출되는 함수 
function fn_dateset(e){
	
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth();
	month += 1;
	if (month <= 9){
	    month = "0" + month;
	}
	var day = date.getDate();
	console.log(day);
	if (day <= 9){
	    day = "0" + day;
	}
	var today = year + '-' + month + '-' + day;
	
	console.log(day);
//오늘 날짜를 '00-00-00'형태로 변수에 저장   


	var dateID =e.id;
	var date =e.value;
	$("#today").val(today);
	
	if(date == "" || date == undefined){ 
//페이지로드되는 시점 or 검색조건의 날짜 삭제버튼 누른 시점에서 날짜 min,max초기화 
		
		$("#to_date").attr("max",today); 
		$("#to_date").attr("min",""); 

		$("#from_date").attr("max",today);
		$("#from_date").attr("min");
	
	}
//입력값을 받은 ID에 따라, min,max 설정
	else if(dateID == "from_date"){	
		
		$("#to_date").attr("min", date); 
		
	}
	else if( dateID == "to_date"){
		console.log(e.value);
		$("#from_date").attr("max", date);
	}		
} 	

	/* 검색, 저장, 닫기, 수정, 삭제 튼. 모달 팝업 창 내의 버튼 id를 얻음 해당 버튼클릭시 실행해야하는 것들 호출*/
	function fNoticeButtonClickEvent() {
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
//기본동작 취소. a 태그를 클릭해도 원하는 href링크로 이동하지 않게 함. form 요소 안 button태그의 클릭이벤트 발생시 submit 동작이 기본적으로 발생. 페이지가 리로드가 되는 현상을 막아줌

			var btnId = $(this).attr('id');

			switch (btnId) {
			
			case 'search_btn' : //신규등록 버튼 클릭 1. null 처리 2. 검색리스트 불러오는 함수 호출 
				fn_searchnull();
				fn_noticelist();
				break;
					
			case 'btnSave': // 저장 버튼 클릭 
				fn_noticeSave();
				break;

			case 'btnClose': //닫기 버튼 클릭 
				gfCloseModal();
				break;

			case 'btnDelete'://삭제 버튼 클릭 
				fn_deleteNotice();
				break;
				
			case'btnUpdate'://수정 버튼 클릭 
				fn_noticeSave();
			
			}
		});
	}
	
	/* 검색 입력값이 없을 시, alert 하는 함수 */
	function fn_searchnull(){
		
		var search_option =  $("#search_option").val();
		var search_text = $("#search_text").val();
		var toDate = $('#to_date').val();
		var fromDate = $('#from_date').val();
		<!-- 검색어를 입력하지 않았을 시-->
		if(search_option == "" &&  search_text == "" ){
			if(toDate != "" || fromDate != ""){
					return;
				}
			swal(" 검색어를 입력해주세요 ");
		}
		else if(search_option != "" && search_text == "")
			swal(" 검색어를 입력해주세요 ");
	}
	
	/* 공지사항 리스트 불러오기 */
	function fn_noticelist(pagenum) {
		
		pagenum = pagenum || 1;		
		
		
		var search_option =  $("#search_option").val();
		var search_text = $("#search_text").val();
		var toDate = $('#to_date').val();
		var fromDate = $('#from_date').val();
		var today = $("#today").val();
	
		
		var param = {
			search_option : search_option,
			search_text : search_text,
			pagenum : pagenum,
    		pagesize : pagesize,
    		fromDate : fromDate,
    		toDate : toDate,
    		today : today
		
		}
	
		
		var notice_callback = function(returndata) {
		
			fn_listcallback(returndata, pagenum);
		}

		callAjax("/system/noticeList.do", "post", "text", true, param,notice_callback);
				// 호출 할 부분  / 보내는 방식 / 컨트롤러에 리턴받는 타입 / async 방식 / 전송될 파라미터 / 응답 받자마 실행할 함수 
				//async 방식이면 true.  jsp 컨트롤러에 요청받을 때 응답받을때까지 기다리는 방식 
				//AJAX 공통 메소드 WEB-INF/resource/js/commonAjax.js
				
				
				}
	
	
	/*  공지사항 리스트 불러오기의 콜백함수 */
	function fn_listcallback(returndata, pagenum) {

		// 리스트 변경시, 기존목록을 삭제. 리스트의 총 개수 구함. 페이지 네비게이션 생성. 기존 목록에 append. 현재 페이지 설정 
		$("#notice_list").empty().append(returndata);
		var totalcnt = $("#totalcnt").val();
	
		var paginationHtml = getPaginationHtml(pagenum, totalcnt, pagesize,pagenavisize, 'fn_noticelist'); 
		
		 // * 페이지 네비게이션 생성 (공통함수 사용 -common.js) 현재페이지,총 건수,페이지당 보여지는 목록 갯수 , 페이지 번호 갯수, 페이지 번호를 클릭하면 호출할 함수 객체,pageFunc에 넘겨줄 추가적인 파라미터(optional)
		 // function getPaginationHtml(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
		
		
		$("#notice_paging").empty().append(paginationHtml); 

		$("#pagenum").val(pagenum);
		
		
	}
	/*  공지사항 단건조회 함수  */
function fn_selectnotice(no){
	$("#notice_no").val(no);
	 var writer=$("#modal_id").val();
	
	var param = {		
			no : no,
			writer : writer
	}
	// 공지사항 게시번호,작성자 
	
	var selectOneCallback = function(returndata){
		fn_selectone(returndata);
	}
	
	callAjax("/system/noticeSelectOne.do", "post", "json", true, param,selectOneCallback);
			
}

/* 단건조회 콜백함수 */
function fn_selectone(returndata){
	
	//모달에 정보를 넣고, 띄우기 
	fn_modalInit(returndata.result);
		 gfModalPop("#writeform");
	
	
}


/* 정보에 따른 모달창 초기화 */
function fn_modalInit(object){
	
	var userID = $("#writer_id").val();
 	//로그인 한 유저의 ID 값 
 	
 	// 신규등록일 때 모달창 
	 if(object == "" || object == null || object == undefined){
		
		 var loginID=$("#writer_id").val();
		
			// 작성자의 user의 loginID값을 넣고 읽기전용으로 변경. 제목,내용 값을 초기화 후 저장, 취소버튼만 보여주기
			// action의 형태는 INSERT임으로 I 값을 넣어줌 
			$("#modal_id").val(loginID);
			$("#modal_id").attr("readonly",true);
    		$("#noticeno").val("");
		 	$("#modal_title").val("");
			$("#modal_cont").val("");
			$("#btnSave").show();
			$("#btnUpdate").hide();
			$("#btnDelete").hide();
			$("#action").val("I");
			
			
	 }else if(object.loginID != userID){
		//  1)유저와 작성자가 다를 경우, 수정,삭제 버튼 숨기고 readonly
		 
		 		
	 			$("#modal_id").val(object.loginID);
	 		   	$("#modal_title").val(object.title);
	 			$("#modal_cont").val(object.contents);
	 			$("#noticeno").val(object.contents);
	 			
	 			$("#modal_id").attr("readonly",true);
	 			$("#modal_title").attr("readonly",true);
	 			$("#modal_cont").attr("readonly",true);
	 			
	 			$("#btnSave").hide();
	 			$("#btnDelete").hide();

	 			
	 			
	 		} else{ // 2)유저와 작성자가 같을 경우, 수정, 삭제 가능 action 값은 Update 의 U 
	 		
	 
	
			$("#modal_id").val(object.loginID);
			$("#modal_title").val(object.title);
			$("#modal_cont").val(object.contents);
			$("#noticeno").val(object.contents);
			
			$("#modal_id").attr("readonly",true);
			$("#btnUpdate").show();
			$("#btnSave").hide();
			$("#btnDelete").show();
			$("#action").val("U");
				
		 
	 	}
	 
	
}

/* 신규작성 모달창 함수 수정은 U 신규는 I */
function fn_writemodal(notice_no){
	
	
	if(notice_no == null || notice_no == ""){ // 신규등록일때 
		
		$("#action").val("I"); 
		//화면초기화
		fn_modalInit(notice_no); // 초기화
		gfModalPop("#writeform");
		
		
	}else{ //수정일때 
		
		 fn_selectnotice(notice_no);
		 $("#action").val("U"); 
		
	}
}

/* 팝업내 수정, 저장 validation 함수 */
function fValidatePopup(){
	 var chk = checkNotEmpty(
			 [
				 ["modal_title", "제목을 입력해주세요!"],
				 ["modal_cont", "내용 입력해주세요!"]
			 ]
	 );

	if(!chk){return;}
	return true;
}

/* 공지사항 저장 */
function fn_noticeSave(){
	
	if(!(fValidatePopup())){
		return;
	}
	var title =  $("#modal_title").val();
	var contents = $("#modal_cont").val();
	var action =  $("#action").val();
	var no =  $("#notice_no").val();

	
	var param = {		
			title : title,
		   contents : contents,
			action :action,
			no : no			
	}
	
	var saveCallback = function(returndata){
		fn_saveResult(returndata);
	}
	
	callAjax("/system/noticeSave.do", "post", "json", true, param,saveCallback);
			
}




/* 저장, 수정, 삭제 콜백 함수 */ 
function fn_saveResult(returndata){
	
	//결과값에 따른 sweet alert 메시지 
	if(returndata.result == "SUCCESS"){
		swal("저장되었습니다.");
	}else if(returndata.result == "UPDATED"){
		swal("수정되었습니다.");
	}else if(returndata.result == "DELETED"){
		swal("삭제 되었습니다.");
	}
	
	gfCloseModal();
	fn_noticelist();
	fn_modalInit();
	//모달 닫기,리스트 초기화,모달 초기화 
	
}

/* 공지사항 수정 */
function fn_updateNotice(){

	
	if(!confirm("수정 하겠습니까?")) {
		return;
	}
	
	if(!(fValidatePopup())){
		return;
	}
	
	
	var updateCallback = function(returndata){
		
		fn_saveResult(returndata);
	}
	
	callAjax("/system/noticeSave.do", "post", "json", true, param,updateCallback);
	
	
}

/* 공지사항 삭제 */
function fn_deleteNotice() {
	
	
	
	if(!confirm("삭제 하겠습니까?")) {
		return;
	}
	
	$("#action").val("D");
	
	var no =  $("#notice_no").val();

	var param = {
			no : no,
			action : "D"
	}
	
	var deletecollaback = function(returndata) {
	  
	
		fn_saveResult(returndata);
	    
  }	
	
  callAjax("/system/noticeSave.do", "post", "json", true, param, deletecollaback);   	
}

	


	
</script>



</head>
<body>

	<form id="noticelistform" action="" method="">
		<!-- 게시판 번호/ 등록인지 수정인지 알수있는 플래그값 /현재페이지,action값, 공지사항 번호,로그인한 유저 ID,오늘 날짜-->
		<input type="hidden" id="pagenum" value="">
		<input type="hidden" id="pagenum" value="">
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="notice_no" id="notice_no" value=""> 
		<input type="hidden" id="writer_id" value="${loginId}"> 
		<input type="hidden" id="today" value="">
		<!--   일반적인 사용자들에게는 노출되지 않는 영역이지만 서버에 특정 값을 넘길 때 사용한다.-->
		<!-- 모달 배경 -->
		<div id="mask"></div>

		<div id="wrap_area">

			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->

						<h3 class="hidden">contents 영역</h3>
						<div class="content">

							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span class="btn_nav bold">시스템관리</span> <span class="btn_nav bold">공지사항</span>
							</p>

							<p class="conTitle">
								<span><a href="../system/notice.do">ERP공지사항</span></a>
							</p>



							<div style="float: right; witdh: 100%; margin-top: 10px; margin-bottom: 30px;">
								<c:set var="nullNum" value=""></c:set>
								<a href="javascript:fn_writemodal(${nullNum});" class="btnType blue" id="write_btn" name="modal"><span>신규 작성</span></a>
							</div>


							<!--검색창  -->

							<table style="clear: both; width: 100%; cellpadding: 5; cellspacing =: 0; border: 1; text-align: center; collapse; border: 1px #50bcdf;">
								<tr style="border: 0px; border-color: blue;">
									<td>
										<select name="search_option" id="search_option">
											<option value="" selected>선택</option>
											<option value="search_title">제목</option>
											<option value="search_name">작성자</option>
										</select>
									</td>
									<td>날짜</td>
									<td>
										<input type="date" id="from_date" onchange="fn_dateset(this)"> <input type="date" id="to_date" onchange="fn_dateset(this)">
									</td>
									<td>
										<input style="width: 300px; height: 25px;" id="search_text" name="">
									</td>
									<td>
										<a href="" class="btnType blue" id="search_btn" name="btn"><span>검색</span></a>
									</td>
								</tr>
							</table>
							<!--검색창  -->

							<!--목록 리스트-->
							<div>
								<table class="col" style="margin-top: 20px;">
									<caption>caption</caption>
									<colgroup>
										<col width="6%">
										<col width="54%">
										<col width="20%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">제목</th>
											<th scope="col">작성자</th>
											<th scope="col">날짜</th>
										</tr>
									</thead>
									<tbody id="notice_list"></tbody>
								</table>
							</div>
							<!-- 페이징 처리  -->
							<div class="paging_area" id="notice_paging"></div>

















						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!--// 모달팝업 -->

		<div id="writeform" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>공지사항</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="100px">
							<col width="200PX">
							<col width="100px">
						</colgroup>

						<tbody>
							<tr>
								<th scope="row">작성자 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="inputTxt p200" name="writer" id="modal_id"></input>
								</td>
							</tr>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea id="modal_title" name="title"></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea id="modal_cont" name="cont"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> <a href="" class="btnType blue" id="btnUpdate" name="btn" style="display: none"><span>수정</span></a> <a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> <a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>


		</div>


	</form>
</body>
</html>
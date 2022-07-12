<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link href="/css/accounting/acctitle.css" rel="stylesheet"
	type="text/css" />
<!--아이콘CDN  -->
<script src="https://kit.fontawesome.com/2c827c8cca.js"
	crossorigin="anonymous"></script>
<!-- sweet swal import -->
<script>
var pagesize = 15;
var pagenavi = 5;


$(document).ready(function(){

	fn_ListAcctitle();
	
	//fRegisterButtonClickEvent();
	
	$("#accSmall").change( function() {			
		AcctitleCombo("REVEXPcd", "payment", "all", $("#accSmall").val(),"");   // 구분
		
	});

	$("#bigSelect").change( function() {			
		AcctitleCombo("acc", "accSmall", "all", $("#bigSelect").val(),"");    // 계정 세부목록
	});			
		 $('#payment').children('option').remove();
	
	AcctitleCombo("ACCcd","bigSelect","all","","");   // 계정 대분류
	
	});
	
//----------------------콤보박스 계정대분류, 계정 세부목록, 구분 -------------------------------------------------
	function AcctitleCombo(comtype, combo_name, type, searchkey,selvalue){
		console.log("AcctitleCombo 시작 !! ");
		var selectbox = document.getElementById(combo_name);
		
		var data = {
				"comtype" : comtype,
				"searchkey" : searchkey 
	};
		$(selectbox).find("option").remove();
		$.ajax({
			type: "POST",
			url: "/accounting/AcctitleCombo.do",
			dataType: "json",
			data : data,
			success: function(data) {
				//data를 JSON문자열로 변환할 값 parseJSON 빈문자열,null또는 undefined를 오류대신 null값으로 반환		
				var json_obj = $.parseJSON(JSON.stringify(data));
				var jsonstr = json_obj.list;
				console.log("jsonstr은 : " + jsonstr);
				
				var jsonstr_obj = $.parseJSON(JSON.stringify(jsonstr));//parse JSON
				var listLen = jsonstr_obj.length;
				
				if(type == "all") {
					$(selectbox).append("<option value=''>전체</option>");
				}

				if(type == "sel") {
					$(selectbox).append("<option value=''>선택</option>");
				}
				
				console.log(" selvalue은 : " + selvalue +"입니다. ");
				for(var i = 0; i < listLen; i++) {
					var eleString = JSON.stringify(jsonstr_obj[i]);
					var item_obj = $.parseJSON(eleString); //parse JSON
					
					if(selvalue != null && selvalue != null && selvalue != "") {
						if(selvalue == item_obj.dtl_cod) {
							console.log(" item_obj.cd : " + item_obj.cd);

							$(selectbox).append("<option value='"+ item_obj.cd + "' selected>" + item_obj.name + "</option>");
						} else {
							$(selectbox).append("<option value='"+ item_obj.cd + "'>" + item_obj.name + "</option>");
							console.log("1111");
						}
					} else {
						 $(selectbox).append("<option value='"+ item_obj.cd + "'>" + item_obj.name + "</option>"); 
						/*  $(selectbox).append("<option value='"+ item_obj.name + "'>" + item_obj.cd + "</option>");  */
						console.log("2222");
					}
				}
				$(selectbox).val(selvalue);
				console.log("selvalue"+selvalue);
			   },
			   error:function(request,status,error){ alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); }
			});
		};	

	
//-----------------------전체목록 조회------------------------------------------------------------------
	function fn_ListAcctitle(pagenum) {

		pagenum = pagenum || 1; //초기화

		var bigSelect = $("#bigSelect").val();
		var accSmall = $("#accSmall").val();
		var payment = $("#payment").val();
		var useYn = $("#useYn").val(); 

		console.log("여기 맞지? pagenum : " + pagenum);

		var param = {
			pagenum : pagenum,
			pagesize : pagesize,
			bigSelect : bigSelect,
			accSmall : accSmall,
			payment : payment,
			useYn : useYn

		}
		console.log(param);

		var listcallback = function(returndata) {

			fn_listcallback(returndata, pagenum);
		}

		callAjax("/accounting/acctitleList.do", "post", "text", true, param,
				listcallback);

	}
	function fn_listcallback(returndata, pagenum) {
		console.log("콜백함수는fn_listcallback는 " + returndata + "입니다.");

		//기존목록 삭제 및 신규 목록 생성
		$("#listAcctitle").empty().append(returndata);
		var totalcnt = $('#totalcnt').val();

		//페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(pagenum, totalcnt, pagesize,
				pagenavi, 'fn_ListAcctitle');
		console.log("paginationHtml는" + paginationHtml + "입니다.");
		$("#AccPagination").empty().append(paginationHtml);

		//현재 페이지 설정
		$("#pageAcctitle").val(pagenum);
		console.log("전체 총개수 totalcnt는 " + totalcnt + "입니다.");
		
	}

//-----------------------단건 조회-------문제ㅜㅜ-----------------------------------------------------------
//가공된 데이터값을 추출해서 update하려면?
	function fn_selectOne(bigSelect, accSmall) {
		
	
		var param = {
				bigSelect : bigSelect ,
				accSmall : accSmall
			};
		
		console.log(bigSelect, accSmall);
		console.log("여기까지만 나옴");
		
		var selectOneCallback = function(data) {
			selectOneResult(data);
		};
		callAjax("/accounting/selectOne.do", "post", "json", true, param,selectOneCallback);
		
	}
	
	//단건 조회 콜백
	function selectOneResult(data) {
		
		console.log("selectOneResult :"+ JSON.stringify(data));
		
		//모달에 정보를 넣고, 띄우기 
		fn_initModalform(data.resultOne);
			 gfModalPop("#Modalform2");
	
	}
	
	//단건 조회 초기화
	function fn_initModalform(object){
		
		$("#M2bigSelect").val(object.bigSelect);
		/* $("#M2bigSelect").attr("readonly",true); */
		
		$("#M2accSmall").val(object.accSmall);
		$("#M2note").val(object.note);
		$("#M2useYn").val(object.useYn);
		$("#M2payment").val(object.payment);
		
		
		
//		alert(object.accSmall);
		//세부코드 문자열
		var str = object.accSmall;		
		var accSmall_cd = str.slice(-4,str.length-1);				
		$("#accSmall_cd").val(accSmall_cd);
		
		//payment가 안나옴
		
		
		//console.log("object.account_type_cd : " + object.account_type_cd);
		//alert("object.account_type_cd : " + object.account_type_cd);
		
}
	//새 계정과목 수정하기
	function fn_update(){
	   
		var accSmall = $("#M2accSmall").val();   
		var note = $("#M2note").val();   
		var useYn = $("#M2useYn").val();
		var payment = $("#M2payment").val();
		
		var account_cd = $("#M2bigSelect").val();
		var accSmall_cd = $("#accSmall_cd").val();
		
		$("#action").val("D");
		
 		//alert($("#accSmall_cd").val());
 		
 		account_cd = account_cd.slice(-5,length-1);
 		
		
		//if(!fValidate()) return;
			
		if(
		   accSmall != null &&
		   useYn != null &&
		   payment != null &&
		
		   accSmall != '' &&
		   useYn != ''&&
		   payment != '' 
		){
			
			
        var param = {
        		
       		   accSmall : accSmall
       		   ,note : note
       		   ,useYn : useYn
       		   ,payment : payment
       		   ,account_cd : account_cd
       		   ,accSmall_cd : accSmall_cd
        	}
       
        var resultCallback = function(param) {
       	 fModalResult2(param);
        	};
        
        callAjax("/accounting/acctitleUpdate.do", "post", "json", true, param, resultCallback); //text로 고쳐서!!
		}
	
		else{alert("작성이 완료되지 않았습니다.")}
     }
 
	function fValidate() {

		var chk = checkNotEmpty(
				[
						[ "accSmall", "상세코드명을 입력해 주세요." ]
					
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}	
//------------------------------------------------------------------------------------------------------------------------
	//모달 결과 
	function fModalResult2(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfCloseModal();
			alert(data.resultMsgYes);
			fn_ListAcctitle();

		} else {
			gfCloseModal();
			alert(data.resultMsg);
		}

	}
	
	//모달 결과 
	function fModalResult(data) {

		if (data.result == "게시글 작성을 성공하였습니다.") {

			// 모달 팝업
			gfCloseModal();
			alert(data.result);
			fn_ListAcctitle();

			$("#accSmall").val("");
			$("#note").val("");

		} 
		
		else {
			gfCloseModal();
			alert(data.result);
		}

	}
	
//-----------------------계정과목 등록하기----------------------------------------------

function fn_reg(){
	
	var bigSelect2 = $("#bigSelect2").val();  //대분류코드
	var accSmall2 = $("#accSmall2").val();   //계정세부명
	var payment2 = $("#payment2").val();     // 수입지출구분
	var note2 = $("#note2").val();   //세부내용
	var useYn2 = $("#useYn2").val();   //사용유무
	
	
     var param = {
    		 bigSelect2 : bigSelect2
    		 ,accSmall2 : accSmall2
    		 ,payment2 : payment2
    		 ,note2 : note2
    		 ,useYn2 : useYn2
    		 
     	}
     
     var resultCallback = function(param) {
    	 fModalResult(param);
    	 
     	};
    
     callAjax("/accounting/acctitleWrite.do", "post", "json", true, param, resultCallback);
	

	 	
}

//등록 모달창 띄우기
function fPopModalAccEnroll(){
		gfModalPop('#Modalform1');
	}
	
//-----------삭제하기--------------------------------------------------------//
	
function fn_delete(account_cd1, detail_account_cd1){
	   
		//alert("뜨나요?")
 		
 		var account_cd = account_cd1.slice(-5,length-1);		
		var accSmall_cd = detail_account_cd1.slice(-4,length-1);
			
        var param = {

       		   account_cd : account_cd
       		   ,accSmall_cd : accSmall_cd
        	}
        
		swal("선택된 정보를 삭제하시겠습니까?", {
			buttons : {
				yes : "예",
				no : "취소"
			}
		}).then((value) => {
			switch(value){
			case "yes" :
				var resultCallback = function(data){
				acctitleDeleteResult(data);
				};
				
				callAjax("/accounting/acctitleDelete.do", "post", "json", true, param, resultCallback);
				
				break;
			case "no" :
				break;
			}
		});
	}
              
function acctitleDeleteResult(data){
		if(data.result == "SUCCESS"){
			swal(data.resultMsg);
			gfCloseModal();
			fn_ListAcctitle();
				
		}else {
			swal("정보삭제에 실패하였습니다.");
			}
		}
	
</script>
</head>
<body>

<form id="AccHiddenform" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="account_cd" id="account_cd" value="">
<!-- 	<input type="hidden" name="detail_account_cd" id="detail_account_cd" value=""> -->
	
	<input type="hidden" name="accSmall_cd" id="accSmall_cd" value="">
	
   
		
		
	<!-- 계정과목 초기화면 -->
	<div id="mask"></div>
	
	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
				</li>

				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav">회계</span> <span class="btn_nav bold">
								<a href="/accounting/acctitle.do">계정과목관리</a>
							</span>
						</p>



						<p class="conTitle">
							<a href="/accounting/acctitle.do"><span>계정과목관리</span></a>
						</p>


						<div class="optionBoxHeader">
							<ul>
								<li><strong>계정 대분류</strong> <select id="bigSelect"
									name="bigSelect"></select></li>

								<li><strong>계정 세부목록</strong> <select id="accSmall"
									name="accSmall">
								</select></li>

								<li><strong>구분</strong> <select id="payment" name="payment">
								</select></li>

								<li><strong>사용여부</strong> 
								<select id="useYn" name="useYn">
								<option value="" selected>전체</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
								</select></li>
								
							</ul>
							<div class="btn-primary-group">
								<a href="javascript:fn_ListAcctitle()"class="btn btn-primary" id="btnSearch" type="button">조회</a> 
								<a href="javascript:fPopModalAccEnroll()" class="btn btn-primary" id="btnRegister" type="button">등록</a>
							</div>
						</div>
					
						<div class="divAcctitleList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="8%">
									<col width="25%">
									<col width="8%">
									<col width="*%">
								</colgroup>

								<thead>
									<tr>
										<th scope="col">계정 대분류명</th>
										<th scope="col">계정 세부명</th>
										<th scope="col">구분</th>
										<th scope="col">상세 내용</th>
										<th scope="col">사용여부</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listAcctitle"></tbody>
							</table>

							<div class="paging_area" id="AccPagination"></div>


						</div>

						<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
						
						
<!-------------------------------------------   모달 등록팝업   --------------------------------------------->
							<div id="Modalform1" class="layerPop layerType2">
								<dl>
								<dt>
										<strong>계정과목 등록</strong>
								</dt>	
									
									<dd class="content">
										<!-- s : 여기에 내용입력 -->
										<table class="row">
											<caption>caption</caption>
											<colgroup>
												<col width="120px">
												<col width="120px">
												<col width="*">
												<col width="*">
												<col width="*">
											</colgroup>
											
										<!-- 모달 --> 
											<tbody>
												<tr>
													<th scope="row">계정 대분류명 <span class="font_red">*</span></th>
													<td colspan="5"><select id="bigSelect2" name="bigSelect2">
															<option value="A100" selected>온라인매출(A100)</option>
															<option value="B200">영업매출(B200)</option>
															<option value="C300">급여(C300)</option>
															<option value="D400">복리후생비(D400)</option>
															<option value="E500">접대비(E500)</option>
															<option value="F600">통신비(F600)</option>
													</select>
													</td>
												</tr>

												<tr>
													<th scope="row">계정 세부명 <span class="font_red">*</span></th>
													<td colspan="5"><input type="text" class="inputT p100" name="accSmall2" id="accSmall2" 
													style="padding-top: 4px; padding-bottom: 4px;"/></td>
												</tr>

												<tr>
													<th scope="row">구분</th>
													<td colspan="5"><select id="payment2" name="payment2" style="width: 100px;">
															<option value="1" selected>수입</option>
															<option value="2">지출</option>
													</select></td>
												</tr>

												<tr>
													<th scope="row" >상세내용</th>
													<td colspan="5"><textarea id="note2" name="note2"></textarea></td>
												</tr>
												
												<tr>
													<th scope="row" >사용여부</th>
													<td colspan="5"> <select id="useYn2" name="useYn2" style="width: 100px;">
															<option value="Y" selected>사용</option>
															<option value="N">미사용</option>
															</select>
														</td>	
												</tr>
								
											</tbody>
										</table>
										<!-- 모달 창에서 사용하는 버튼-->
										<div class="btn_areaC mt30">
											<a href="javascript:fn_reg();" class="btnType blue" id="btnInsert" name="btn"><span>저장</span></a>
											<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
										</div>
									</dd>
									</dl>
								<a href="" class="closePop"><span class="hidden">닫기</span></a>
							</div>
							
<!-------------------------------------------   모달 수정팝업   --------------------------------------------->
							
			<div id="Modalform2" class="layerPop layerType2" style="width: 550px; height:340px;">
       <dl>
         <dt>
            <strong>계정과목 삭제</strong>
         </dt>
         <dd class="content">
            <!-- s : 여기에 내용입력 -->
            
            <table class="row">
               <caption>caption</caption>
               <colgroup>
                  <col width="120px">
                  <col width="*">
                  <col width="120px">
                  <col width="*">
                  <col width="*">
               </colgroup>

               <tbody>
                  <tr>
                     <th scope="row">계정 대분류명</th>
                     <td colspan="5"><input type="text" class="inputT p100" name="M2bigSelect" id="M2bigSelect" 
                     style="background-color:#DCE1E6; padding-top: 4px; padding-bottom: 4px;" readonly /></td>
                  </tr>
                  
                  <tr>
                     <th scope="row">계정 세부명 <span class="font_red">*</span></th>
                     <td colspan="3"><input type="text" class="inputT p100" name="M2accSmall" id="M2accSmall" style= "background-color:#DCE1E6; padding-top: 4px; padding-bottom: 4px;"/></td>
                  </tr>
                  <!-- <tr>
                     <th scope="row" >계정 세부코드</th>
                     <td colspan="5"><input type="text" class="inputT p100" name="M2accSmall_cd" id="M2accSmall_cd" style="background-color:#DCE1E6" readonly /></td>
                  </tr> -->
                  <tr>
                     <th scope="row">상세내용</th>
                     <td colspan="5"><input type="text" class="inputT p100" name="M2note" id="M2note" style="padding-top: 4px; padding-bottom: 4px;"/></td>
                  </tr>
                
                <tr>
                     <th scope="row">구분</th>
                     <td colspan="5">
                     	<select id="M2payment" name="M2payment" >
    						<option value="1" selected>수입</option>
   						    <option value="2" >지출</option>
  						</select>
  					 </td>
                  </tr>
                  
                    <tr>
                     <th scope="row">사용여부</th>
                     <td colspan="5">
                     	<select id="M2useYn" name="M2useYn" >
    						<option value="Y" selected>사용</option>
   						    <option value="N" >미사용</option>
  						</select>
  					 </td>
                  </tr>
                  
                  
               </tbody>
               
            </table>

            <!--계정과목 수정모달창 수정버튼 -->

            <div class="btn_areaC mt30">
              <a href="javascript:fn_update();" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a> 
              <!-- <a href="javascript:fn_update();" class="btnType blue" id="btnDelete" name="btn" ><span>삭제</span></a> -->
              <a href="" class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
            </div>
         </dd>
      </dl>
       <a href="" class="closePop"><span class="hidden">닫기</span></a>
       </div>
       
	</form>
</body>
</html>
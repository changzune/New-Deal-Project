<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">

	var pagesize = 10; 
	var pagenavisize = 5; //네비게이션 밑에 페이지 숫자
    
   $(document).ready(function(){
	   
	   fn_ListBmSalePlan();
	   
	
	$("#plall").change( function() {			
		productCombo("m", "pmall", "all", $("#plall").val(),"");  // 제품 중분류 
		
		$('#product_cd').children('option').remove();
	});

	$("#pmall").change( function() {			
		productCombo("p", "product_cd", "all", $("#pmall").val(),"");   // 제품 목록 
	});			
	
	productCombo("l","plall","all","","");   // 제품 대분류
	
	
	
   }); 	
  
	
  
   function fn_ListBmSalePlan(pagenum){
	   
	   pagenum = pagenum || 1; //초기화
	   
	  
	    var sales_reg_date = $("#sales_reg_date").val();		
		var loginID_header = $("#loginID_header").val();
		var l_ct_cd = $("#plall").val();
		var m_ct_cd = $("#pmall").val();
		var product_cd = $("#product_cd").val();
	   
		console.log("pagenum : " + pagenum);
	   
	   var param ={   								//(controller에서 쓰는) key:(실제)value
			   pagenum : pagenum,
			   pagesize : pagesize,
			   sales_reg_date : sales_reg_date,
			   loginID_header : loginID_header,//아이디
			   l_ct_cd	 : l_ct_cd,
			   m_ct_cd	 : m_ct_cd,
			   product_cd : product_cd	
			   
	   }
	   
	   console.log(param);
	   
	   //callback ajax미리 선언하기(결과치를 받자마자 함수형으로 선언)
		var listcallback = function(returndata){
		    fn_listcallback(returndata,pagenum); //callback받자마자 함수 실행  
	   }	   
	   
	//Ajax실행 방식
	//callAjax("Url(user define)",post or get,return타입(목록뿌릴때만 html이니깐 text 그 외엔 json),
	//async방식이면 true,파라미터이름,응답받자마자 실행 할 Callback함수)
	callAjax("/business/listBmSalePlan.do","post","text",true,param,listcallback);
	   
   }
   		/** 그룹코드 조회 콜백 함수 */
   		function fn_listcallback(returndata,pagenum){
   			//callback받자마자 찍을 텍스트 형태 returndata
   			console.log("콜백함수는fn_listcallback는 "+ returndata+"입니다.");
   			
   			//기존목록 삭제 및 신규 목록 생성
   			$("#listBmSalePlan").empty().append(returndata);
			
   			//전체 총 개수 추출
   			var totalcnt = $("#totalcnt").val();
   			
   			// 페이지 네비게이션 생성
   			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pagesize, pagenavisize, 'fn_ListBmSalePlan');
   			console.log("paginationHtml는" + paginationHtml+"입니다.");
   			//alert(paginationHtml);
   			$("#bmSalePlanPagination").empty().append( paginationHtml );
   			
   			 //현재 페이지 설정
   			$("#PageBmSalePlan").val(pagenum);
   			 
   			console.log("전체 총개수 totalcnt는 " + totalcnt +"입니다.");
   		}
   			
</script>

<style type="text/css">

		#bmSalePlanHeader li{
			float : left;
			width : 180px;
			margin-right : 20px;
			margin-bottom : 10px;
		
		}
		
</style>

</head>
<body>
   <!-- 모달 배경 -->
   <div id="mask"></div>

   <div id="wrap_area">

      <h2 class="hidden">header 영역</h2>
      <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

      <h2 class="hidden">컨텐츠 영역</h2>
      <div id="container">
         <ul>
            <li class="lnb">
               <!-- lnb 영역 --> <jsp:include
                  page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
            </li>
            <li class="contents">
               <!-- contents -->
               <h3 class="hidden">contents 영역</h3> <!-- content -->
               <div class="content">

                  <p class="Location">
                     <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
                     <span class="btn_nav"><a href="/business/empSalePlan.do">영업</a></span> 
                        <span class="btn_nav bold"> <a href="/business/bmSalePlan.do">영업실적조회</a></span>
                        
                  </p>
                  
                  	<p class="conTitle">
						<span> <a href="/business/bmSalePlan.do">영업실적조회</a></span>

						<span class ="fr">
						<a class="btnType blue"
									href="javascript:fn_ListBmSalePlan()" name="search">
									<span id="searchEnter">조회</span></a><br/>
								
						</span>
					</p>

						<div id="bmSalePlanHeader" >
							<ul>
								<c:if test="${userType eq 'B'}">

									<li><strong>아이디</strong> <input type="text"
										class="inputTxt p100" name="loginID_header"
										id="loginID_header" />
									</li>

								</c:if>

								<li><strong>대분류명</strong> <select id="plall" name="plall">
									
								</select>
								</li>

								<li><strong>중분류명</strong> <select id="pmall" name="pmall">
									
								</select>
								</li>

								<li><strong>제품명</strong> <select id="product_cd" name="product_cd"></select>
								</li>

								<li><strong>계획등록일</strong></br>
								<input type="date" id="sales_reg_date"/>
								</li>

							</ul>
						</div>

						<div class="divBmSalePlanList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="*%">
									<c:if test="${userType eq 'B'}">
										<col width="*%">
									</c:if>
									<col width="*%">
									<col width="*%">
									<col width="*%">
									<col width="*%">
									<col width="*%">
									<c:if test="${userType eq 'B'}">
										<col width="*%">
									</c:if>
									<col width="*%">

								</colgroup>

							
							<thead>
								<tr>
									<th scope="col">계획등록일</th>
									<c:if test="${userType eq 'B'}">
										<th scope="col">아이디</th>
									</c:if>
									<th scope="col">대분류명</th>
									<th scope="col">중분류명</th>
									<th scope="col">제품명</th>
									<th scope="col">목표수량</th>
									<th scope="col">실적수량</th>
									<c:if test="${userType eq 'B'}">
										<th scope="col">달성률(%)</th>
									</c:if>
									<th scope="col">비고</th>
								</tr>
								
							</thead>
							
							<tbody id="listBmSalePlan">
								</tbody> 
							
							</table>
							
						</div>
						<div class="paging_area"  id="bmSalePlanPagination"> </div>
						
						
				</div> <!--// content -->

               <h3 class="hidden">풋터 영역</h3>
               <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
            </li>
         </ul>
      </div>
   </div>

   <!--// 모달팝업 -->
</body>
</html>
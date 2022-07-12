<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SamplePage8</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">


    $(document).ready(function() {
       
    	$("#accall").change( function() {			
			selectComCombo("acc", "accdall", "all", $("#accall").val(),"");   // acc : 계정상세코드 정보
		});
		comcombo("ACCcd", "accall", "all", "");   // 계정 대분류 코드 Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  
		selectComCombo("cli", "cilall", "all", "","");    // cli : 거래처
		selectComCombo("pro", "proall", "all", "","");  // pro : 제품정보 전체
		selectComCombo("dept", "deptall", "all", "","");  // dept : 부서정보

		selectComCombo("whp", "whpall", "all", "","");    // whp : 창고 담당자     option value : 창고담당자 Login ID   항목 : 창고명-담당자명
		selectComCombo("wh", "whall", "all", "","");  // wh : 창고
		selectComCombo("wh_mng", "whmngall", "all", "","");  // wh_mng : 창고 담당자		option value : 창고담당자 Login ID , 항목 : 담당자명
		selectComCombo("sp", "spall", "all", "","");  // sp : 공급처명	
		
		// productCombo(comtype, combo_name, type, code, selvalue)
		// comtype     l : 대분류    m : 중분류    p : 제품정보   
		//  combo_name   select id
		//  type    sel : 선택   all : 전체
		//  code   대분류 인경우 ""    중분류인경우 대분류 코드      제품정보인경우 중분류 코드 
		
		$("#prolall").change( function() {			
			productCombo("m", "promall", "all", $("#prolall").val(),"");   // 제품 목록
			
			$('#prodall').children('option').remove();
		});
	
		$("#promall").change( function() {			
			productCombo("p", "prodall", "all", $("#promall").val(),"");    // 제품 중분류
		});			
		
		productCombo("l","prolall","all","","");   // 제품 대분류
		
    	
   });

</script>

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
                     <a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
                        class="btn_nav bold">Sample</span> <span class="btn_nav bold">SampleTest3
                        </span> <a href="/sampletest/samplepage3.do" class="btn_set refresh">새로고침</a>
                  </p>
                  
                  <br> 
                  <div id="searchAcc" >
						   <table width="100%" cellpadding="5" cellspacing="0" border="1"
			                        align="left" 
			                        style="border-collapse: collapse; border: 10px #50bcdf; ">
									<caption>caption</caption>
										<colgroup>
										   <col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
										</colgroup>
										<tbody>
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">계정대분류</td><td><select id="accall" name="accall" >	</select></td>
						                           <td width="40" height="25" style="font-size: 100%">계정중분류</td><td><select id="accdall" name="accdall" >	</select></td>   
						                           <td width="40" height="25" style="font-size: 100%">거래처</td><td><select id="cilall" name="cilall" >	</select></td>          
						                           <td width="40" height="25" style="font-size: 100%">제품</td><td><select id="proall" name="proall" >	</select></td>        
						                        </tr>
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">제품대분류</td><td><select id="prolall" name="prolall"  >	</select></td>
						                           <td width="40" height="25" style="font-size: 100%">제품중분류</td><td><select id="promall" name="promall" >	</select></td>   
						                           <td width="40" height="25" style="font-size: 100%">제품</td><td><select id="prodall" name="prodall" >	</select></td>          
						                           <td width="40" height="25" style="font-size: 100%">부서</td><td><select id="deptall" name="deptall" >	</select></td>        
						                        </tr>

						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">창고 담당자</td><td><select id="whpall" name="whpall"  >	</select></td>
						                           <td width="40" height="25" style="font-size: 100%">창고</td><td><select id="whall" name="whall" >	</select></td>   
						                           <td width="40" height="25" style="font-size: 100%">창고 담당자2</td><td><select id="whmngall" name="whmngall" >	</select></td>          
						                           <td width="40" height="25" style="font-size: 100%">공급처명</td><td><select id="spall" name="spall" >	</select></td>        
						                        </tr>			
										</tbody>
			                 </table>    
					    </div>  
					    .<br> 
                        <div id="descarea" >
                              <table width="100%" cellpadding="5" cellspacing="0" border="1"
			                        align="left" 
			                        style="border-collapse: collapse; border: 10px #50bcdf; ">
									<caption>caption</caption>
										<colgroup>
										   <col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
											<col width="13%">
										</colgroup>
										<tbody>
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">Controller</td><td>ComnComboController.java	</select></td>
						                           <td width="40" height="25" style="font-size: 100%">Service</td><td>ComnComboService.java <br>ComnComboServiceImpl.java</td>   
						                           <td width="40" height="25" style="font-size: 100%">Dao</td><td>ComnComboDao.java	</select></td>          
						                           <td width="40" height="25" style="font-size: 100%">SQL</td><td>ComcomboMapper.xml<br>Model:comcombo.java</select></td>        
						                        </tr>
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">제품대분류</td>
						                           <td colspan=7>공통코드(그룹코드:ACCcd)  <br> comcombo("ACCcd", "accall", "all", "");  <br> 계정 대분류 코드 Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  </td>      
						                        </tr>

						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">계정중분류</td>
						                           <td colspan=7>selectComCombo("acc", "accdall", "all", $("#accall").val(),"");  <br>acc : 계정상세코드 정보  , Combo Name, Option("all" : 전체     "sel" : 선택 , 계정 대분류코드 , Select Value</td>      
						                        </tr>

						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">거래처</td>
						                           <td colspan=7>selectComCombo("cli", "cilall", "all", "","");   <br> cli : 거래처   , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), Select Value</td>      
						                        </tr>

						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">제품 전체</td>
						                           <td colspan=7>selectComCombo("pro", "cilall", "all", "","");  <br>  pro  : 제품   , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), Select Value</td>      
						                        </tr>

						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">제품대분류</td>
						                           <td colspan=7>productCombo("l","prolall","all","","");   <br> 
						                                 구분("I"  : 대분류)     , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), 대분류 인경우 ""  <br>
						                                 productCombo(comtype, combo_name, type, code, selvalue)<br>
						                                 comtype     l : 대분류    m : 중분류    p : 제품정보   <br>
						                                 combo_name   select id<br>
							                             type    sel : 선택   all : 전체<br>
							                             code   대분류 인경우 ""    중분류인경우 대분류 코드      제품정보인경우 중분류 코드 <br>
						                           </td>      
						                        </tr>			
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">제품중분류</td>
						                           <td colspan=7>productCombo("m", "promall", "all", $("#prolall").val(),"");   <br> 구분("m"  : 대분류)     , Combo Name, Option("all" : 전체     "sel" : 선택 , 대분류 코드</td>      
						                        </tr>				
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">제품목록</td>
						                           <td colspan=7>productCombo("p", "prodall", "all", $("#promall").val(),"");   <br> 구분("p"  : 제품정보)     , Combo Name, Option("all" : 전체     "sel" : 선택 , 중분류 코드</td>      
						                        </tr>				   
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">부서</td>
						                           <td colspan=7>selectComCombo("dept", "deptall", "all", "","");  <br> 구분("dept"  : 부서정보)     , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), ""(빈값)</td>      
						                        </tr>	        
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">창고 담당자</td>
						                           <td colspan=7>selectComCombo("whp", "whpall", "all", "","");  <br> 구분("whp"  : 창고 담당자)     , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), ""(빈값) <br> option value : 창고담당자 Login ID   항목 : 창고명-담당자명</td>      
						                        </tr>	         
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">창고</td>
						                           <td colspan=7>selectComCombo("wh", "whpall", "all", "","");  <br> 구분("wh"  : 창고)     , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), ""(빈값)</td>      
						                        </tr>	         	
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">창고 담당자 2</td>
						                           <td colspan=7>selectComCombo("wh_mng", "whmngall", "all", "","");  <br> 구분("wh_mng"  : 창고 담당자)     , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), ""(빈값) <br> option value : 창고담당자 Login ID , 항목 : 담당자명</td>      
						                        </tr>	    		  
						                        
						                        <tr style="border: 10px; border-color: blue">
						                           <td width="40" height="25" style="font-size: 100%">공급처명</td>
						                           <td colspan=7>selectComCombo("sp", "spall", "all", "","");  <br> 구분("sp"  : 공급처명)     , Combo Name, Option("all" : 전체     "sel" : 선택 , ""(빈값), ""(빈값) </td>      
						                        </tr>	                        						                        						                        	
										</tbody>
			                 </table>    
                        </div>
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
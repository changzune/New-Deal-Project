<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>SamplePage6</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
    var pagesize = 10;
    var pagenavisize = 5;
   
    $(document).ready(function() {
    
    	fn_searchlit();
    	
    	fRegisterButtonClickEvent();
   });

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSearchlist' :
					fn_searchlit();
					break;
			}
		});
	}
	   
    
    function fn_searchlit(pagenum) {
    	
    	pagenum = pagenum || 1;    	
    	
    	var searchoption = $("#searchoption").val();
    	var searchword = $("#searchword").val();
    	
    	var param = {
    			pagenum : pagenum,
    			pagesize : pagesize,
    			searchoption :searchoption,
    			searchword : searchword
    	}
    	
    	var listcollback = function(returndata) {
    		fn_listcallback(returndata, pagenum);
    	}
    	
    	callAjax("/sampletest/samplepage6list.do", "post", "text", true, param, listcollback);
    	
    }
    
    function fn_listcallback(returndata, pagenum) {

    	console.log("fn_listcallback : " + returndata);
    	
    	$("#listnotice").empty().append(returndata);
    	
    	var totalcnt = $("#totalcnt").val();

		var paginationHtml = getPaginationHtml(pagenum, totalcnt, pagesize, pagenavisize, 'fn_searchlit');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#listnation").empty().append( paginationHtml );
		
		// 현재 페이지 설정
		//$("#currentPageComnGrpCod").val(currentPage);
    	
    	
    	
    	
    	//console.log("fn_listcallback totalcnt : " + $("#totalcnt").val());
    }
    
    
    
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
                  <table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
     	                       <select id="searchoption" name="searchoption" style="width: 150px;" v-model="searchKey">
									<option value="" >전체</option>
									<option value="title" >제목</option>
									<option value="cont" >내용</option>
							  </select> 
							
     	                       <input type="text" style="width: 300px; height: 25px;" id="searchword" name="searchword">                    
	                           <a href="" class="btnType blue" id="btnSearchlist" name="btn"><span>검  색</span></a>
                           </td> 
                           
                        </tr>
                     </table>   
                      <br>
	                 <table class="col">
							<caption>caption</caption>
							<colgroup>
								<col width="6%">
								<col width="54%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">글번호</th>
									<th scope="col">제목</th>
									<th scope="col">등록일자</th>
									<th scope="col">작성자</th>
								</tr>
							</thead>
							<tbody id="listnotice"></tbody>
		                 </table>
                  
                         <div class="paging_area"  id="listnation"> </div>
                  
                  
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
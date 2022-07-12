<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 근태 현황 조회</title>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<!-- 공통 js/css src 모은 jsp -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- fullCalendar css import -->
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/fullcalendar/main.css" />
<!--  구글 폰트  -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">

<!-- fullCalendar js import -->
<script src='${CTX_PATH}/js/fullcalendar/main.js'></script>
<script src='${CTX_PATH}/js/fullcalendar/ko.js'></script>
<script src='${CTX_PATH}/js/fullcalendar/moment.js'></script>



<style>

/* 모달창 스타일 */
.calcontent {
	clear: both;
}

.modalbgr {
	display: none;
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.3);
	z-index: 50;
}

.calcontainer {
	font-family: 'Nanum Myeongjo', serif;
	position: fixed;
	top: 50%;
	left: 50%;
	width: 400px;
	height: 300px;
	transform: translate(-50%, -50%);
	max-width: 60%;
	min-height: 40%;
	background: #fff;
	border-radius: 20px;
	box-shadow: 2px 3px 5px 0px #ffe8ff;
}

.caltitle {
	height: 7%;
	font-size: 15px;
	padding: 15px;
	background: #ffe8ff;
	border-radius: 10px;
}

.caltitle p {
	float: left;
}

.caltitle i {
	float: right;
}

/* fullCalendar 스타일 */
button:focus {
	border: 0;
	box-shadow: 0;
}

.fc-border-color #333 ; .fc .fc-toolbar {
	display: flex;
	justify-content: space-evenly;
	align-items: center;
}

.btn-check:active+.btn-primary:focus, .btn-check:checked+.btn-primary:focus,
	.btn-primary.active:focus, .btn-primary:active:focus, .show>.btn-primary.dropdown-toggle:focus
	{
	box-shadow: none;
}

.fc .fc-button-group>.fc-button:focus {
	background: #c6e6fb;
	border: 0;
	box-shadow: none;
}

.fc .fc-button-group>.fc-button.fc-button-active {
	background: #c6e6fb;
	hover: #b3caff;
	active: #b3caff;
	focus: #b3caff;
	visited: #b3caff;
	border: 0;
	box-shadow: 0 0 0 0;
}

.fc .fc-button-group>.fc-button.fc-button-primary {
	background: #c6e6fb;
	hover: #b3caff;
	active: #b3caff;
	focus: #b3caff;
	visited: #d6eafc;
	border: 0;
	box-shadow: 0;
}

.fc table {
	font-family: 'Nanum Myeongjo', serif;
}

.fc table th {
	font-size: 16px;
}

.fc-header-toolbar {
	font-family: 'Nanum Myeongjo', serif;
	font-size: 13px;
	padding-top: 1em;
	padding-left: 1em;
	padding-right: 1em;
	-fc-border-color: #b3caff;
}
/* 일요일 색상 변경 */
.fc-day-sun a {
	color: tomato;
}

.fc-h-event {
	text-align: center;
}
</style>


<script type="text/javascript">
	var calendarEl;
	var calendar;
	var empTaList;

	
	
	document.addEventListener('DOMContentLoaded', function() {
		
		
	
		
	
function openmodal(ta_info2,taCnt) {
			
			$('.caltitletext').html(ta_info2+" 총 "+taCnt+"건 ");
			if(taCnt < 3){
				$('.modaltable').css('margin-top','50px');
			}
			else if( taCnt > 3){
				
				$('.modaltable').css('margin-top','12px');
			}

			if (ta_info2 == '승인대기') {
				
				$('.calcontainer').css('box-shadow', '2px 3px 5px 0px #f8e8f8');
				$('.caltitle').css('background', '#f8e8f8');
				$(".calcontainer th").css('background', '#f8e8f8');
				$(".calcontainer th").css('border-radius', '80%');
			}
				
			  else if (ta_info2 == '승인') {
				$('.calcontainer').css('box-shadow', '2px 3px 5px 0px #ddefe3');
				$('.caltitle').css('background', '#ddefe3');
				$(".calcontainer th").css('background', '#ddefe3');
				$(".calcontainer th").css('border-radius', '80%');
			}
			if (ta_info2 == '반려') {
				$('.calcontainer').css('box-shadow', '2px 3px 5px 0px #fffacd');
				$('.caltitle').css('background', '#fffacd');
				$(".calcontainer th").css('background', '#fffacd');
				$(".calcontainer th").css('border-radius', '80%');
			}
 
			$('#modalbgr').fadeIn(400);

		}
		

		$("#close").on("click", function(event) {
			$('#modalbgr').fadeOut(400);
		});

		//$(document).ready(function() {

		calendarEl = document.getElementById('calendar');
		//calendarEl = $('#calendar').val();

		calendar = new FullCalendar.Calendar(calendarEl, {

			height : '600px', // calendar 높이 설정       
			expandRows : true, // 화면에 맞게 높이 재설정        
			slotMinTime : '08:00', // Day 캘린더에서 시작 시간        
			slotMaxTime : '20:00', // Day 캘린더에서 종료 시간        
			nowIndicator : true,

			initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정:월 )

			contentHeight : '10px',//
			locale : 'ko', // 한국어 설정 

			// 해더에 표시할 툴바
			headerToolbar : {
				left : 'prev,today,next',
				center : 'title',
				right : 'dayGridMonth,dayGridWeek,dayGridDay'
			},
			/* 
			 이벤트 가져오기 
			 */
			events : function(info, callback) {
				
						
				$.ajax({
					url : '/employee/empTaList.do',
					type : 'POST',
					data : {
						
		/* 
		파라메터 값 중에 날짜만 필요해서 moment.js를 사용하여 날짜+시간 => 날짜로 바꿔서 사용
		달력에서 보여지는 시작 날짜와 끝 날짜를 지정해서 파라미터로 넘김 
		ex)2022 7월은 화면에서 6월 26일부터 8월 6일까지 화면상 보여짐=> startdate 는 2022-06-26 enddate는 2022-08-06				
		*/
						startDate : moment(info.start).format('YYYY-MM-DD') // 이벤트(근태신청) 시작 날짜 
						,
						endDate : moment(info.end).format('YYYY-MM-DD')
					},
					dataType : 'json',
					success : function(data) {
						
						
						var list = data.empTaList;				
						empTaList = [];  // 이거 빼면 오류남 왜? 
						
						for (var i = 0; i < list.length; i++) {
				
							var ta_ynColor = "";
							if (list[i].ta_yn == '1') {
								ta_ynColor = "#f8e8f8";
							} else if (list[i].ta_yn == '2') {
								ta_ynColor = "#ddefe3";
							} else if (list[i].ta_yn == '3') {
								ta_ynColor = "#fffacd";
							}

							var ta_yn = "";
							if (list[i].ta_yn == '1') {
								ta_yn = "승인대기";
							} else if (list[i].ta_yn == '2') {
								ta_yn = "승인";
							} else if (list[i].ta_yn == '3') {
								ta_yn = "반려";
							}
							/*
						fullCalendar 속성 
							title
							start 
							color
							textColor
							allDAy
							*/
							var taList = {
							
								title : ta_yn + ' ' + list[i].ta_yn_cnt + '건 ', // (근태신청상태) + (근태신청 건수) +  
								start : list[i].ta_reg_date,
								color : ta_ynColor,
								textColor : '#000',
								allDay : true,
								
							};
	
							empTaList.push(taList);

						}//for문
						
						callback(empTaList); //fullcalendar 에 존재하는 callback 함수를호출 emTaList 파라미터로 넘김 
						
						
					}//success
				});//ajax 
			}, //events

			//이벤트 클릭시 모달 호출 

			eventClick : function(info) {
				
				var taDate = moment(info.event.start).format('YYYY-MM-DD');
				var ta_info = info.event.title.split(' ');
				var ta_info2 = ta_info[0];
				var ta_yn_kind;
				var taCnt;

				if (ta_info2 == '승인대기') {
					ta_yn_kind = 1;
				} else if (ta_info2 == '승인') {
					ta_yn_kind = 2;
				}
				if (ta_info2 == '반려') {
					ta_yn_kind = 3;
				}
				
				$.ajax({
					url : '/employee/empTaDetailList.do',
					type : 'POST',
					data : {
						taDate : taDate,
						ta_yn : ta_yn_kind
					},
					dataType : 'json',
					success : function(data) {
					
						var detailList = data.empTaDetailList;
						
						var ta_detailList = '';
						taCnt=detailList.length;
						console.log("총 건수 :"+taCnt);
					
						
					//	$("#notice_list").empty().append(returndata);
						
						for (var i = 0; i < detailList.length; i++) {
							$('#ta_detail').empty();
							console.log("받아오는 값은 ? ");
							console.log(detailList);
							ta_detailList += '<tr>'; 
							ta_detailList += '<td>' + detailList[i].dept_name
									+ '</td>';
							ta_detailList += '<td>' + detailList[i].name
									+ '</td>';
							ta_detailList += '<td>' + detailList[i].kind_hol
									+ '</td>';
							ta_detailList += '</tr>';

							$('#ta_detail').append(ta_detailList);
						} //for
						 
						
						openmodal(ta_info2,taCnt);
					
					}//success
				});//ajax 
			}//eventClick
		});
		
		calendar.render();

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
					<!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->


					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span class="btn_nav bold">인사•급여</span> <span class="btn_nav bold">근태현황조회</span>
						</p>

						<p class="conTitle">
							<span>근태 현황 조회</span>
						</p>


						<div style="margin-top: 50px;" id="calendar"></div>



					</div> <!--// content -->



					<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>


	<div id="modalbgr" class="modalbgr" style="overflow-y: auto; overflow-x: hidden;">
		<div id="cotainer" class="calcontainer">
			<div id="caltitle" class="caltitle">
				<p class="caltitletext">근태현황조회</p>
				<i id="close" class="fa-solid fa-xmark "></i>
			</div>

			<div id="calcontent" class="calcontent">
				<div style="width: 100%; height: 250px; overflow-y: auto; overflow-x: hidden;">
					<table id="modaltable" class="modaltable" style="width: 100%; border-collapse: separate; border-spacing: 20px; text-align: center; font-size: 13px; font-family: 'Nanum Myeongjo', serif;">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="40%">
						</colgroup>
						<thead>
							<tr style="font-size: 15px; height: 30px;">
								<th scope="col">부서</th>
								<th scope="col">사원명</th>
								<th scope="col">신청구분</th>
							</tr>
						</thead>
						<tbody style="font-size: 15px; padding-top: 15px; overflow: auto;" id="ta_detail">
						</tbody>
					</table>
				</div>
			</div>


		</div>
	</div>
</body>
</html>
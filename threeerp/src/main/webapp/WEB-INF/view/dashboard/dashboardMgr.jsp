<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
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


<!-- D3 -->
<style>

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

.fc-h-event .fc-event-title {
    color: black;}
fc .fc-button-primary:not(:disabled):active, .fc .fc-button-primary:not(:disabled).fc-button-active {
    color: #fff;
    color: var(--fc-button-text-color, #fff);
    background-color: #c6e6fb;
    border-color: #151e27;
    border-color: var(--fc-button-active-border-color, #c6e6fb);
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



	document.addEventListener('DOMContentLoaded', function() {
		
		
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
        	
        	height : '600px', // calendar 높이 설정       
			expandRows : true, // 화면에 맞게 높이 재설정        
			slotMinTime : '08:00', // Day 캘린더에서 시작 시간        
			slotMaxTime : '20:00', // Day 캘린더에서 종료 시간        
			nowIndicator : true,
			locale : 'ko', // 한국어 설정 

          initialView: 'dayGridMonth',
          
        	  headerToolbar: {
        		    left: 'prev,today,next',
        		    center: 'title',
        		    right: 'dayGridMonth'
        		  },
     
        });
		  calendar.addEvent( {'title':'워크샵', color : "#c6e6fb" ,'start':'2022-07-03', 'end':'2022-07-06'});
		  calendar.addEvent( {'title':'주간 회의', color : "#ddefe3" ,'start':'2022-06-27', 'end':'2022-06-27'});
		  calendar.addEvent( {'title':'주간 회의', color : "#ddefe3" ,'start':'2022-07-11', 'end':'2022-07-11'});
		  calendar.addEvent( {'title':'주간 회의', color : "#ddefe3" ,'start':'2022-07-18', 'end':'2022-07-18'});
		  calendar.addEvent( {'title':'주간 회의', color : "#ddefe3" ,'start':'2022-07-25', 'end':'2022-07-25'});
		  calendar.addEvent( {'title':'주간 회의', color : "#ddefe3" ,'start':'2022-08-01', 'end':'2022-08-01'});
		  
		  calendar.addEvent( {'title':'월간 회의', color : "#fffacd" ,'start':'2022-07-01', 'end':'2022-07-01'});
		  calendar.addEvent( {'title':'하반기 전체 평가', color : "#fffacd" ,'start':'2022-07-29', 'end':'2022-07-29'});
		  calendar.addEvent( {'title':'뉴딜 인턴 회사 OJT', color : "#f8e8f8" ,'start':'2022-07-11', 'end':'2022-07-16'});
		  calendar.addEvent( {'title':'뉴딜 인턴 부서 OJT', color : "#f8e8f8" ,'start':'2022-07-18', 'end':'2022-07-23'});
		  
		  calendar.addEvent( {'title':'뉴딜 인턴 부서 배치', color : "#f8e8f8" ,'start':'2022-07-25', 'end':'2022-07-25'});
		  
				 
		  
		  
        calendar.render();
      });

</script>
</head>
<body>


<input type="hidden" id="currentPage" value="1">
<input type="hidden" id="selectedInfNo" value="">
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
			
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
						</p>

						<p class="conTitle" style ="'font-family:Nanum Myeongjo', serif; ">
							<span>회사 일정</span>
						</p>


						<div id="calendar"></div>



					</div> <!--// content -->



					<h3 class="hidden">풋터 영역</h3> <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
             
             
</body>
</html>
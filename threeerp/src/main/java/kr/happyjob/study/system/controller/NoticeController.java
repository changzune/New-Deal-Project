package kr.happyjob.study.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/system/")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	//공지사항 페이지 연결 
	@RequestMapping("notice.do")
	public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".notice");
		
		
		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginID", loginID);
		logger.info("로그인아이디는 "+loginID);
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".notice");
		logger.info("+ End " + className + ".notice");

		return "system/notice";
	}
	
		
	//공지사항 리스트 출력 
	@RequestMapping("noticeList.do")
	public String noticeList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".noticeList");
		

		int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
		int pagesize = Integer.parseInt((String) paramMap.get("pagesize"));
		int pageindex = (pagenum - 1) * pagesize;
		
		String to_date =(String) paramMap.get("toDate");
		String from_date =(String) paramMap.get("fromDate");
		String today =(String) paramMap.get("today");
		
		paramMap.put("pagesize", pagesize);
		paramMap.put("pageindex", pageindex);
		
			
		if( to_date == "" && from_date != ""){//from만 입력했을 시 
			to_date = today;
		}
		if (to_date != "" && from_date == "") {//to만 입력했을 시 
			from_date = "0001-01-01";
		}
		if(to_date == "" && from_date == "") { // 둘다 입력 받지 않을 시 
			to_date = today;
			from_date = "0001-01-01";
		}
		
		paramMap.put("toDate", to_date);
		paramMap.put("fromDate", from_date);
		
		logger.info("   - paramMap : " + paramMap);
		
		List<NoticeModel> result_list = noticeService.noticeList(paramMap);
		

		model.addAttribute("result", result_list);
		
		int totalcnt = noticeService.noticeCnt(paramMap);
				
		model.addAttribute("totalcnt", totalcnt);


		logger.info("+ End " + className + ".noticeList");

		return "system/noticeList";
		

	}
	
	
	// 공지사항 단건조회
	@RequestMapping("noticeSelectOne.do")
	@ResponseBody //내가 요청하고 내가 받음 
	public Map<String,Object> noticeSelectOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".noticeList");
		logger.info("   - paramMap : " + paramMap);
		
		
		
		Map<String,Object>resultvalue = new HashMap<String,Object>();
		
		NoticeModel result = noticeService.noticeSelectOne(paramMap);
		
		if(result != null) {
			resultvalue.put("resultdata", "SUCCESS");
		}
				
		resultvalue.put("result",result);
		
		resultvalue.put("writer", paramMap.get("writer"));
				

		model.addAttribute("result", result);
		
		int totalcnt = noticeService.noticeCnt(paramMap);
				
		model.addAttribute("totalcnt", totalcnt);
		

		logger.info("+ End " + className + ".noticeList");

		return resultvalue;
		

	}
	
	
	/*신규등록일때도 저장 , 수정일때도 저장 2가지 case가 있음 action으로 구분*/
	@RequestMapping("noticeSave.do")
	@ResponseBody //내가 요청하고 내가 받음 
	public Map<String,Object> noticeSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".noticeSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action"); // object타입이여서 형변환해야
		
	/* string의 action.equals("I") 는 위험한 코딩임 action이 null이면 error 
	  
	 	"I".equals(action)을 추천 
	  */	
		Map<String,Object>resultvalue = new HashMap<String,Object>();
		
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		
		logger.info("loginID 1: " +paramMap.get("loginID"));
		
		resultvalue.put("loginID",session.getAttribute("loginId"));
		
		logger.info("loginID 2 : " +resultvalue.get("loginID"));
		
		
		if("I".equals(action)) { //등록일 때 
			
			noticeService.saveInsert(paramMap);
			resultvalue.put("result", "SUCCESS");
			logger.info(" 등록 " + className + "SUCCESS");
			
		}
		else if ("U".equals(action)) {//수정일 때 

			
			noticeService.saveUpdate(paramMap);
			resultvalue.put("result", "UPDATED");
			
			logger.info("+수정  " + className + ".UPDATED");
			
		}else if ("D".equals(action)) {

			noticeService.deleteNotice(paramMap);
			
			resultvalue.put("result", "DELETED");
			
			logger.info("+ 삭제  " + className + ".DELETED");
		}
		
	
		
		logger.info("+ End " + className + ".noticeSave");

		return resultvalue;
		
		
	}	
	
}

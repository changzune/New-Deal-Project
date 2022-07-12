package kr.happyjob.study.accounting.controller;

import java.util.ArrayList;
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

import kr.happyjob.study.accounting.model.AcctitleModel;
import kr.happyjob.study.accounting.service.AcctitleService;
import kr.happyjob.study.system.model.comcombo;


@Controller
@RequestMapping("/accounting/")
public class AcctitleController {
		
		@Autowired
		AcctitleService acctitleService;

		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();
		
		/**
		 *  콤보 박스
		 */
		@RequestMapping("AcctitleCombo.do")
		@ResponseBody
		public Map<String, Object> AcctitleCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".AcctitleCombo");
			logger.info("   - paramMap : " + paramMap);
			logger.info("위를 확인하자");
			
			String ComType = (String) paramMap.get("comtype");
			
			List<AcctitleModel> acctitleModel = new ArrayList<>();
			
			logger.info("   - ComType : " + ComType);

			if("ACCcd".equals(ComType)) {
				// 계정 대분류
				acctitleModel = acctitleService.selectBiglist(paramMap);
			} else if("acc".equals(ComType)) {
				// 계정 세부목록
				acctitleModel = acctitleService.selectAcclist(paramMap);
			} else if("REVEXPcd".equals(ComType)) {
				// 구분
				acctitleModel = acctitleService.selectPaymentlist(paramMap);
			} 
			Map<String, Object> resultMap = new HashMap<String, Object>();

			resultMap.put("list", acctitleModel);
			
			logger.info("+ End " + className + ".AcctitleCombo");
			
			return resultMap;
		}
		
		/**
		 *  전체목록 조회
		 */
		
		@RequestMapping("acctitle.do")
		public String init(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			return "/accounting/acctitle";
		}
		
		@RequestMapping("acctitleList.do")
		public String AccTitleList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("   - paramMap : " + paramMap);
			
			//String을 숫자로 바꿔줌 숫자형으로 가져온 이유는 계산을 하려고
			int  pagenum =  Integer.parseInt((String)paramMap.get("pagenum")); 
			int  pagesize = Integer.parseInt((String)paramMap.get("pagesize"));   
			int pageindex = (pagenum-1) * pagesize;
			
			paramMap.put("pageindex", pageindex);
			paramMap.put("pagesize", pagesize);
			
			
			List<AcctitleModel> searchlist = acctitleService.listAcctitle(paramMap);  // 쿼리에서 이용하기위해 paramMap에 담는다.
			model.addAttribute("searchlist",searchlist);
			
			int totalcnt = acctitleService.countAccTitleList(paramMap);
			model.addAttribute("totalcnt",totalcnt);
			
			logger.info("+ End " + className + ".countAccTitleList");	
			
			
			return "/accounting/acctitleList";
		}
		
		@RequestMapping("acctitleWrite.do")
		@ResponseBody
		public Map<String, Object> acctitleInsert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session)throws Exception{
			System.out.println("param : "+ paramMap);
			acctitleService.acctitleWrite(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			resultMap.put("result","게시글 작성을 성공하였습니다.");
			

			return resultMap;
			
		}
		
		
		@RequestMapping("selectOne.do")
		@ResponseBody
		public Map<String, Object> selectOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session)throws Exception{
			
			logger.info("+ Start " + className + ".selectOne");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			
			logger.info("+ End " + className + ".selectOne");	
			
			AcctitleModel resultOne = acctitleService.selectOne(paramMap);
			resultMap.put("resultOne", resultOne);
			
			resultMap.put("result","SUCCESS");
			resultMap.put("resultMsg","내용을 입력해주세요");
			resultMap.put("resultMsgYes","수정 완료되었습니다.");
			
		
			return resultMap;
			
		}
		
		@RequestMapping("acctitleUpdate.do")
		@ResponseBody
		public Map<String, Object> acctitleUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session)throws Exception{
			
			logger.info("   - paramMap : " + paramMap);
			
			acctitleService.acctitleUpdate(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			resultMap.put("result","SUCCESS");
			resultMap.put("resultMsg","내용을 입력해주세요");
			resultMap.put("resultMsgYes","수정 완료되었습니다.");
					
			return resultMap;
			
		}
		@RequestMapping("acctitleDelete.do")
		@ResponseBody
		public Map<String, Object> acctitleDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session)throws Exception{
			
			logger.info("  delete delete delete delete delete- paramMap : " + paramMap);
			
			acctitleService.acctitleDelete(paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			resultMap.put("result","SUCCESS");
			resultMap.put("resultMsg","삭제완료되었습니다");
			resultMap.put("resultMsgYes","수정 완료되었습니다.");
					
			return resultMap;
			
		}
		
		
}

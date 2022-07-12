package kr.happyjob.study.business.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
//import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.business.service.BmSalePlanService;
import kr.happyjob.study.system.model.comcombo;
import kr.happyjob.study.business.model.BmSalePlanModel;


@Controller
@RequestMapping("/business")  //sampletest가 url이 있으면 BmSalePlanController 실행해라



public class BmSalePlanController {

	@Autowired
	BmSalePlanService bmSalePlanService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	  @RequestMapping("bmSalePlan.do")
	   public String bmSalePlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	     
	      return "/business/bmSalePlan";
	   }
	
	//영업실적조회
	@RequestMapping("listBmSalePlan.do")   
	//맵핑해야하면 실행될 함수
	//model,받아올 파라미터,

		public String listBmSalePlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
		//String을 숫자로 바꿔줌 숫자형으로 가져온 이유는 계산을 하려고
		int  pagenum =  Integer.parseInt((String)paramMap.get("pagenum")); 
		int  pagesize = Integer.parseInt((String)paramMap.get("pagesize"));   
		int pageindex = (pagenum-1) * pagesize;
		
		paramMap.put("pagesize", pagesize) ;
		paramMap.put("pageindex", pageindex);
		
		//목록으로 받아와야함
		List<BmSalePlanModel> searchlist = bmSalePlanService.listBmSalePlan(paramMap);
		model.addAttribute("searchlist",searchlist);
		
		
		//2.bmSalePlanCallback.jsp사용할 변수 선언 및 초기값 세팅
		int totalcnt = bmSalePlanService.countListBmSalePlan(paramMap);
		
		//3.bmSalePlanCallback.jsp넘겨줄 때 model에 담아 줄거임(넘겨줄때이름,실제value값)->4.samplepage7list.jsp파일 만들기
		model.addAttribute("totalcnt", totalcnt);
		
		 logger.info("+ End " + className + ".countListBmSalePlan");	  
		
		//1.리턴받을 jsp이름 선언하고 시작
		return "business/bmSalePlanCallback";
		
	}
	
	/**
	   *  제품 공통 콤보 
	   */
	  @RequestMapping("productCombo.do")
	  @ResponseBody
	  public Map<String, Object> productCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	      HttpServletResponse response, HttpSession session) throws Exception {
	    
	    logger.info("+ Start " + className + ".productCombo");
	    logger.info("   - paramMap : " + paramMap);

	    String ComType = (String) paramMap.get("comtype");
	      
	    List<BmSalePlanModel> BmSalePlanModel = new ArrayList<>();
	    
	    logger.info("   - ComType : " + ComType);
	    
	    if("l".equals(ComType)) {
	      // 상품 대분류
	    	BmSalePlanModel = bmSalePlanService.selectlargelist(paramMap);
	    } else if("m".equals(ComType)) {
	      // 상품 중분류
	    	BmSalePlanModel = bmSalePlanService.selectmidlist(paramMap);
	    } else if("p".equals(ComType)) {
	      // 상품 목록 
	    	BmSalePlanModel = bmSalePlanService.selectdivproductlist(paramMap);
	    }
	    
	    
	    Map<String, Object> resultMap = new HashMap<String, Object>();

	    resultMap.put("list", BmSalePlanModel);
	    
	    logger.info("+ End " + className + ".productCombo");
	    
	    return resultMap;
	  } 
}
	
	
	
	
	
	
	
	
	
	
	
package kr.happyjob.study.business.controller;

import kr.happyjob.study.business.dto.EstListDetailDto;
import kr.happyjob.study.business.dto.EstListDto;
import kr.happyjob.study.business.dto.InsertTableSelectDto;
import kr.happyjob.study.business.dto.SelectEstListDto;
import kr.happyjob.study.business.service.EstManagementService;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.EstimateInfoVo;
import kr.happyjob.study.business.vo.UserInfoVo;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//견적서 작성 및 조회
@Controller
@RequestMapping("/business/")
public class EstManagementController {

	// EstManagementService EstManagementService 지양
	@Autowired
	private EstManagementService estService; 
	
	// 프로퍼티 값
	@Value("${cop.copnm}")
	private String erp_copnm; 			// 회사이름
	
	@Value("${cop.copnum}")
	private String erp_copnum; 			// 사업자등록번호
	
	@Value("${cop.addr}")
	private String erp_addr; 			// 주소

	@Value("1004호")
	private String erp_addrDetail;		// 상세주소

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	// 좌측 사이드메뉴에서 영업 -> 견적서 작성 및 조회를 눌렀을 때 이동
	@RequestMapping("estManagement.do")
	public String estMangement() {
		return "business/EstimateManagement";
	}

	/* model에 List 넣기  == 조회 */
    @RequestMapping("estManagementList.do")
    public String estManagementList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
    			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + "estManagementList ");

		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호 넘어온것
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈 넘어온것
		int pageIndex = (currentPage - 1) * pageSize;								// 페이지 시작 row 번호 넘어온것
		String from_date = (String) paramMap.get("from_date"); 						// 날짜 시작 데이터 검색  넘어온것
		String to_date = (String) paramMap.get("to_date"); 							// 날짜 끝 데이터 검색  넘어온것
		
		paramMap.put("pageIndex", pageIndex); 										// DB로
		paramMap.put("pageSize", pageSize); 										// DB로

		logger.info("+ @@@@@@@@@@@@@@@@@@@@@@ " + paramMap + "#######################################");
		
		// 1 . 목록 리스트 조회
		List<EstListDto> estList = estService.estList(paramMap); 			// -> 콜백단으로 보내지는 데이터
		model.addAttribute("estList", estList);
		
		model.addAttribute("erp_copnm", erp_copnm);

		// 2 . 목록 리스트  카운트 조회
		int estCnt = estService.estCnt(paramMap);

		model.addAttribute("estCnt",estCnt);
		model.addAttribute("from_date", from_date);
		model.addAttribute("to_date", to_date);

		logger.info("   - paramMap ? ? ? ? ? ? : " + paramMap);
		
		return "business/EstimateManagementCallBack";
	}
	
	// 단건 조회
 	@RequestMapping("estManagementSelect.do")
 	@ResponseBody
 	public Map<String, Object> selectEstList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
 			HttpServletResponse response, HttpSession session) throws Exception{

		logger.info("+ 자바단 컨트롤러 Start " + className + " .estManagementSelect");
 		
 		String result = "SUCCESS";
 		String resultMsg = "조회 되었습니다.";

 		// 단건 조회
 		// 단건조회에 맞는 모달 안 리스트 뽑을 때 estimate_no, client_cd는 여기서 꺼내서 썼음
		SelectEstListDto estpart = estService.selectEstList(paramMap);

		String value = estpart.getRemarks();

		if("".equals(value) || value == null) {
			estpart.setRemarks("없음.");
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
 		resultMap.put("result", result); 								// 컨트롤러 탔으니 성공했다는 메세지 뷰로 보낸다
 		resultMap.put("estpart", estpart); 								// 단건조회 목록
 		resultMap.put("resultMsg", resultMsg); 							// 한국어로 메세지
 		
 		// happyjob.properties에서 회사 프로퍼티 박은거 보내기
 		resultMap.put("erp_copnm", erp_copnm); 							// 회사이름
 		resultMap.put("erp_copnum", erp_copnum); 						// 사업자번호
 		resultMap.put("erp_addr", erp_addr); 							// 회사 주소
 		resultMap.put("erp_addrDetail", erp_addrDetail); 				// 회사 상세주소

 		return resultMap ;
 	}
 	
	/* 모달에 foreach문 돌리기 : 단건 조회 항목에 대한 주문 건 리스트  */
    @RequestMapping("estDetaillist.do")
    public String EstDetaillist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
    			HttpServletResponse response, HttpSession session) throws Exception {

		// 1 . 목록 리스트 조회
		List<EstListDetailDto> estListDetail = estService.estListDetail(paramMap); 	// -> 콜백단으로 보내지는 데이터
		model.addAttribute("estListDetail", estListDetail);

		// 2 . 목록 리스트  카운트 조회
		int estDetailCnt = estService.estDetailCnt(paramMap);
		model.addAttribute("estDetailCnt",estDetailCnt);
		
		return "business/EstimateInfoList";
	}

	/* model에 회사 프로퍼티 넣기 == 조회 */
	@RequestMapping("estCreateModal.do")
	@ResponseBody
	public Map<String, Object> estCreateModal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											  HttpServletResponse response, HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		String loginID = (String) session.getAttribute("loginId");
		UserInfoVo user = estService.searchLoginId(loginID);

		// happyjob.properties에서 회사 프로퍼티 박은거 보내기
		resultMap.put("erp_copnm", erp_copnm); 							// 회사이름
		resultMap.put("erp_copnum", erp_copnum); 						// 사업자번호
		resultMap.put("user", user);									// 담당자 이름, 이메일, 전화번호

		return resultMap;
	}

	/* model에 거래처 프로퍼티 넣기 == 조회 */
	@RequestMapping("searchClient.do")
	@ResponseBody
	public Map<String, Object> searchClient(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											HttpServletResponse response, HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ErpClientVo client = estService.searchClient(paramMap);

		resultMap.put("client", client);								// 거래처 이름, 이메일

		return resultMap;
	}
	
 	// 신규 견적서 등록
 	@RequestMapping("estManagementSave.do")
	@ResponseBody
	public Map<String, Object> saveEstManage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginID);

		// resultMap => 뷰로 간다
		Map<String, Object> resultMap = new HashMap<String, Object>();

		//신규 등록 일때
		//estimate테이블 인서트
		estService.insertEstList(paramMap);

		EstimateInfoVo estimateInfo = estService.InsertEstimateInfo(paramMap);

		resultMap.put("estInfo", estimateInfo);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}

	// 신규 견적서 등록2222222222
	@RequestMapping("estManagementSave2.do")
	@ResponseBody
	public Map<String, Object> saveEstManage2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											 HttpServletResponse response, HttpSession session) throws Exception {
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		String loginID = (String) session.getAttribute("loginId");
		UserInfoVo user = estService.searchLoginId(loginID);

		// 신규견적서 단독 조회
		InsertTableSelectDto InsertTableSelect = estService.InsertTableSelect(paramMap);

		// resultMap => 뷰로 간다
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		// happyjob.properties에서 회사 프로퍼티 박은거 보내기
		resultMap.put("erp_copnm", erp_copnm); 							// 회사이름
		resultMap.put("erp_copnum", erp_copnum); 						// 사업자번호
		resultMap.put("user", user);									// 담당자 이름, 이메일, 전화번호
		resultMap.put("estInfo", InsertTableSelect);					// 이전꺼 불러옴

		return resultMap;
	}

	@RequestMapping("estInsertProdCallBack.do")
	public String EstInsertProdCallBack(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
								HttpServletResponse response, HttpSession session) throws Exception {

		int unitCost = estService.searchProductCd(paramMap);

		int estimateCnt = Integer.parseInt((String)paramMap.get("estimateCnt"));
		int price = unitCost * estimateCnt;
		int tax = (unitCost * estimateCnt) / 10;
		int sumAmount = price + tax;

		paramMap.put("unitCost", unitCost);
		paramMap.put("price", price);
		paramMap.put("tax", tax);
		paramMap.put("sumAmount", sumAmount);

		logger.info("   - INT값들 잘 들어왔나 확인해보자 겸사겸사 전부 : " + paramMap);

		estService.updateInsertEstList(paramMap);

		// 1 . 목록 리스트 조회
		List<EstListDetailDto> estListDetail = estService.estListDetail(paramMap); // -> 콜백단으로 보내지는 데이터
		model.addAttribute("estListDetail", estListDetail);

		// 2 . 목록 리스트  카운트 조회
		int estDetailCnt = estService.estDetailCnt(paramMap);
		model.addAttribute("estDetailCnt",estDetailCnt);

		return "/business/EstimateProdCallBack";
	}

 	//  estimate Product 삭제
 	@RequestMapping("estDeleteProd.do")
	public String estDeleteProd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

	 	estService.deleteEstProd(paramMap);

		// 1 . 목록 리스트 조회
		List<EstListDetailDto> estListDetail = estService.estListDetail(paramMap); // -> 콜백단으로 보내지는 데이터
		model.addAttribute("estListDetail", estListDetail);

		// 2 . 목록 리스트  카운트 조회
		int estDetailCnt = estService.estDetailCnt(paramMap);
		model.addAttribute("estDetailCnt",estDetailCnt);

		return "/business/EstimateProdCallBack";
 	}

	@RequestMapping("estUpdateInfo.do")
	@ResponseBody
	public Map<String, Object> estUpdateInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											HttpServletResponse response, HttpSession session) throws Exception {
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		int update = estService.estUpdateInfo(paramMap);

		resultMap.put("update", update);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}

	/* model에 회사 프로퍼티 넣기 == 수정 */
	@RequestMapping("estUpdateModal.do")
	@ResponseBody
	public Map<String, Object> estUpdateModal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											  HttpServletResponse response, HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		String loginID = (String) session.getAttribute("loginId");
		UserInfoVo user = estService.searchLoginId(loginID);

		EstimateInfoVo updateEstInfo = estService.UpdateEstimateInfo(paramMap);

		ErpClientVo client = estService.searchClient(paramMap);

		// happyjob.properties에서 회사 프로퍼티 박은거 보내기
		resultMap.put("erp_copnm", erp_copnm); 							// 회사이름
		resultMap.put("erp_copnum", erp_copnum); 						// 사업자번호
		resultMap.put("user", user);									// 담당자 이름, 이메일, 전화번호
		resultMap.put("update", updateEstInfo);
		resultMap.put("client", client);								// 거래처 이름, 이메일

		return resultMap;
	}

	@RequestMapping("estimateInfoUpdate.do")
	@ResponseBody
	public Map<String, Object> estimateInfoUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											 HttpServletResponse response, HttpSession session) throws Exception {
		String resultMsg = "수정 되었습니다.";

		estService.estimateInfoUpdate(paramMap);

		EstimateInfoVo estimateInfo = estService.UpdateEstimateInfo(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("estInfo", estimateInfo);

		return resultMap;
	}

	@RequestMapping("estimateInfoDelete.do")
	@ResponseBody
	public Map<String, Object> estimateInfoDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											HttpServletResponse response, HttpSession session) throws Exception {

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		estService.estimateInfoDelete(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}

	// 견적서 수정 페이지
	@RequestMapping("estimateProdUpdate.do")
	@ResponseBody
	public Map<String, Object> estimateProdUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											  HttpServletResponse response, HttpSession session) throws Exception {
		String loginID = (String) session.getAttribute("loginId");
		UserInfoVo user = estService.searchLoginId(loginID);

		// 신규견적서 단독 조회
		InsertTableSelectDto UpdateTableSelect = estService.UpdateTableSelect(paramMap);

		// resultMap => 뷰로 간다
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// happyjob.properties에서 회사 프로퍼티 박은거 보내기
		resultMap.put("erp_copnm", erp_copnm); 							// 회사이름
		resultMap.put("erp_copnum", erp_copnum); 						// 사업자번호
		resultMap.put("user", user);									// 담당자 이름, 이메일, 전화번호
		resultMap.put("estInfo", UpdateTableSelect);					// 이전꺼 불러옴

		return resultMap;
	}

	@RequestMapping("estimateUpdateProdList.do")
	public String estimateUpdateProdList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
										HttpServletResponse response, HttpSession session) throws Exception {

		// 1 . 목록 리스트 조회
		List<EstListDetailDto> estListDetail = estService.estListDetail(paramMap); // -> 콜백단으로 보내지는 데이터
		model.addAttribute("estListDetail", estListDetail);

		// 2 . 목록 리스트  카운트 조회
		int estDetailCnt = estService.estDetailCnt(paramMap);
		model.addAttribute("estDetailCnt",estDetailCnt);

		String value = (String)paramMap.get("receiveNo");
		if (value != null) {
			model.addAttribute("receiveNo", value);
		}

		return "/business/EstimateProdCallBack";
	}

	@RequestMapping("estUpdateProdCallBack.do")
	public String estUpdateProdCallBack(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
										HttpServletResponse response, HttpSession session) throws Exception {

		int unitCost2 = estService.searchProductCd(paramMap);

		int estimateCnt = Integer.parseInt((String)paramMap.get("estimateCnt"));
		int price = unitCost2 * estimateCnt;
		int tax = price / 10;
		int sumAmount = price + tax;

		paramMap.put("unitCost", unitCost2);
		paramMap.put("price", price);
		paramMap.put("tax", tax);
		paramMap.put("sumAmount", sumAmount);

		logger.info("   - INT값들 잘 들어왔나 확인해보자 겸사겸사 전부 : " + paramMap);

		estService.updateInsertEstList(paramMap);

		// 1 . 목록 리스트 조회
		List<EstListDetailDto> estListDetail = estService.estListDetail(paramMap); // -> 콜백단으로 보내지는 데이터
		model.addAttribute("estListDetail", estListDetail);

		// 2 . 목록 리스트  카운트 조회
		int estDetailCnt = estService.estDetailCnt(paramMap);
		model.addAttribute("estDetailCnt",estDetailCnt);

		return "/business/EstimateProdCallBack";
	}
}
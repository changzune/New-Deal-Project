package kr.happyjob.study.business.controller;

import kr.happyjob.study.business.dto.*;
import kr.happyjob.study.business.service.EstManagementService;
import kr.happyjob.study.business.service.ReceiveManagementService;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.EstimateInfoVo;
import kr.happyjob.study.business.vo.EstimateProdVo;
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

//수주관리
@Controller
@RequestMapping("/business/")
public class ReceiveManagementController {

	//oemList
	//oemService
	//oempart
	
	// EstManagementService EstManagementService 지양
	@Autowired
	private ReceiveManagementService receiveService;

	@Autowired
	private EstManagementService estService;

	// 프로퍼티 값
	@Value("${cop.copnm}")
	private String erp_copnm; 				// 회사이름

	@Value("${cop.copnum}")
	private String erp_copnum; 				//사업자등록번호

	@Value("${cop.addr}")
	private String erp_addr; 				// 주소

	@Value("1004호")
	private String erp_addrDetail;			// 상세주소


	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("receiveNumSelectCombo.do")
	@ResponseBody
	public Map<String, Object> receiveNumSelectCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											   HttpServletResponse response, HttpSession session) throws Exception {

		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginID);

		// 공통 콤보 조회 거래처
		List<ErpClientVo> comComboModel = receiveService.selectClientList(paramMap);

		logger.info("+ 콤보박스 가져와 " + comComboModel + "@@@@@@@@@@@@@@@@@#@#@#@#@#@#@#@# ");

		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", comComboModel);

		return resultMap;
	}

	// lnbMenu에서 수주관리 클릭 시 넘어감
	@RequestMapping("oeManagement.do")
	public String OeManagement(){
		return "business/ReceiveManagement";
	}

	/* model에 List 넣기  == 조회*/
	@RequestMapping("receiveManagementList.do")
	public String receiveManagementList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + "estManagementList ");

		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호 넘어온것
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈 넘어온것
		int pageIndex = (currentPage-1) * pageSize;									// 페이지 시작 row 번호 넘어온것
		String from_date =(String) paramMap.get("from_date"); 						// 날짜 시작 데이터 검색  넘어온것
		String to_date =(String) paramMap.get("to_date"); 							// 날짜 끝 데이터 검색  넘어온것

		paramMap.put("pageIndex", pageIndex); // db로
		paramMap.put("pageSize", pageSize); // db로

		// 1 . 목록 리스트 조회
		List<ReceiveListDto> receiveList = receiveService.ReceiveList(paramMap); 			// -> 콜백단으로 보내지는 데이터
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("erp_copnm", erp_copnm);

		// 2 . 목록 리스트  카운트 조회
		int receiveCnt = receiveService.receiveCnt(paramMap);

		model.addAttribute("receiveCnt", receiveCnt);
		model.addAttribute("from_date", from_date);
		model.addAttribute("to_date", to_date);

		logger.info("   - paramMap ? ? ? ? ? ? : " + paramMap);

		return "/business/ReceiveManagementCallBack";
	}

	/* 수주서 등록 모달에 회사 프로퍼티 정보 넣기 == 조회 */
	@RequestMapping("receiveInfoCreateModal.do")
	@ResponseBody
	public Map<String, Object> receiveInfoCreateModal(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
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

	/* 수주서 등록 모달에 거래처 정보 넣기 == 조회 */
	@RequestMapping("receiveSearchClient.do")
	@ResponseBody
	public Map<String, Object> receiveSearchClient(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											HttpServletResponse response, HttpSession session) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ErpClientVo client = estService.searchClient(paramMap);

		String estimateNo = (String)paramMap.get("estimateNo");

		resultMap.put("client", client);								// 거래처 이름, 이메일
		resultMap.put("estimateNo", estimateNo);						// 거래처 코드

		return resultMap;
	}

	// 신규 수주서 등록
	@RequestMapping("receiveManagementInsert.do")
	@ResponseBody
	public Map<String, Object> receiveManagementInsert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											 HttpServletResponse response, HttpSession session) throws Exception {

		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		String loginID = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginID);

		Map<String, Object> resultMap = new HashMap<String, Object>();

		receiveService.receiveNoInsert(paramMap);

		EstimateInfoVo receiveInfo = receiveService.InsertReceiveInfo(paramMap);

		resultMap.put("receiveInfo", receiveInfo);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}

	// 신규 수주서 등록2222222222
	@RequestMapping("receiveManagementInsert2.do")
	@ResponseBody
	public Map<String, Object> receiveManagementInsert2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											  HttpServletResponse response, HttpSession session) throws Exception {
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		String loginID = (String) session.getAttribute("loginId");
		UserInfoVo user = estService.searchLoginId(loginID);

		// 신규견적서 단독 조회
		InsertTableSelectDto InsertTableSelect = receiveService.InsertTableSelect(paramMap);

		// resultMap => 뷰로 간다
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		// happyjob.properties에서 회사 프로퍼티 박은거 보내기
		resultMap.put("erp_copnm", erp_copnm); 							// 회사이름
		resultMap.put("erp_copnum", erp_copnum); 						// 사업자번호
		resultMap.put("user", user);									// 담당자 이름, 이메일, 전화번호
		resultMap.put("receiveInfo", InsertTableSelect);				// 이전꺼 불러옴

		return resultMap;
	}

	@RequestMapping("receiveComplete.do")
	@ResponseBody
	public Map<String, Object> receiveComplete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											 HttpServletResponse response, HttpSession session) throws Exception {
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		int update = receiveService.receiveProdInsert(paramMap);

		resultMap.put("update", update);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		EstimateInfoVo estimateInfo = receiveService.searchReceiveInfo(paramMap);
		Map<String, Object> insertOrder = new HashMap<String, Object>();
		insertOrder.put("totalPrice", estimateInfo.getSupplyAmount());
		insertOrder.put("orderDate", estimateInfo.getReceiveDate());
		insertOrder.put("request", estimateInfo.getReceiveRemarks());
		insertOrder.put("loginId", estimateInfo.getLoginId());

		/** order_cd & order_detail 정보 기입 */
		receiveService.insertScmOrder(insertOrder);

		List<ReceiveOrderDetailDto> orderDetail = receiveService.receiveOrderDetail(paramMap);
		receiveService.orderDetailInsert(orderDetail);

		return resultMap;
	}

	// 단건 조회
	@RequestMapping("receiveManagementSelect.do")
	@ResponseBody
	public Map<String, Object> receiveManagementSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
											 HttpServletResponse response, HttpSession session) throws Exception{

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";

		// 단건 조회
		// 단건조회에 맞는 모달 안 리스트 뽑을 때 estimate_no, client_cd는 여기서 꺼내서 썼음
		SelectReceiveListDto receivePart = receiveService.selectReceiveList(paramMap);

		String value = receivePart.getReceiveRemarks();

		if("".equals(value) || value == null) {
			receivePart.setReceiveRemarks("없음.");
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result); 								// 컨트롤러 탔으니 성공했다는 메세지 뷰로 보낸다
		resultMap.put("receivePart", receivePart); 						// 단건조회 목록
		resultMap.put("resultMsg", resultMsg); 							// 한국어로 메세지

		// happyjob.properties에서 회사 프로퍼티 박은거 보내기
		resultMap.put("erp_copnm", erp_copnm); 							// 회사이름
		resultMap.put("erp_copnum", erp_copnum); 						// 사업자번호
		resultMap.put("erp_addr", erp_addr); 							// 회사 주소
		resultMap.put("erp_addrDetail", erp_addrDetail); 				// 회사 상세주소

		return resultMap ;
	}

	/* 모달에 foreach문 돌리기 : 단건 조회 항목에 대한 주문 건 리스트  */
	@RequestMapping("receiveListDetail.do")
	public String receiveListDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
								HttpServletResponse response, HttpSession session) throws Exception {

		// 1 . 목록 리스트 조회
		List<ReceiveListDetailDto> receiveListDetail = receiveService.receiveListDetail(paramMap); 	// -> 콜백단으로 보내지는 데이터
		model.addAttribute("receiveListDetail", receiveListDetail);

		// 2 . 목록 리스트  카운트 조회
		int receiveDetailCnt = receiveService.receiveDetailCnt(paramMap);
		model.addAttribute("receiveDetailCnt", receiveDetailCnt);

		return "business/ReceiveManagementModalDetail";
	}

	/** 삭제 */
	@RequestMapping("receiveInfoDelete.do")
	@ResponseBody
	public Map<String, Object> receiveInfoDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
												  HttpServletResponse response, HttpSession session) throws Exception {
		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";

		receiveService.receiveInfoDelete(paramMap);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);

		return resultMap;
	}
}
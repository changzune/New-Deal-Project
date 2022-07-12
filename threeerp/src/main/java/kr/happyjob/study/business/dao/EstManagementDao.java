package kr.happyjob.study.business.dao;

import kr.happyjob.study.business.dto.EstListDetailDto;
import kr.happyjob.study.business.dto.EstListDto;
import kr.happyjob.study.business.dto.InsertTableSelectDto;
import kr.happyjob.study.business.dto.SelectEstListDto;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.EstimateInfoVo;
import kr.happyjob.study.business.vo.UserInfoVo;

import java.util.List;
import java.util.Map;

public interface EstManagementDao {
	
	//견적서 전체조회
	public List<EstListDto> estList(Map<String, Object> paramMap) throws Exception;
	//견적서 전체 조회 카운트
	public int estCnt(Map<String, Object> paramMap);

	/** 리스트 목록 단건 조회 => 견적서 상세조회 */
	public SelectEstListDto selectEstList(Map<String, Object> paramMap);

	//모달 안 리스트 조회
	public List<EstListDetailDto> estListDetail (Map<String, Object> paramMap) throws Exception;
	
	//모달 안 리스트 조회 카운트
	public int estDetailCnt(Map<String, Object> paramMap);

	/** 견적서 신규 저장 */
	public int insertEstList(Map<String, Object> paramMap);
	// 견적제품 인서트 
	public int updateInsertEstList(Map<String, Object> paramMap);

	/** 단건수정 */
	public int updateEstList(Map<String, Object> paramMap);

	/** 제품코드 가져오기 */
	public int searchProductCd(Map<String, Object> paramMap);

	/** 단건 삭제 */
	public int deleteEstList(Map<String, Object> paramMap);

	/** 단건 estimateProd 삭제 */
	public int deleteEstProd(Map<String, Object> paramMap);

	/** 로그인 아이디 찾기 */
	public UserInfoVo searchLoginId(String loginId);

	/** 클라이언트 찾기 */
	public ErpClientVo searchClient(Map<String, Object> paramMap);

	/** 견적생성시 estimate_info 정보 불러오기 */
	public InsertTableSelectDto InsertTableSelect(Map<String, Object> paramMap);

	/** 견적수정시 estimate_info 정보 불러오기 */
	public InsertTableSelectDto UpdateTableSelect(Map<String, Object> paramMap);

	/** estimateInfoVo 불러오기 */
	public EstimateInfoVo InsertEstimateInfo(Map<String, Object> paramMap);

	/** estimateInfoVo 불러오기 */
	public EstimateInfoVo UpdateEstimateInfo(Map<String, Object> paramMap);

	/** estimate_info 업데이트 */
	public int estUpdateInfo(Map<String, Object> paramMap);

	/** estimate_info 업데이트22 */
	public int estimateInfoUpdate(Map<String, Object> paramMap);

	/** estimate_info 삭제 */
	public int estimateInfoDelete(Map<String, Object> paramMap);
}

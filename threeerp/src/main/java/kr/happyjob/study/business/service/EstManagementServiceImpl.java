package kr.happyjob.study.business.service;

import kr.happyjob.study.business.dao.EstManagementDao;
import kr.happyjob.study.business.dto.EstListDetailDto;
import kr.happyjob.study.business.dto.EstListDto;
import kr.happyjob.study.business.dto.InsertTableSelectDto;
import kr.happyjob.study.business.dto.SelectEstListDto;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.EstimateInfoVo;
import kr.happyjob.study.business.vo.UserInfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class EstManagementServiceImpl implements EstManagementService{

	@Autowired
	EstManagementDao estManagementDao;
	
	//리스트 목록 조회
	@Override
	public List<EstListDto> estList(Map<String, Object> paramMap) throws Exception {
		return estManagementDao.estList(paramMap);
	}

	//리스트 목록 카운트  => 매퍼의 리스트 관계 확인
	@Override
	public int estCnt(Map<String, Object> paramMap) {
		return estManagementDao.estCnt(paramMap);
	}

	//단건조회
	@Override
	public SelectEstListDto selectEstList(Map<String, Object> paramMap) {
		return estManagementDao.selectEstList(paramMap);
	}
	
	//단건 신규등록
	@Override
	public int insertEstList(Map<String, Object> paramMap) {
		return estManagementDao.insertEstList(paramMap);
	}

	//단건 업데이트
	@Override
	public int updateEstList(Map<String, Object> paramMap) {
		return estManagementDao.updateEstList(paramMap);
	}

	// 단건 삭제 
	@Override
	public int deleteEstList(Map<String, Object> paramMap) {
		return estManagementDao.deleteEstList(paramMap);
	}

	// 모달 안 리스트 뿌리기
	@Override
	public List<EstListDetailDto> estListDetail(Map<String, Object> paramMap) throws Exception {
		return estManagementDao.estListDetail(paramMap);
	}
	// 모달 안 리스트 뿌리기 카운트 
	@Override
	public int estDetailCnt(Map<String, Object> paramMap) {
		return estManagementDao.estDetailCnt(paramMap);
	}

	// 견적서,견적 제품에  넘버 넣고 -> 이후 견적제품에 업데이트  
	@Override
	public int updateInsertEstList(Map<String, Object> paramMap) throws Exception {
		return estManagementDao.updateInsertEstList(paramMap);
	}

	@Override
	/** 로그인 아이디 찾기 */
	public UserInfoVo searchLoginId(String loginId) {
		return estManagementDao.searchLoginId(loginId);
	}

	@Override
	/** 클라이언트 찾기 */
	public ErpClientVo searchClient(Map<String, Object> paramMap) {
		return estManagementDao.searchClient(paramMap);
	}

	@Override
	/** 견적생성시 estimate_info 정보 불러오기 */
	public InsertTableSelectDto InsertTableSelect(Map<String, Object> paramMap) { return estManagementDao.InsertTableSelect(paramMap); }

	@Override
	/** 견적수정시 estimate_info 정보 불러오기 */
	public InsertTableSelectDto UpdateTableSelect(Map<String, Object> paramMap) { return estManagementDao.UpdateTableSelect(paramMap); }

	@Override
	/** estimateInfoVo 불러오기 */
	public EstimateInfoVo InsertEstimateInfo(Map<String, Object> paramMap) { return estManagementDao.InsertEstimateInfo(paramMap); }

	/** estimateInfoVo 불러오기 */
	public EstimateInfoVo UpdateEstimateInfo(Map<String, Object> paramMap) { return estManagementDao.UpdateEstimateInfo(paramMap); }

	@Override
	/** 단건 estimateProd 삭제 */
	public int deleteEstProd(Map<String, Object> paramMap) { return estManagementDao.deleteEstProd(paramMap); }

	@Override
	/** 제품코드 가져오기 */
	public int searchProductCd(Map<String, Object> paramMap) { return estManagementDao.searchProductCd(paramMap); }

	/** estimate_info 업데이트 */
	@Override
	public int estUpdateInfo(Map<String, Object> paramMap) { return estManagementDao.estUpdateInfo(paramMap); }

	/** estimate_info 업데이트22 */
	@Override
	public int estimateInfoUpdate(Map<String, Object> paramMap) { return estManagementDao.estimateInfoUpdate(paramMap); }

	/** estimate_info 삭제 */
	@Override
	public int estimateInfoDelete(Map<String, Object> paramMap) { return estManagementDao.estimateInfoDelete(paramMap); }
}
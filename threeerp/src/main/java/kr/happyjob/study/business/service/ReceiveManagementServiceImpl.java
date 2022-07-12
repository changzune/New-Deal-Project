package kr.happyjob.study.business.service;

import kr.happyjob.study.business.dao.ReceiveManagementDao;
import kr.happyjob.study.business.dto.*;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.EstimateInfoVo;
import kr.happyjob.study.business.vo.EstimateProdVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReceiveManagementServiceImpl implements ReceiveManagementService {
	@Autowired
    ReceiveManagementDao receiveManagementDao;

	@Override
	/** 상세 계정 목록 조회 */
	public List<ErpClientVo> selectClientList(Map<String, Object> paramMap) {
		return receiveManagementDao.selectClientList(paramMap);
	}
	
	//리스트 목록 조회
	@Override
	public List<ReceiveListDto> ReceiveList(Map<String, Object> paramMap) throws Exception {
		return receiveManagementDao.ReceiveList(paramMap);
	}

	//리스트 목록 카운트  => 매퍼의 리스트 관계 확인
	@Override
	public int receiveCnt(Map<String, Object> paramMap) {
		return receiveManagementDao.receiveCnt(paramMap);
	}

	@Override
	/** 견적생성시 tb_receive_info 정보 불러오기 */
	public InsertTableSelectDto InsertTableSelect(Map<String, Object> paramMap) { return receiveManagementDao.InsertTableSelect(paramMap); }

	/** receiveInfoVo 불러오기 */
	@Override
	public EstimateInfoVo InsertReceiveInfo(Map<String, Object> paramMap) { return receiveManagementDao.InsertReceiveInfo(paramMap); }

	@Override
	/** receiveInfoVo 불러오기2 */
	public EstimateInfoVo searchReceiveInfo(Map<String, Object> paramMap) { return receiveManagementDao.searchReceiveInfo(paramMap); }

	//단건조회
	@Override
	/** 리스트 목록 단건 조회 => 견적서 상세조회 */
	public SelectReceiveListDto selectReceiveList(Map<String, Object> paramMap) { return receiveManagementDao.selectReceiveList(paramMap); }
	
	//단건 신규등록
	@Override
	public int receiveInfoInsert(Map<String, Object> paramMap) {
		return receiveManagementDao.receiveInfoInsert(paramMap);
	}

	//단건 업데이트
	@Override
	public int updateOemList(Map<String, Object> paramMap) {
		return receiveManagementDao.updateOemList(paramMap);
	}

	// 단건 삭제 
	@Override
	public int receiveInfoDelete(Map<String, Object> paramMap) {
		return receiveManagementDao.receiveInfoDelete(paramMap);
	}

	// 모달 안 리스트 뿌리기
	@Override
	//모달 안 리스트 조회
	public List<ReceiveListDetailDto> receiveListDetail (Map<String, Object> paramMap) throws Exception { return receiveManagementDao.receiveListDetail(paramMap); }
	
	// 모달 안 리스트 뿌리기 카운트 
	@Override
	public int receiveDetailCnt(Map<String, Object> paramMap) {
		return receiveManagementDao.receiveDetailCnt(paramMap);
	}

	@Override
	/** estimateProd 가져오기 */
	public List<EstimateProdVo> estimateProdList (Map<String, Object> paramMap) throws Exception { return receiveManagementDao.estimateProdList(paramMap); }

	@Override
	/** receiveProd 저장 */
	public int receiveProdInsert (Map<String, Object> paramMap) { return receiveManagementDao.receiveProdInsert(paramMap); }
	
	//수주서 인서트
	@Override
	public int updateInsertOemList(Map<String, Object> paramMap) throws Exception {
		return receiveManagementDao.updateInsertOemList(paramMap);
	}

	// order table에 인서트
	@Override
	/** scm order table 인서트 */
	public int insertScmOrder(Map<String, Object> paramMap) { return receiveManagementDao.insertScmOrder(paramMap); }

	@Override
	/** estimateInfo 테이블에 수주번호 집어 넣기 */
	public int receiveNoInsert(Map<String, Object> paramMap) { return receiveManagementDao.receiveNoInsert(paramMap); }

	@Override
	/** 주문상세 테이블에 맞게 정보 가져오기 */
	public List<ReceiveOrderDetailDto> receiveOrderDetail(Map<String, Object> paramMap) { return receiveManagementDao.receiveOrderDetail(paramMap); }

	@Override
	/** 주문상세 테이블 생성 */
	public int orderDetailInsert(List<ReceiveOrderDetailDto> arraylist) { return receiveManagementDao.orderDetailInsert(arraylist); }
}

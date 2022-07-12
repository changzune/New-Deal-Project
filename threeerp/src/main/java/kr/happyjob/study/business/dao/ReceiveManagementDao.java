package kr.happyjob.study.business.dao;

import kr.happyjob.study.business.dto.*;
import kr.happyjob.study.business.vo.ErpClientVo;
import kr.happyjob.study.business.vo.EstimateInfoVo;
import kr.happyjob.study.business.vo.EstimateProdVo;

import java.util.List;
import java.util.Map;

public interface ReceiveManagementDao {
	/** 상세 계정 목록 조회 */
	public List<ErpClientVo> selectClientList(Map<String, Object> paramMap);

	//견적서 전체조회
	public List<ReceiveListDto> ReceiveList(Map<String, Object> paramMap) throws Exception;

	//견적서 전체 조회 카운트
	public int receiveCnt(Map<String, Object> paramMap);

	/** 견적생성시 tb_receive_info 정보 불러오기 */
	public InsertTableSelectDto InsertTableSelect(Map<String, Object> paramMap);

	/** receiveInfoVo 불러오기 */
	public EstimateInfoVo InsertReceiveInfo(Map<String, Object> paramMap);

	/** receiveInfoVo 불러오기2 */
	public EstimateInfoVo searchReceiveInfo(Map<String, Object> paramMap);

	/** 리스트 목록 단건 조회 => 견적서 상세조회 */
	public SelectReceiveListDto selectReceiveList(Map<String, Object> paramMap);

	//모달 안 리스트 조회
	public List<ReceiveListDetailDto> receiveListDetail (Map<String, Object> paramMap) throws Exception;
	
	//모달 안 리스트 조회 카운트
	public int receiveDetailCnt(Map<String, Object> paramMap);

	/** estimateProd 가져오기 */
	public List<EstimateProdVo> estimateProdList (Map<String, Object> paramMap) throws Exception;

	/** receiveProd 저장 */
	public int receiveProdInsert (Map<String, Object> paramMap);

	/** 수주  안서트 */
	public int  receiveInfoInsert(Map<String, Object> paramMap);
	// 수주 제품 인서트 
	public int updateInsertOemList(Map<String, Object> paramMap);

	/** scm order table 인서트 */
	public int insertScmOrder(Map<String, Object> paramMap);

	/** 단건수정 */
	public int updateOemList(Map<String, Object> paramMap);

	/** 단건 삭제 */
	public int receiveInfoDelete(Map<String, Object> paramMap);

	/** estimateInfo 테이블에 수주번호 집어 넣기 */
	public int receiveNoInsert(Map<String, Object> paramMap);

	/** 주문상세 테이블에 맞게 정보 가져오기 */
	public List<ReceiveOrderDetailDto> receiveOrderDetail(Map<String, Object> paramMap);

	/** 주문상세 테이블 생성 */
	public int orderDetailInsert(List<ReceiveOrderDetailDto> arraylist);
}

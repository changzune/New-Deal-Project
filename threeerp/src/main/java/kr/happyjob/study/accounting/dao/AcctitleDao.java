package kr.happyjob.study.accounting.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.accounting.model.AcctitleModel;
import kr.happyjob.study.system.model.comcombo;


// 쿼리에서 아이디를 이용하려고 사용함

public interface AcctitleDao {
	
	//목록 조회	
	public List<AcctitleModel> listAcctitle(Map<String, Object> paramMap) throws Exception;
		
	//목록 조회	갯수
	public int countAccTitleList(Map<String, Object> paramMap) throws Exception;
	
	/** 계정 대분류 조회 */
	public List<AcctitleModel> selectBiglist(Map<String, Object> paramMap);
	
	/** 계정 세부 조회 */
	public List<AcctitleModel> selectAcclist(Map<String, Object> paramMap);
	   
	/** 구분 조회 */
	public List<AcctitleModel> selectPaymentlist(Map<String, Object> paramMap);
	
	/** 단건 조회 */
	public AcctitleModel selectOne(Map<String, Object> paramMap);
	
	/** 등록 */
	public void acctitleWrite(Map<String, Object> paramMap);
	
	/** 수정 */	
	public void acctitleUpdate(Map<String, Object> paramMap);
	
	/** 삭제*/
	public void acctitleDelete(Map<String, Object> paramMap);
	
}

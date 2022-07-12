package kr.happyjob.study.accounting.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.accounting.dao.AcctitleDao;
import kr.happyjob.study.accounting.model.AcctitleModel;

@Service("AcctitleService")
public class AcctitleServiceImp implements AcctitleService {
	
	@Autowired
	AcctitleDao acctitleDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	//목록 조회
	@Override
	public List<AcctitleModel> listAcctitle(Map<String, Object> paramMap) throws Exception{
		return acctitleDao.listAcctitle(paramMap);
	}
		
	//목록 조회	갯수
	@Override
	public int countAccTitleList(Map<String, Object> paramMap) throws Exception{
		return acctitleDao.countAccTitleList(paramMap);
	}
	
	/** 계정 대분류 조회  */
	@Override
	public List<AcctitleModel> selectBiglist(Map<String, Object> paramMap) throws Exception {
		
		return acctitleDao.selectBiglist(paramMap);
	}
		
	/** 계정 세부 조회  */
	@Override
	public List<AcctitleModel> selectAcclist(Map<String, Object> paramMap) throws Exception {
		
		return acctitleDao.selectAcclist(paramMap);
	}
	
	/** 구분 조회*/
	@Override
	public List<AcctitleModel> selectPaymentlist(Map<String, Object> paramMap) throws Exception {
		
		return acctitleDao.selectPaymentlist(paramMap);
	}	

	/** 단건 조회*/
	@Override
	public AcctitleModel selectOne(Map<String, Object> paramMap) {
		return acctitleDao.selectOne(paramMap);
	}
	
	/** 등록*/
	@Override
	public void acctitleWrite(Map<String, Object> paramMap) {
		acctitleDao.acctitleWrite(paramMap);
	
	}
	
	/** 수정*/
	@Override
	public void acctitleUpdate(Map<String, Object> paramMap) {
		acctitleDao.acctitleUpdate(paramMap);
	
	}
	/** 삭제*/
	@Override
	public void acctitleDelete(Map<String, Object> paramMap){
		acctitleDao.acctitleDelete(paramMap);
	}

	
	
}

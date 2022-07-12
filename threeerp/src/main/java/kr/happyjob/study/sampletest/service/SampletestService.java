package kr.happyjob.study.sampletest.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.sampletest.model.Sam6list;



public interface SampletestService {
	
	/** 목록 */	
	public List<Sam6list> samplepage6list(Map<String, Object> paramMap) throws Exception;
	
	/** 건수 */	
	public int samplepage6listtotcant(Map<String, Object> paramMap) throws Exception;

}

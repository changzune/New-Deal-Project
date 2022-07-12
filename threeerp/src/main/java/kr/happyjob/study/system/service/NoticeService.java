package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;


import kr.happyjob.study.system.model.NoticeModel;

public interface NoticeService {


	public List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception;
	
	/** 건수 */	
	public int noticeCnt(Map<String, Object> paramMap) throws Exception;
	
	public NoticeModel noticeSelectOne(Map<String, Object> paramMap) throws Exception;
	
	public void saveInsert(Map<String, Object> paramMap) throws Exception;
	
	public void saveUpdate(Map<String, Object> paramMap) throws Exception;
	
	public void deleteNotice(Map<String, Object> paramMap) throws Exception;
}
package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.model.NoticeNewModel;

public interface NoticeDao {

	public List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception;

	/** 건수 */
	public int noticeCnt(Map<String, Object> paramMap) throws Exception;

	public NoticeModel noticeSelectOne(Map<String, Object> paramMap) throws Exception;

	public void saveInsert(Map<String, Object> paramMap) throws Exception;

	public void saveUpdate(Map<String, Object> paramMap) throws Exception;
	
	public void deleteNotice(Map<String, Object> paramMap) throws Exception;

	
	
}

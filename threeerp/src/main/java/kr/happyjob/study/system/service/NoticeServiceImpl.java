package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.NoticeDao;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.NoticeModel;


@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDao noticeDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	
	@Override
	public List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception {

		return noticeDao.noticeList(paramMap);
		
	}

	@Override
	public int noticeCnt(Map<String, Object> paramMap) throws Exception {
		int noticeCnt = noticeDao.noticeCnt(paramMap);
		return noticeCnt;
	
	}

	@Override
	public NoticeModel noticeSelectOne(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.noticeSelectOne(paramMap);
		 
	
	}

	@Override
	public void saveInsert(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
	noticeDao.saveInsert(paramMap);
	
	}

	@Override
	public void saveUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		 noticeDao.saveUpdate(paramMap);
	
	}

	@Override
	public void deleteNotice(Map<String, Object> paramMap) throws Exception {
		noticeDao.deleteNotice(paramMap);
		
	}

	
}

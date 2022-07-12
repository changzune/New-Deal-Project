package kr.happyjob.study.sampletest.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.common.comnUtils.ComnUtil;
import kr.happyjob.study.sampletest.model.Sam6list;

import kr.happyjob.study.sampletest.dao.SampletestDao;

@Service("SampletestService")
public class SampletestServiceImpl implements SampletestService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private SampletestDao sampletestDao;
	
	/** 목록*/
	public List<Sam6list> samplepage6list(Map<String, Object> paramMap) throws Exception {
		return sampletestDao.samplepage6list(paramMap);
	}

	/** 목록*/
	public int samplepage6listtotcant(Map<String, Object> paramMap) throws Exception {
		return sampletestDao.samplepage6listtotcant(paramMap);
	}	


}

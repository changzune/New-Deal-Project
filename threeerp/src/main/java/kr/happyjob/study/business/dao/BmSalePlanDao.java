package kr.happyjob.study.business.dao;



import java.util.List;
import java.util.Map;

import kr.happyjob.study.business.model.BmSalePlanModel;
import kr.happyjob.study.business.service.BmSalePlanService;

public interface BmSalePlanDao {

	/** 영업실적조회 */
	public List<BmSalePlanModel> listBmSalePlan(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 */
	public int countListBmSalePlan(Map<String, Object> paramMap)throws Exception;
	
	/** 제품 대분류 목록 조회 */
    public List<BmSalePlanModel> selectlargelist(Map<String, Object> paramMap) throws Exception;
    
    /** 제품 중분류 목록 조회 */
    public List<BmSalePlanModel> selectmidlist(Map<String, Object> paramMap) throws Exception;
    
    /** 제품 대분류,중분류 별  목록 조회 */
    public List<BmSalePlanModel> selectdivproductlist(Map<String, Object> paramMap) throws Exception;
	
	}

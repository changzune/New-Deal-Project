package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.model.BmSalePlanModel;

import kr.happyjob.study.business.service.BmSalePlanService;
import kr.happyjob.study.system.model.comcombo;
import kr.happyjob.study.business.dao.BmSalePlanDao;


@Service("BmSalePlanService")
public class BmSalePlanServiceImpl implements BmSalePlanService{

	@Autowired
	BmSalePlanDao bmSalePlanDao;
	
	//목록	
      public List<BmSalePlanModel> listBmSalePlan(Map<String, Object> paramMap) throws Exception{
		return bmSalePlanDao.listBmSalePlan(paramMap) ;
	}
      //카운트 조회
      public int countListBmSalePlan(Map<String,Object> paramMap)throws Exception{
  		return bmSalePlanDao.countListBmSalePlan(paramMap) ; 
  		
  	}
      /** 제품 대분류 목록 조회 */
      public List<BmSalePlanModel> selectlargelist(Map<String, Object> paramMap) throws Exception {
        
        List<BmSalePlanModel> list = bmSalePlanDao.selectlargelist(paramMap);
        
        return list;
      }
      /** 제품 중분류 목록 조회 */
      public List<BmSalePlanModel> selectmidlist(Map<String, Object> paramMap) throws Exception {
        
        List<BmSalePlanModel> list = bmSalePlanDao.selectmidlist(paramMap);
        
        return list;
      }
        
      /** 제품 대분류,중분류 별  목록 조회 */
      public List<BmSalePlanModel> selectdivproductlist(Map<String, Object> paramMap) throws Exception {
        
        List<BmSalePlanModel> list = bmSalePlanDao.selectdivproductlist(paramMap);
        
        return list;
      }
      
      
	
}

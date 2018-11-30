package com.wp.project.webBackground.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wp.common.cSession.SessionUser;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.utils.CheckString;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.IsNullOrEmpty;
import com.wp.common.utils.StringUtils;
import com.wp.project.util.UUIDFactory;
import com.wp.project.webBackground.goods.model.GoodsDetail;

@Service("GoodsServiceImpl")
public class GoodsServiceImpl implements IGoodsService {
	@Autowired
	private IBaseDao dao;

	@Override
	public Map get(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("goodsSpace.get", id);
	}


	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		/*List list = dao.queryPage("goodsSpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;*/
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(Map record) {
		return 0;
	}

	@Override
	public int update(Map record) {
		
		return 0;
	}

	@Override
	public int delete(String id) {
		
		return 0;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}


	public PageView queryPageRank(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		if(IsNullOrEmpty.isNullOrEmpty(paramMap.get("CLASSIFY1"))){
			paramMap.put("CLASSIFY1", null);
		}
		List list = dao.queryPage("goodsSpace.rankqueryPage", pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	public Map updateRank(Map record) {
		// TODO Auto-generated method stub
		/*List list = null;
		dao.batchUpdateList("goodsSpace.batchUpdateRank", list);*/
		return null;
	}


	@Override
	public int updateGoods(Map record) {
		// TODO Auto-generated method stub
		if(record.get("PUBLISH") == null){
			record.put("PUBLISH", "off");
		}
		record.put("IS_USE", "yse");
		dao.update("goodsSpace.updateGoodsDetailIsUse", record);
		return dao.update_("goodsSpace.updateGoods", record);
	}


	@Override
	public Map insertGoods(Map record) {
		// TODO Auto-generated method stub
		if(null == record.get("GOODS_ID") || "".equals(record.get("GOODS_ID").toString())){
			record.put("GOODS_ID", StringUtils.uniqueKey36());
		}
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		if(record.get("PUBLISH") == null){
			record.put("PUBLISH", "off");
		}
		record.put("IS_USE", "yse");
		dao.update("goodsSpace.updateGoodsDetailIsUse", record);
		return (Map) dao.insert("goodsSpace.insertGoods", record);
		
	}


	@Override
	public int deleteGoods(String id) {
		// TODO Auto-generated method stub
		dao.delete("goodsSpace.deleteGroupGoodsDetial", id);
		int i = dao.delete("goodsSpace.deleteGoods", id);
		
		return i;
	}


	@Override
	public Map getGoods(String id) {
		// TODO Auto-generated method stub
		return (Map) dao.get("goodsSpace.getGoods", id);
	}


	@Override
	public PageView queryPageGoodsTime(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("goodsGoods.goodsTimequeryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}


	@Override
	public Map insertGoodsDetail(Map<String,Object> record) {
		// TODO Auto-generated method stub
		String GOODS_ID = record.get("GOODS_ID").toString();
		String MAIN_SPECIFICATION_ID = StringUtils.uniqueKey36();
		if(record.get("PUBLISH") == null){
			record.put("PUBLISH", "off");
		}
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("GOODS_ID", GOODS_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		
		CheckString checkString = new CheckString(); 
		Map<String,Object> goodsChildMap = new HashMap<>();
		List goodsList = new ArrayList<>();
		for (Map.Entry<String,Object> entry : record.entrySet()) {  
			if (checkString.indexOfString(entry.getKey(), "CHILD_SPECIFICATION")){
				if(entry.getKey().length() == 20){
					goodsChildMap.put(entry.getKey(), entry.getKey().substring(19));
				    System.out.println("Key = " + entry.getKey().substring(19));  

				}
			   // System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
			}
		    //System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());    
		}
		if(goodsChildMap.size() == 0){
			GoodsDetail goodsDetail = new GoodsDetail();
			goodsDetail.setGoods_detail_id(MAIN_SPECIFICATION_ID);
			goodsDetail.setGzh_id(record.get("GZH_ID").toString());
			goodsDetail.setMain("1");
			goodsDetail.setMain_specification_id(MAIN_SPECIFICATION_ID);
			goodsDetail.setMain_specification(record.get("MAIN_SPECIFICATION").toString());
			goodsDetail.setGoods_id(GOODS_ID);
			goodsDetail.setInventory(record.get("INVENTORY").toString());
			goodsDetail.setPrice(record.get("PRICE").toString());
			goodsDetail.setCreate_time(CREATE_TIME);
			if(null != record.get("GOODS_DETAIL_NAME") ){
				goodsDetail.setGoods_detail_name(record.get("GOODS_DETAIL_NAME").toString() + record.get("MAIN_SPECIFICATION").toString());
			}
			if(null != record.get("ART_NO")){
				goodsDetail.setArt_no(record.get("ART_NO").toString());
			}
			if(null != record.get("PROMOTION_PRICE")){
				goodsDetail.setPromotion_price(record.get("PROMOTION_PRICE").toString());
			}
			if(null != record.get("VIP_PRICE")){
				goodsDetail.setVip_price(record.get("VIP_PRICE").toString());
			}
			if(null != record.get("RANK")){
				goodsDetail.setRank(record.get("RANK").toString());
			}
			if(null != record.get("IS_USE")){
				goodsDetail.setIs_use(record.get("IS_USE").toString());
			}
			goodsList.add(goodsDetail);
			int l = dao.batchInsertList("goodsSpace.batchInsertGoodsDetail", goodsList);
			if(l == 0){
					record = null;	
					}
			record.put("MAIN_SPECIFICATION_ID", MAIN_SPECIFICATION_ID);
			return record;
		}
		for (Map.Entry<String,Object> goodsChild : goodsChildMap.entrySet()) { 
			GoodsDetail goodsDetail = new GoodsDetail();
			Map goodsDetailMap = new HashMap<>();
			for (Map.Entry<String,Object> entry : record.entrySet()) {
				if (checkString.indexOfString(entry.getKey(), goodsChild.getValue().toString())){
					int size = entry.getKey().length();
					goodsDetailMap.put(entry.getKey().substring(0,size-1), entry.getValue());
				   // System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
				}
			}
			//goodsDetailMap.put("GOODS_DETAIL_ID", StringUtils.uniqueKey36());
				
			if(null != record.get("GOODS_DETAIL_NAME") ){
				goodsDetail.setGoods_detail_name(record.get("GOODS_DETAIL_NAME").toString() + goodsDetailMap.get("MAIN_SPECIFICATION").toString() 
						+ goodsDetailMap.get("CHILD_SPECIFICATION").toString());
			}
			if(null != goodsDetailMap.get("ART_NO")){
				goodsDetail.setArt_no(goodsDetailMap.get("ART_NO").toString());
			}
				
			if(null != goodsDetailMap.get("PROMOTION_PRICE")){
				goodsDetail.setPromotion_price(goodsDetailMap.get("PROMOTION_PRICE").toString());
			}
			if(null != goodsDetailMap.get("VIP_PRICE")){
				goodsDetail.setVip_price(goodsDetailMap.get("VIP_PRICE").toString());
			}
			if(null != goodsDetailMap.get("RANK")){
				goodsDetail.setRank(goodsDetailMap.get("RANK").toString());
			}
			if(null != record.get("IS_USE")){
				goodsDetail.setIs_use(record.get("IS_USE").toString());
			}
				goodsDetail.setGoods_detail_id(StringUtils.uniqueKey36());
				goodsDetail.setGzh_id(record.get("GZH_ID").toString());
				goodsDetail.setMain_specification_id(MAIN_SPECIFICATION_ID);
				goodsDetail.setMain_specification(record.get("MAIN_SPECIFICATION").toString());
				goodsDetail.setChild_specification(goodsDetailMap.get("CHILD_SPECIFICATION").toString());
				goodsDetail.setGoods_id(GOODS_ID);
				goodsDetail.setInventory(goodsDetailMap.get("INVENTORY").toString());
				goodsDetail.setPrice(goodsDetailMap.get("PRICE").toString());
				goodsDetail.setCreate_time(CREATE_TIME);
				
			goodsList.add(goodsDetail);
		}
		GoodsDetail goodsDetail = new GoodsDetail();
		goodsDetail.setGoods_detail_id(MAIN_SPECIFICATION_ID);
		goodsDetail.setGzh_id(record.get("GZH_ID").toString());
		goodsDetail.setMain("1");
		goodsDetail.setMain_specification(record.get("MAIN_SPECIFICATION").toString());
		goodsDetail.setMain_specification_id(MAIN_SPECIFICATION_ID);
		goodsDetail.setGoods_id(GOODS_ID);
		goodsDetail.setCreate_time(CREATE_TIME);
		goodsList.add(goodsDetail);
		if(null != record.get("IS_USE")){
			goodsDetail.setIs_use(record.get("IS_USE").toString());
		}
		int l = dao.batchInsertList("goodsSpace.batchInsertGoodsDetail", goodsList);
		if(l == 0){
				record = null;	
				}
		record.put("MAIN_SPECIFICATION_ID", MAIN_SPECIFICATION_ID);
		
		return record;
		
	}


	@Override
	public Map queryGoodsDetail(String id) {
		// TODO Auto-generated method stub
		Map<String, Object> reMap = new HashMap<String, Object>();
		Map<String, Object> record = new HashMap<String, Object>();
		List<Object> childGoodsDetailList = new ArrayList<>();
		List<Object> list = dao.query("goodsSpace.queryGoodsDetail", id);
		for (Iterator<Object> it = list.iterator(); it.hasNext();) {
			reMap = null;
			reMap = (Map) it.next();
			if( null == reMap.get("MAIN")){
				childGoodsDetailList.add(reMap);
			}else{
				if(!reMap.get("MAIN").toString().equals("1")){
					childGoodsDetailList.add(reMap);
				}else{
					record.put("MainGoodsDetail", reMap);
					record.put("IS_USE", reMap.get("IS_USE"));
				}
				
			}
		}
 		record.put("childGoodsDetialList", childGoodsDetailList);
		return record;
	}


	@Override
	public int deleteGoodsDetail(String id) {
		// TODO Auto-generated method stub
		return dao.delete("goodsSpace.deleteGoodsDetial", id);
	}


	@Override
	public int batchUpdateGoodsDetail(Map<String, Object> record) {
		// TODO Auto-generated method stub
		String GOODS_ID = record.get("GOODS_ID").toString();
		String MAIN_SPECIFICATION_ID = record.get("MAIN_SPECIFICATION_ID").toString();
		if(record.get("PUBLISH") == null){
			record.put("PUBLISH", "off");
		}
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("GOODS_ID", GOODS_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		
		CheckString checkString = new CheckString(); 
		Map<String,Object> goodsChildMap = new HashMap<>();
		List goodsList = new ArrayList<>();
		for (Map.Entry<String,Object> entry : record.entrySet()) {  
			if (checkString.indexOfString(entry.getKey(), "CHILD_SPECIFICATION")){
				if(entry.getKey().length() == 20){
					goodsChildMap.put(entry.getKey(), entry.getKey().substring(19));

				}
			   // System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
			}
		    //System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());    
		}
		if(goodsChildMap.size() == 0){
			GoodsDetail goodsDetail = new GoodsDetail();
			goodsDetail.setGoods_detail_id(MAIN_SPECIFICATION_ID);
			goodsDetail.setGzh_id(record.get("GZH_ID").toString());
			goodsDetail.setMain("1");
			goodsDetail.setMain_specification_id(MAIN_SPECIFICATION_ID);
			goodsDetail.setMain_specification(record.get("MAIN_SPECIFICATION").toString());
			goodsDetail.setGoods_id(GOODS_ID);
			goodsDetail.setInventory(record.get("INVENTORY").toString());
			goodsDetail.setPrice(record.get("PRICE").toString());
			goodsDetail.setCreate_time(CREATE_TIME);
			goodsDetail.setIs_use("yes");
			if(null != record.get("GOODS_DETAIL_NAME") ){
				goodsDetail.setGoods_detail_name(record.get("GOODS_DETAIL_NAME").toString() + record.get("MAIN_SPECIFICATION").toString());
			}
			if(null != record.get("ART_NO")){
				goodsDetail.setArt_no(record.get("ART_NO").toString());
			}
			if(null != record.get("PROMOTION_PRICE")){
				goodsDetail.setPromotion_price(record.get("PROMOTION_PRICE").toString());
			}
			if(null != record.get("VIP_PRICE")){
				goodsDetail.setVip_price(record.get("VIP_PRICE").toString());
			}
			if(null != record.get("RANK")){
				goodsDetail.setRank(record.get("RANK").toString());
			}
				
			goodsList.add(goodsDetail);
			dao.delete("goodsSpace.deleteGoodsDetialMainSpecId", MAIN_SPECIFICATION_ID);
			int l = dao.batchInsertList("goodsSpace.batchInsertGoodsDetail", goodsList);
			if(l == 0){
					record = null;	
					}
			return l;
		}
		for (Map.Entry<String,Object> goodsChild : goodsChildMap.entrySet()) { 
			GoodsDetail goodsDetail = new GoodsDetail();
			Map goodsDetailMap = new HashMap<>();
			for (Map.Entry<String,Object> entry : record.entrySet()) {
				if (checkString.indexOfString(entry.getKey(), goodsChild.getValue().toString())){
					int size = entry.getKey().length();
					goodsDetailMap.put(entry.getKey().substring(0,size-1), entry.getValue());
				   // System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
				}
			}
			//goodsDetailMap.put("GOODS_DETAIL_ID", StringUtils.uniqueKey36());
				
			if(null != record.get("GOODS_DETAIL_NAME") ){
				goodsDetail.setGoods_detail_name(record.get("GOODS_DETAIL_NAME").toString() + goodsDetailMap.get("MAIN_SPECIFICATION").toString() 
						+ goodsDetailMap.get("CHILD_SPECIFICATION").toString());
			}
			if(null != goodsDetailMap.get("ART_NO")){
				goodsDetail.setArt_no(goodsDetailMap.get("ART_NO").toString());
			}
				
			if(null != goodsDetailMap.get("PROMOTION_PRICE")){
				goodsDetail.setPromotion_price(goodsDetailMap.get("PROMOTION_PRICE").toString());
			}
			if(null != goodsDetailMap.get("VIP_PRICE")){
				goodsDetail.setVip_price(goodsDetailMap.get("VIP_PRICE").toString());
			}
			if(null != goodsDetailMap.get("RANK")){
				goodsDetail.setRank(goodsDetailMap.get("RANK").toString());
			}
			if(null != record.get("IS_USE")){
				goodsDetail.setIs_use(record.get("IS_USE").toString());
			}
				goodsDetail.setGoods_detail_id(StringUtils.uniqueKey36());
				goodsDetail.setGzh_id(record.get("GZH_ID").toString());
				goodsDetail.setMain_specification_id(MAIN_SPECIFICATION_ID);
				goodsDetail.setMain_specification(record.get("MAIN_SPECIFICATION").toString());
				goodsDetail.setChild_specification(goodsDetailMap.get("CHILD_SPECIFICATION").toString());
				goodsDetail.setGoods_id(GOODS_ID);
				goodsDetail.setInventory(goodsDetailMap.get("INVENTORY").toString());
				goodsDetail.setPrice(goodsDetailMap.get("PRICE").toString());
				goodsDetail.setCreate_time(CREATE_TIME);
				
			goodsList.add(goodsDetail);
		}
		GoodsDetail goodsDetail = new GoodsDetail();
		goodsDetail.setGoods_detail_id(MAIN_SPECIFICATION_ID);
		goodsDetail.setGzh_id(record.get("GZH_ID").toString());
		goodsDetail.setMain("1");
		goodsDetail.setMain_specification(record.get("MAIN_SPECIFICATION").toString());
		goodsDetail.setMain_specification_id(MAIN_SPECIFICATION_ID);
		goodsDetail.setGoods_id(GOODS_ID);
		goodsDetail.setCreate_time(CREATE_TIME);
		goodsList.add(goodsDetail);
		if(null != record.get("IS_USE")){
			goodsDetail.setIs_use(record.get("IS_USE").toString());
		}
		dao.delete("goodsSpace.deleteGoodsDetialMainSpecId", MAIN_SPECIFICATION_ID);
		int l = dao.batchInsertList("goodsSpace.batchInsertGoodsDetail", goodsList);
		if(l == 0){
				record = null;	
				}
		record.put("MAIN_SPECIFICATION_ID", MAIN_SPECIFICATION_ID);
		
		return l;
	}


	@Override
	public int deleteGoodsDetailByMainId(String id) {
		// TODO Auto-generated method stub
		return dao.delete("goodsSpace.deleteGoodsDetialMainSpecId", id);
	}


	@Override
	public List queryGoodsDetailMainList(String id) {
		// TODO Auto-generated method stub
		List goodsDetailList = dao.query("goodsSpace.queryGoodsDetailMainList", id);
		return goodsDetailList;
	}


	@Override
	public PageView queryPageClass(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("goodsSpace.classqueryPage", pageView, paramMap);
		pageView.setRecords(list);
		return pageView;
	}

}

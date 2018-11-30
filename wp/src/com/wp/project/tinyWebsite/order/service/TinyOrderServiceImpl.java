package com.wp.project.tinyWebsite.order.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.fabric.xmlrpc.base.Array;
import com.wp.common.dao.IBaseDao;
import com.wp.common.page.PageView;
import com.wp.common.service.IBaseService;
import com.wp.common.utils.DateUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.tinyWebsite.order.model.OrderGoods;
@Service("tinyOrderServiceImpl")
public class TinyOrderServiceImpl implements ITinyOrderService{
	@Autowired
	private IBaseDao dao;
	@Override
	public Map get(String id) {
		Map record = (Map) dao.get("tinyOrderSpace.getOrder", id);
		return record;
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		/*List list = dao.queryPage("tinyWebGoodsSpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);*/
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		
		/*List<Map> scList = dao.query("shopCartSpace.query", paramMap);
		for (Map goods : scList) {
		  Map detailMap = (Map) dao.get("goodsSpace.getGoodsDetail", (String)goods.get("GOODS_DETAIL_ID"));   //查库存
		  goods.put("detailMap", detailMap);    //查库存
		}*/
		return null;
	}

	@Override
	public int insert(Map record) {
		/*// TODO Auto-generated method stub //返回 2 是删除旧数据并添加成功   0 是添加失败    1 是添加成功 没有旧数据   6是数据超出 购物车规定限制
		record.put("SC_ID", StringUtils.uniqueKey36());
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		int i = dao.delete("shopCartSpace.deleteSC", (String)record.get("GOODS_DETAIL_ID"));
		String N = record.get("NUM").toString();
		
		Integer num = Integer.parseInt(N);
		if(i == 0 && num > 6){
			return 6;
		}
		i += dao.insert_("shopCartSpace.insertSC", record);*/
		return 0;
	}
	/**
	 * 用户下单
	 */
	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		String ORDER_ID = StringUtils.uniqueKeyNumber();
		String CREATE_TIME = DateUtils.getCurrentDate();
		
		List goodsList = new ArrayList<>();
		List<Map<String, Object>> listMap = (List<Map<String, Object>>) record.get("order");
		List<Object> scList = new ArrayList<>(); 
		for (Map<String, Object> map : listMap) {
			Map scMap = new HashMap<>();
			scMap.put("IS_ORDER", "1");
			scMap.put("SC_ID", map.get("SC_ID"));
			String ORDER_GOODS_ID = StringUtils.uniqueKey36();
			OrderGoods orderGoods = new OrderGoods();
			orderGoods.setOrder_goods_id(ORDER_GOODS_ID);
			orderGoods.setGoods_detail_id(map.get("GOODS_DETAIL_ID").toString());
			orderGoods.setGoods_name(map.get("GOODS_NAME").toString());
			orderGoods.setPic_url(map.get("PIC_URL").toString());
			orderGoods.setUnit_price(map.get("UNIT_PRICE").toString());
			orderGoods.setMain_specification(map.get("MAIN_SPECIFICATION").toString());
			if(null != map.get("CHILD_SPECIFICATION")){
				orderGoods.setChild_specification(map.get("CHILD_SPECIFICATION").toString());
			}
			orderGoods.setAmount(map.get("AMOUNT").toString());
			orderGoods.setTotal_price(map.get("TOTAL_PRICE").toString());
			orderGoods.setTotal_point(map.get("TOTAL_POINT").toString());
			orderGoods.setGoods_id(map.get("GOODS_ID").toString());
			orderGoods.setOrder_id(ORDER_ID);
			goodsList.add(orderGoods);
			scList.add(scMap);
		}
		record.put("ORDER_ID", ORDER_ID);
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("DEAL_TYPE", "30");
		int i = dao.batchInsertList("tinyOrderSpace.batchInsertOrderGoods", goodsList); //插入到订单商品详情表
		dao.insert_("tinyOrderSpace.insertOrder", record);                //插入到订单 表
		dao.batchUpdateList("shopCartSpace.batchUpdateSC", scList);    //更新购物车
		record.put("ORDER_ID", ORDER_ID);
		
		return record;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		record.put("IS_PAY", "0");    //未支付
		record.put("PAY_TYPE", "2");   //支付类型  线下
		record.put("DEAL_TYPE", "0");    //处理状态，下单成功，商家未处理
		return dao.update_("tinyOrderSpace.updateOrder", record);
	}

	@Override
	public Map update_Map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return dao.delete("shopCartSpace.delete", id);
	}
	@Override
	public Map getGoods(String id) {
		List<Map> goodList=dao.query("memberMFinishOrderSpace.get",id);
		Map map=(Map) dao.get("memberMFinishOrderSpace.queryOrder",id);
		if(null != map){
			map.put("goodList", goodList);
		}
		
		return map;
	}
	@Override
	public int enterOrder(String id) {
		Map map=new HashMap<>();
		map.put("DEAL_TYPE","3");
		map.put("ORDER_ID",id);
		int result=dao.update_("tinyOrderSpace.enterOrder",map);
		return result;
	}
	@Override
	public int cancelOrder(String id) {
		Map map=new HashMap<>();
		map.put("DEAL_TYPE","20");
		map.put("ORDER_ID",id);
		int result=dao.update_("tinyOrderSpace.cancelOrder",map);
		return result;
	}

}

package com.wp.project.tinyWebsite.shopCart.service;

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
@Service("shopCartServiceImpl")
public class ShopCartServiceImpl implements IShopCartService{
	@Autowired
	private IBaseDao dao;
	@Override
	public Map get(String id) {
		return null;
	}
	@Override
	public PageView queryPage(PageView pageView, Map paramMap) {
		// TODO Auto-generated method stub
		List list = dao.queryPage("tinyWebGoodsSpace.queryPage",
				pageView, paramMap);
		pageView.setRecords(list);
		return null;
	}

	@Override
	public List<Map> query(Map paramMap) {
		// TODO Auto-generated method stub
		paramMap.put("IS_ORDER", "0");
		List<Map> scList = dao.query("shopCartSpace.query", paramMap);
		/*for (Map goods : scList) {
		  Map detailMap = (Map) dao.get("goodsSpace.getGoodsDetail", (String)goods.get("GOODS_DETAIL_ID"));   //查库存
		  goods.put("detailMap", detailMap);    //查库存
		}*/
		return scList;
	}

	@Override
	public int insert(Map record) {
		// TODO Auto-generated method stub //返回 2 是删除旧数据并添加成功   0 是添加失败    1 是添加成功 没有旧数据   6是数据超出 购物车规定限制
		record.put("SC_ID", StringUtils.uniqueKey36());
		String CREATE_TIME = DateUtils.getCurrentDate();
		record.put("CREATE_TIME", CREATE_TIME);
		record.put("IS_ORDER", "0");
		int i = dao.delete("shopCartSpace.deleteSC", record);
		String N = record.get("NUM").toString();
		record.put("IS_ORDER", "0");
		List<Map> scList = dao.query("shopCartSpace.query", record);
		Integer num = scList.size();
		if(i == 0 && num > 6){
			return 6;
		}
		i += dao.insert_("shopCartSpace.insertSC", record);
		return i;
	}

	@Override
	public Map insert_map(Map record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Map record) {
		// TODO Auto-generated method stub
		return 0;
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
	public int getShopCartCount(Map record) {
		// TODO Auto-generated method stub
		Map map = (Map) dao.get("shopCartSpace.getCount", record);
		if(null == map){
			return 0;
		}
		String N = map.get("COUNT").toString();
		
		Integer num = Integer.parseInt(N);
		return num;
	}
	@Override
	public int batchDelete(Map record) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> listMap = (List<Map<String, Object>>) record.get("scMap");
		int i = dao.delete("shopCartSpace.delete", listMap);
		return i;
	}

}

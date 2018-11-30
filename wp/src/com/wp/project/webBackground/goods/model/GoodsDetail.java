package com.wp.project.webBackground.goods.model;

public class GoodsDetail {
	private String goods_detail_id;                             //主键id
	private String gzh_id;                                      //公众号id
	private String goods_detail_name;                           //商品详细名称
	private String art_no;                                      //商品编号
	private String inventory;                                   //库存
	private String price;                                       //原价
	private String point;                                       //积分
	private String promotion_price;                             //促销价
	private String vip_price;                                   //vip价
	private String main;                                        //是否是主 1   子规格 2
	private String main_specification_id;                       //主规格id
	private String main_specification;                          //主规格   如衣服：M号
	private String child_specification;                         //子规格   如  白色
	private String goods_id;                                    //商品大类的id
	private String rank;                                        //排序
	private String is_use;                                      //是否使用
	private String create_time;                                 //。。。
	public String getGoods_detail_id() {
		return goods_detail_id;
	}
	public void setGoods_detail_id(String goods_detail_id) {
		this.goods_detail_id = goods_detail_id;
	}
	public String getGzh_id() {
		return gzh_id;
	}
	public void setGzh_id(String gzh_id) {
		this.gzh_id = gzh_id;
	}
	public String getGoods_detail_name() {
		return goods_detail_name;
	}
	public void setGoods_detail_name(String goods_detail_name) {
		this.goods_detail_name = goods_detail_name;
	}
	public String getArt_no() {
		return art_no;
	}
	public void setArt_no(String art_no) {
		this.art_no = art_no;
	}
	public String getInventory() {
		return inventory;
	}
	public void setInventory(String inventory) {
		this.inventory = inventory;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getPromotion_price() {
		return promotion_price;
	}
	public void setPromotion_price(String promotion_price) {
		this.promotion_price = promotion_price;
	}
	public String getVip_price() {
		return vip_price;
	}
	public void setVip_price(String vip_price) {
		this.vip_price = vip_price;
	}
	public String getMain_specification_id() {
		return main_specification_id;
	}
	public void setMain_specification_id(String main_specification_id) {
		this.main_specification_id = main_specification_id;
	}
	public String getMain_specification() {
		return main_specification;
	}
	public void setMain_specification(String main_specification) {
		this.main_specification = main_specification;
	}
	public String getChild_specification() {
		return child_specification;
	}
	public void setChild_specification(String child_specification) {
		this.child_specification = child_specification;
	}
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getIs_use() {
		return is_use;
	}
	public void setIs_use(String is_use) {
		this.is_use = is_use;
	}
	public String getCreate_time() {
		return create_time;
	}
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
	
	
	
}

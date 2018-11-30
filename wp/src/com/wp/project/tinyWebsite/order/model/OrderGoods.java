package com.wp.project.tinyWebsite.order.model;

public class OrderGoods {
	private String order_goods_id;                              //主键id
	private String goods_detail_id;                             //货物id
	private String goods_name;                                  //商品名称
	private String pic_url;                                     //图片
	private String main_specification;                          //主规格   如衣服：M号
	private String child_specification;                         //子规格   如  白色
	private String goods_id;                                    //商品大类的id
	private String unit_price;                                  //单价
	private String amount;                                      //数量
	private String total_price;                                 //总价
	private String total_point;                                 //总积分
	private String order_id;                                    //订单编号
	
	public String getTotal_point() {
		return total_point;
	}
	public void setTotal_point(String total_point) {
		this.total_point = total_point;
	}
	public String getOrder_goods_id() {
		return order_goods_id;
	}
	public void setOrder_goods_id(String order_goods_id) {
		this.order_goods_id = order_goods_id;
	}
	public String getGoods_detail_id() {
		return goods_detail_id;
	}
	public void setGoods_detail_id(String goods_detail_id) {
		this.goods_detail_id = goods_detail_id;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public String getPic_url() {
		return pic_url;
	}
	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
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
	public String getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(String unit_price) {
		this.unit_price = unit_price;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getTotal_price() {
		return total_price;
	}
	public void setTotal_price(String total_price) {
		this.total_price = total_price;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
}

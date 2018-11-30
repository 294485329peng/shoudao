package com.wp.project.message;

import java.util.List;

public class WeiXinNewsMessage {
	private List<WeiXinArticle> articles;
	private WeiXinArticle ABCarticleCBA;
	private String media_id;
	private int index;
	public List<WeiXinArticle> getArticles() {
		return articles;
	}

	public WeiXinArticle getABCarticleCBA() {
		return ABCarticleCBA;
	}

	public void setABCarticleCBA(WeiXinArticle aBCarticleCBA) {
		ABCarticleCBA = aBCarticleCBA;
	}

	public void setArticles(List<WeiXinArticle> articles) {
		this.articles = articles;
	}

	public String getMedia_id() {
		return media_id;
	}

	public void setMedia_id(String media_id) {
		this.media_id = media_id;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}
	
}

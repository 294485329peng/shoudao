package com.wp.project.message;

/**
 * 二级按钮
 */
public class UrlButton extends Button {
	private String type;
	private String url;//view必须加
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
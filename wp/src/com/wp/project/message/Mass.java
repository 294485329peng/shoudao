package com.wp.project.message;

public class Mass {
	private Filter filter=new Filter();
	private Mapnews mpnews=new Mapnews();
	private Image image=new Image();
	private Text text=new Text();
	private String msgtype;
	public Filter getFilter() {
		return filter;
	}
	public void setFilter(Filter filter) {
		this.filter = filter;
	}
	public Mapnews getMpnews() {
		return mpnews;
	}
	public void setMpnews(Mapnews mpnews) {
		this.mpnews = mpnews;
	}
	public String getMsgtype() {
		return msgtype;
	}
	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}
	public Image getImage() {
		return image;
	}
	public void setImage(Image image) {
		this.image = image;
	}
	public Text getText() {
		return text;
	}
	public void setText(Text text) {
		this.text = text;
	}
	
}

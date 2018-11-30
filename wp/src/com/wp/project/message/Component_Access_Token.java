package com.wp.project.message;
public class Component_Access_Token {
	private String component_appid="";
	private String component_appsecret="";
	private String component_verify_ticket="";
	private String authorization_code="";
	private String authorizer_appid="";
	private String authorizer_refresh_token="";
	public String getComponent_appid() {
		return component_appid;
	}
	public void setComponent_appid(String component_appid) {
		this.component_appid = component_appid;
	}
	public String getComponent_appsecret() {
		return component_appsecret;
	}
	public void setComponent_appsecret(String component_appsecret) {
		this.component_appsecret = component_appsecret;
	}
	public String getComponent_verify_ticket() {
		return component_verify_ticket;
	}
	public void setComponent_verify_ticket(String component_verify_ticket) {
		this.component_verify_ticket = component_verify_ticket;
	}
	public String getAuthorization_code() {
		return authorization_code;
	}
	public void setAuthorization_code(String authorization_code) {
		this.authorization_code = authorization_code;
	}
	public String getAuthorizer_appid() {
		return authorizer_appid;
	}
	public void setAuthorizer_appid(String authorizer_appid) {
		this.authorizer_appid = authorizer_appid;
	}
	public String getAuthorizer_refresh_token() {
		return authorizer_refresh_token;
	}
	public void setAuthorizer_refresh_token(String authorizer_refresh_token) {
		this.authorizer_refresh_token = authorizer_refresh_token;
	}
	
}

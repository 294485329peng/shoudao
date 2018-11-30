package com.wp.common.cSession;

import java.util.Map;

public class CSession {  
    private String gzhId;  
    private String gzhAppId;  
    private String gzhAppSecret;
    private String operatorId;
	public String getOperatorId() {
		return operatorId;
	}
	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}
	public String getGzhId() {
		return gzhId;
	}
	public void setGzhId(String gzhId) {
		this.gzhId = gzhId;
	}
	public String getGzhAppId() {
		return gzhAppId;
	}
	public void setGzhAppId(String gzhAppId) {
		this.gzhAppId = gzhAppId;
	}
	public String getGzhAppSecret() {
		return gzhAppSecret;
	}
	public void setGzhAppSecret(String gzhAppSecret) {
		this.gzhAppSecret = gzhAppSecret;
	}
    
     
} 
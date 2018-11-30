package com.wp.project.util;

import java.util.UUID;

public class UUIDFactory {
	/*private String uuid;
	private static UUIDFactory instance = null;
	
	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}*/

	public static String getUUID(){
		UUID uuids = UUID.randomUUID();
		String uuid = uuids.toString();
		return uuid;
	}
	public static String getUUID_(){
		UUID uuids = UUID.randomUUID();
		String uuid = uuids.toString().replaceAll("\\-", "");
		return uuid;
	}
}

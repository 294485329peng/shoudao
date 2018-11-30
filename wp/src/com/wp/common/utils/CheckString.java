package com.wp.common.utils;

public class CheckString {
	/*
	 * 判断字符串是否包含一些字符 contains
	 */
	public static boolean containsString(String src, String dest) {
		boolean flag = false;
		if (src.contains(dest)) {
			flag = true;
		}
		return flag;
	}
	
	/*
	 * 判断字符串是否包含一些字符 indexOf
	 */
	public static boolean indexOfString(String src, String dest) {
		boolean flag = false;
		if (src.indexOf(dest)!=-1) {
			flag = true;
		}
		return flag;
	}
}

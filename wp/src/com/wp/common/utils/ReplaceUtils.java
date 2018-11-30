package com.wp.common.utils;

public class ReplaceUtils {
	public static String replace(String content,String re,String beRe){
		content = content.replaceAll(beRe,re);
		return content;
	}
	public static void main(){
		ReplaceUtils rep = new ReplaceUtils();
		String content ="<img src=\"http://ent.news.cn/2016-01/08/128607617_14522113313871n.jpg\" />";
		String re = "http://ent.news.cn/2016-01/08/128607617_14522113313871n.jpg";
		String beRe = "23444343434";
		String wx_content = rep.replace(content, re, beRe);
		System.out.println(content);
	}
}

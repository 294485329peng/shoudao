package com.wp.common.tags;

import java.io.File;
import java.util.ArrayList;


import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

@SuppressWarnings("serial")
public class ButtonRootTag extends BodyTagSupport {
	// 保存从XML文件中取到角色和页面元素的对应集合
	private static ArrayList<ElementAndRole> roleList;
	// 页面元素的名称
	private String elementType;

	public void setelementType(String str) {
	this.elementType = str;
	}


	public int doAfterBody() throws JspException {
	if (roleList == null) {
	roleList = getList();
	}

	try {
	// 如果认证通过就显示标签正文，否则跳过标签正文，就这么简单
	if (isAuthentificated(elementType)) {
	if (bodyContent != null) {
	JspWriter out = bodyContent.getEnclosingWriter();
	bodyContent.writeOut(out);
	} else {
	}
	}
	} catch (Exception e) {
	throw new JspException();
	}
	return SKIP_BODY;
	}


	// 从XML配置文件中取到角色和页面元素的对应，保存到静态的ArrayList
	private ArrayList<ElementAndRole> getList() {
	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	DocumentBuilder db = null;
	Document doc = null;
	String elementType;
	String roleType;
	ArrayList<ElementAndRole> theList = new ArrayList<ElementAndRole>();
	try {
	db = dbf.newDocumentBuilder();
	} catch (Exception e) {
	e.printStackTrace();
	}


	try {
		//System.out.println(this.getClass().getResource("/").getPath() + "props/security.xml");
	doc = db.parse(new File(this.getClass().getResource("/").getPath() + "props/gzhSecurity.xml"));
	} catch (Exception e) {
	e.printStackTrace();
	}
	// 读取页面元素列表
	NodeList elementList = doc.getElementsByTagName("htmlElement");
	for (int i = 0; i < elementList.getLength(); i++) {
	Element name = ((Element) elementList.item(i));
	// 页面元素的名称
	elementType = name.getAttribute("name");
	// 该页面元素对应的有权限的角色的列表
	NodeList rolNodeList = ((NodeList) name.getElementsByTagName("roleType"));
	for (int j = 0; j < rolNodeList.getLength(); j++) {
	// 有权限的角色的名称
	// roleType = ((Element)rolNodeList.item(j)).getNodeValue();
	roleType = ((Element) rolNodeList.item(j)).getAttribute("name");
	theList.add(new ElementAndRole(elementType, roleType));
	}
	}
	return theList;
	}


	// 检查该角色是否有该页面元素的权限
	private boolean isAuthentificated(String elementType) {
	String roleType = "";
	// 在用户登陆时把该用户的角色保存到session中，这里只是直接从SESSION中取用//户角色。
	Map loginGZH = (Map) this.pageContext.getSession().getAttribute("loginGZH");
	switch ( elementType.toLowerCase() ){
	    case "authentication":
	      roleType = (String) loginGZH.get("GZH_AUTH_TYPE");
	      break;
	   case "authorization": 
	      roleType = (String) loginGZH.get("GZH_AUTH_STATUS");
	      break;
	   default :
		   roleType = "";
	}
	
	//roleType = "11";
	// roleList包含elementType属性为elementType，roleType属性为roleType的//ElementAndRole对象，则该角色有该页面元素的权限
	if (roleList.contains(new ElementAndRole(elementType, roleType))) {
	return true;
	}
	return false;
	}


	// 表示角色和页面元素的对应的关系的内部类
	class ElementAndRole {
	String elementType;
	String roleType;


	public ElementAndRole(String elementType, String roleType) {
	this.elementType = elementType;
	this.roleType = roleType;
	}


	public boolean equals(Object obj) {
	return (((ElementAndRole) obj).elementType.equals(this.elementType) && ((ElementAndRole) obj).roleType
	.equals(this.roleType));
	}
	}
	}
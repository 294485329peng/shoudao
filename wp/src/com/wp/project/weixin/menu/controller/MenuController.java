package com.wp.project.weixin.menu.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wp.project.UrlConfig;
import com.wp.project.message.AccessToken;
import com.wp.project.message.Button;
import com.wp.project.message.ClickButton;
import com.wp.project.message.UrlButton;
import com.wp.project.message.ComplexButton;
import com.wp.project.message.Menu;
import com.wp.project.util.WeiXinUtil;

@Controller
@RequestMapping("/menu")
public class MenuController {
	@RequestMapping("to_menu")
	public String TOMenuController() {
		return "client/zdycd/createMenu";
	}
	@RequestMapping("createMenu")
	public String createMenu(HttpServletRequest request, Model model) {
		/*
		 * 根据表单传来的数据封装自定义菜单
		 * */
		String firstMenu=request.getParameter("menu1");
		System.out.println(firstMenu);
		String secondMenu="2";
		String thirdMenu="3";
		String menuString=getMenu(firstMenu,secondMenu,thirdMenu);
		//createMenu(menuString);
		return null;
	}
	private String getMenu(String firstMenu,String secondMenu,String thirdMenu) {
		UrlButton one=new UrlButton();
		one.setName(firstMenu);
		one.setUrl("http://www.baidu.com/");
		one.setType("view");
		ClickButton two=new ClickButton();
		two.setKey("11");
		two.setName("2");
		two.setType("click");
		Menu menu = new Menu();
		menu.setButton(new Button[]{one,two});
		String menuString=JSONObject.fromObject(menu).toString();
		System.out.println(menuString);
		return menuString;
	}
/*	public void createMenu(String menuString) {
		// 调用接口获取access_token
		AccessToken at = WeiXinUtil.getAccessToken(UrlConfig.appId, UrlConfig.appSecret);
		System.out.println(at);
		if (null != at) {
			// 调用接口创建菜单
			int result = WeiXinUtil.createMenu(menuString, at.getToken());
			// 判断菜单创建结果
			if (0 == result)
				System.out.println("菜单创建成功！");
			else {
				System.out.println("result---->" + result);
			}

		}
	}*/
}

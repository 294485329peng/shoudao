package com.wp.project.background.menu.controller;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;   

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  

import com.google.gson.Gson;


@Controller  
@RequestMapping("/bc") 
public class BackgroundController {
	@RequestMapping("/admin.html")  
    public String toAdmin(HttpServletRequest request,Model model){  
        return "backgroundcontrol/main";  
    } 
	@RequestMapping("/bchome.html")  
    public String toBcHome(HttpServletRequest request,Model model){  
    	//System.out.println("1111111");
        return "backgroundcontrol/index";  
    }
}

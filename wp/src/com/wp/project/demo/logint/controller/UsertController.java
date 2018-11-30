package com.wp.project.demo.logint.controller;

import javax.annotation.Resource;  
import javax.servlet.http.HttpServletRequest;   

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.Model;  
import org.springframework.web.bind.annotation.RequestMapping;  

import com.wp.project.demo.logint.entity.Usert;
import com.wp.project.demo.logint.service.UsertService;
 
@Controller  
@RequestMapping("/user_t")  
public class UsertController {
	@Autowired
    private UsertService usertService;  
      
    @RequestMapping("/showuser")  
    public String toIndex(HttpServletRequest request,Model model){  
    	Usert usert = new Usert();
        usert.setUser_name("test1");
        usert.setPassword("12345");
        usert = this.usertService.query(usert);  
        model.addAttribute("usert", usert);  
        return "showUsert";  
    }  


}

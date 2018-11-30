package com.wp.common.upload;

import java.util.*;
import java.io.*;
import java.text.SimpleDateFormat;

import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.wp.common.controller.BaseController;

@Controller  
public class AttachedController extends BaseController{   
      
    @RequestMapping("/attached/{fileType}/{uploadDate}/{fileName}.{suffix}")  
    public void attached(HttpServletRequest request, HttpServletResponse response,   
            @PathVariable String fileType,  
            @PathVariable String uploadDate,  
            @PathVariable String suffix,  
            @PathVariable String fileName) {  
        //根据suffix设置响应ContentType  
        //response.setContentType("text/html; charset=UTF-8");  
          
        InputStream is = null;  
        OutputStream os = null;  
        try {  
            File file = new File("c:/attached/" + fileType + "/" + uploadDate + "/" + fileName + "." + suffix);  
            is = new FileInputStream(file);  
            byte[] buffer = new byte[is.available()];  
            is.read(buffer);  
              
            os = new BufferedOutputStream(response.getOutputStream());  
            os.write(buffer);  
            os.flush();  
        } catch (Exception e) {  
            //判断suffix  
            //图片请求可以在此显示一个默认图片  
            //file显示文件已损坏等错误提示...  
        	logger.error("读取文件失败", e);  
        } finally {  
            if (is != null) {  
                try {  
                    is.close();  
                } catch (IOException e) {  
                	logger.error("读取文件失败", e);  
                }  
                  
                if (os != null) {  
                    try {  
                        os.close();  
                    } catch (IOException e) {  
                    	logger.error("读取文件失败", e);  
                    }  
                }  
            }  
        }  
          
    }  
}  
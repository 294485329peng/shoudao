package com.wp.common.upload;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.wp.common.controller.BaseController;
import com.wp.common.deleteFile.DeleteFile;
import com.wp.common.utils.HttpUtils;
import com.wp.common.utils.IPUtils;
import com.wp.common.utils.StringUtils;
import com.wp.project.background.PicUpload.service.IPicUploadService;


@Controller
@RequestMapping("/upload")
public class uploadController extends BaseController{
	@Autowired
	private IPicUploadService picUploadService;
	/** 
     * 文件上传 
     * @param request {@link HttpServletRequest} 
     * @param response {@link HttpServletResponse} 
     * @return json response 
     */  
   @RequestMapping(value = "/fileUpload", method = RequestMethod.POST)  
   @ResponseBody  
   public Map<String, Object> fileUpload(HttpServletRequest request, HttpServletResponse response) { 

       String PIC_ID = StringUtils.uniqueKey36();
	   Map<String,Object> re = HttpUtils.getRequestMap(request);
	   ServletContext application = request.getSession().getServletContext();
	   Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
	   String GZH_ID = (String) loginGZH.get("GZH_ID");
	   
       String savePath =  "c:/wp/fileUpload/"+GZH_ID+"/weixin/";
       // 文件保存目录URL，网络服务器开这个
       String saveUrl = "http://139.129.18.75:80/wp/fileUpload/"+GZH_ID+"/weixin/";
       //本地服务器开这个
       //String saveUrl = request.getContextPath() + "/fileUpload/"+GZH_ID+"/weixin/";
       
	   
       if(!ServletFileUpload.isMultipartContent(request)){  
           return getError("请选择文件。");  
       }  
       //检查目录  
       /*File uploadDir = new File(savePath); 
       if(!uploadDir.isDirectory()){ 
           return getError("上传目录不存在。"); 
       } 
       //检查目录写权限 
       if(!uploadDir.canWrite()){ 
           return getError("上传目录没有写权限。"); 
       }*/  
 
       String dirName = request.getParameter("dir");  
       if (dirName == null) {  
           dirName = "image";  
       }  
         
       //定义允许上传的文件扩展名  
       Map<String, String> extMap = new HashMap<String, String>();  
       //extMap.put("image", "gif,jpg,jpeg,png,bmp");
       extMap.put("image", "jpg,png");
       extMap.put("flash", "swf,flv");  
       extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");  
       extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,xml,txt,zip,rar,gz,bz2");  
         
       if(!extMap.containsKey(dirName)){  
           return getError("目录名不正确。");  
       }  
       //创建文件夹  
       savePath += dirName + "/";  
       saveUrl += dirName + "/";  
       File saveDirFile = new File(savePath);  
       if (!saveDirFile.exists()) {  
           saveDirFile.mkdirs();  
       }  
         
       SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
       String ymd = sdf.format(new Date());  
       savePath += ymd + "/";  
       saveUrl += ymd + "/";  
       File dirFile = new File(savePath);  
       if (!dirFile.exists()) {  
           dirFile.mkdirs();  
       }  
         
       //最大文件大小  
       long maxSize = 1000000;  
         
       FileItemFactory factory = new DiskFileItemFactory();  
       ServletFileUpload upload = new ServletFileUpload(factory);  
       upload.setHeaderEncoding("UTF-8");  
       List<?> items = null;  
       try {  
           items = upload.parseRequest(request);  
       } catch (FileUploadException fe) {  
           return getError("接收文件异常。");  
       }  
       Iterator<?> itr = items.iterator();  
       while (itr.hasNext()) {  
           FileItem item = (FileItem) itr.next();  
           String fileName = item.getName();  
           if (!item.isFormField()) {  
               //检查文件大小  
               if(item.getSize() > maxSize){  
                   return getError("上传文件大小超过限制。");  
               }  
               //检查扩展名  
               String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();  
               if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){  
                   return getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。");  
               }  
 
               SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");  
               String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) +"&"+PIC_ID+ "." + fileExt;  

               String PIC_URL_BD = savePath + newFileName;
               String PIC_URL_FWQ = saveUrl + newFileName;
               try{  
                   File uploadedFile = new File(savePath, newFileName);  
                   item.write(uploadedFile);
                   
                   Map<String,Object> record = new HashMap();
                   record.put("PIC_URL_BD", PIC_URL_BD);
                   record.put("PIC_URL_FWQ", PIC_URL_FWQ);
                   record.put("uploadedFile", uploadedFile);
                   record.put("GZH_ID",GZH_ID);
                   record.put("PIC_ID", PIC_ID);
                   
                   int i = picUploadService.insert(record);
                   if(i <= 0){
                	   DeleteFile hfc = new DeleteFile();
               			hfc.DeleteFolder(PIC_URL_BD);
                	   return getError("上传文件失败。"); 
                   }
                   
               }catch(Exception e){
            	   DeleteFile hfc = new DeleteFile();
          			hfc.DeleteFolder(PIC_URL_BD);
                   return getError("上传文件失败。");  
               }  
                 
               Map<String, Object> succMap = new HashMap<String, Object>();  
               succMap.put("error", 0);  
               succMap.put("url", saveUrl + newFileName);
               succMap.put("PIC_ID", PIC_ID);
               return succMap;  
           }  
       }  
         
       return null;  
   }  
   @RequestMapping(value = "/fileUploadWeb", method = RequestMethod.POST)  
   @ResponseBody  
   public Map<String, Object> fileUploadWeb(HttpServletRequest request, HttpServletResponse response) { 

       String PIC_ID = StringUtils.uniqueKey36();
	   Map<String,Object> record = HttpUtils.getRequestMap(request);
	   ServletContext application = request.getSession().getServletContext();
	   Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
	   String GZH_ID = (String) loginGZH.get("GZH_ID");
	   
       String savePath =  "c:/wp/fileUpload/"+GZH_ID+"/WebStore/";
       // 文件保存目录URL，网络服务器开这个
       String saveUrl = "http://139.129.18.75:80/wp/fileUpload/"+GZH_ID+"/WebStore/";
       //本地服务器开这个
       //String saveUrl = request.getContextPath() + "/fileUpload/"+GZH_ID+"/WebStore/";
        
	   
       if(!ServletFileUpload.isMultipartContent(request)){  
           return getError("请选择文件。");  
       }  
       //检查目录  
       /*File uploadDir = new File(savePath); 
       if(!uploadDir.isDirectory()){ 
           return getError("上传目录不存在。"); 
       } 
       //检查目录写权限 
       if(!uploadDir.canWrite()){ 
           return getError("上传目录没有写权限。"); 
       }*/  
 
       String dirName = request.getParameter("dir");  
       if (dirName == null) {  
           dirName = "image";  
       }  
         
       //定义允许上传的文件扩展名  
       Map<String, String> extMap = new HashMap<String, String>();  
       //extMap.put("image", "gif,jpg,jpeg,png,bmp");
       extMap.put("image", "jpg,png");
       extMap.put("flash", "swf,flv");  
       extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");  
       extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,xml,txt,zip,rar,gz,bz2");  
         
       if(!extMap.containsKey(dirName)){  
           return getError("目录名不正确。");  
       }  
       //创建文件夹  
       savePath += dirName + "/";  
       saveUrl += dirName + "/";  
       File saveDirFile = new File(savePath);  
       if (!saveDirFile.exists()) {  
           saveDirFile.mkdirs();  
       }  
         
       SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
       String ymd = sdf.format(new Date());  
       savePath += ymd + "/";  
       saveUrl += ymd + "/";  
       File dirFile = new File(savePath);  
       if (!dirFile.exists()) {  
           dirFile.mkdirs();  
       }  
         
       //最大文件大小  
       long maxSize = 110000;  
         
       FileItemFactory factory = new DiskFileItemFactory();  
       ServletFileUpload upload = new ServletFileUpload(factory);  
       upload.setHeaderEncoding("UTF-8");  
       List<?> items = null;  
       try {  
           items = upload.parseRequest(request);  
       } catch (FileUploadException fe) {  
           return getError("接收文件异常。");  
       }  
       Iterator<?> itr = items.iterator();  
       while (itr.hasNext()) {  
           FileItem item = (FileItem) itr.next();  
           String fileName = item.getName();  
           if (!item.isFormField()) {  
               //检查文件大小  
               if(item.getSize() > maxSize){
                   return getError("上传文件大小最大100K。");  
               }  
               //检查扩展名  
               String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();  
               if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){  
                   return getError("上传文件扩展名是不允许的扩展名。\n只允许" + extMap.get(dirName) + "格式。");  
               }  
 
               SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");  
               String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) +"&"+PIC_ID+ "." + fileExt;
               String PIC_URL_BD = savePath + newFileName;
               String PIC_URL_FWQ = saveUrl + newFileName;
               try{  
                   File uploadedFile = new File(savePath, newFileName);  
                   item.write(uploadedFile);
                   
                   
                   /*Map<String,Object> record = new HashMap();*/
                   record.put("PIC_URL_BD", PIC_URL_BD);
                   record.put("PIC_URL_FWQ", PIC_URL_FWQ);
                   record.put("GZH_ID",GZH_ID);
                   record.put("PIC_ID", PIC_ID);
                   record =  picUploadService.insert_map(record);
                   if(record == null){
                	   DeleteFile hfc = new DeleteFile();
              			hfc.DeleteFolder(PIC_URL_BD);
               	   return getError("上传文件失败。");
                   }
                   
               }catch(Exception e){ 
            	   DeleteFile hfc = new DeleteFile();
         			hfc.DeleteFolder(PIC_URL_BD);
            	   e.printStackTrace();
                   return getError("上传文件失败。");  
               }  
                 
               Map<String, Object> succMap = new HashMap<String, Object>();  
               succMap.put("error", 0);  
               succMap.put("url", saveUrl + newFileName);
               succMap.put("PIC_ID", PIC_ID);
               return succMap;  
           }  
       }  
         
       return null;  
   } 
   
   private Map<String, Object> getError(String errorMsg) {  
       Map<String, Object> errorMap = new HashMap<String, Object>();  
       errorMap.put("error", 1);  
       errorMap.put("message", errorMsg);  
       return errorMap;  
   }  
     
   /** 
     * 文件空间 
     * @param request {@link HttpServletRequest} 
     * @param response {@link HttpServletResponse} 
     * @return json 
 * @throws IOException 
     */  
   @SuppressWarnings("unchecked")
   @RequestMapping(value = "/fileManager")  
   @ResponseBody  
   public Object fileManager(HttpServletRequest request, HttpServletResponse response) throws IOException {  
	   Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
	   String GZH_ID = (String) loginGZH.get("GZH_ID");
       /*//根目录路径，可以指定绝对路径  
       String rootPath = "c:/attached/";  
       //根目录URL，可以指定绝对路径，比如 http://www.yoursite.com/attached/  
       String rootUrl  = request.getContextPath() + rootPath.substring(2);*/
	   
	   /*ServletContext application = request.getSession().getServletContext();
	   ServletOutputStream out = response.getOutputStream();*/
       // 根目录路径，可以指定绝对路径，比如 /var/www/upload/
       String rootPath = "c:/wp/fileUpload/"+GZH_ID+"/weixin/";
       // 返回根目录URL，可以指定绝对路径，返回的是本地服务器
       //String rootUrl = request.getContextPath() + "/fileUpload/"+GZH_ID+"/weixin/";
       // 返回根目录URL，可以指定绝对路径，返回的是网络服务器
       String rootUrl = "http://139.129.18.75:80/wp/fileUpload/"+GZH_ID+"/weixin/";
       
       //图片扩展名  
       //String[] fileTypes = new String[]{"gif", "jpg", "jpeg", "png", "bmp"};  
       String[] fileTypes = new String[]{"jpg", "png"};
       String dirName = request.getParameter("dir");  
       if (dirName != null) {  
           if(!Arrays.<String>asList(new String[]{"image", "flash", "media", "file"}).contains(dirName)){  
               return "Invalid Directory name.";  
           }  
           rootPath += dirName + "/";  
           rootUrl += dirName + "/";  
           File saveDirFile = new File(rootPath);  
           if (!saveDirFile.exists()) {  
               saveDirFile.mkdirs();  
           }  
       }  
       //根据path参数，设置各路径和URL  
       String path = request.getParameter("path") != null ? request.getParameter("path") : "";  
       String currentPath = rootPath + path;  
       String currentUrl = rootUrl + path;  
       String currentDirPath = path;  
       String moveupDirPath = "";  
       if (!"".equals(path)) {  
           String str = currentDirPath.substring(0, currentDirPath.length() - 1);  
           moveupDirPath = str.lastIndexOf("/") >= 0 ? str.substring(0, str.lastIndexOf("/") + 1) : "";  
       }  
 
       //排序形式，name or size or type  
       String order = request.getParameter("order") != null ? request.getParameter("order").toLowerCase() : "name";  
 
       //不允许使用..移动到上一级目录  
       if (path.indexOf("..") >= 0) {  
           return "Access is not allowed.";  
       }  
       //最后一个字符不是/  
       if (!"".equals(path) && !path.endsWith("/")) {  
           return "Parameter is not valid.";  
       }  
       //目录不存在或不是目录  
       File currentPathFile = new File(currentPath);  
       if(!currentPathFile.isDirectory()){  
           return "Directory does not exist.";  
       }  
 
       //遍历目录取的文件信息  
       List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();  
       if(currentPathFile.listFiles() != null) {  
           for (File file : currentPathFile.listFiles()) {  
               Hashtable<String, Object> hash = new Hashtable<String, Object>();  
               String fileName = file.getName();  
               if(file.isDirectory()) {  
                   hash.put("is_dir", true);  
                   hash.put("has_file", (file.listFiles() != null));  
                   hash.put("filesize", 0L);  
                   hash.put("is_photo", false);  
                   hash.put("filetype", "");  
               } else if(file.isFile()){  
                   String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();  
                   hash.put("is_dir", false);  
                   hash.put("has_file", false);  
                   hash.put("filesize", file.length());  
                   hash.put("is_photo", Arrays.<String>asList(fileTypes).contains(fileExt));  
                   hash.put("filetype", fileExt);  
               }  
               hash.put("filename", fileName);  
               hash.put("datetime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(file.lastModified()));  
               fileList.add(hash);  
           }  
       }  
 
       if ("size".equals(order)) {  
           Collections.sort(fileList, new SizeComparator());  
       } else if ("type".equals(order)) {  
           Collections.sort(fileList, new TypeComparator());  
       } else {  
           Collections.sort(fileList, new NameComparator());  
       }  
       Map<String, Object> result = new HashMap<String, Object>();  
       result.put("moveup_dir_path", moveupDirPath);  
       result.put("current_dir_path", currentDirPath);  
       result.put("current_url", currentUrl);  
       result.put("total_count", fileList.size());  
       result.put("file_list", fileList); 
       return result;  
   }  
   @SuppressWarnings("unchecked")
   @RequestMapping(value = "/fileManagerWeb")  
   @ResponseBody  
   public Object fileManagerWeb(HttpServletRequest request, HttpServletResponse response) throws IOException {  
	   Map loginGZH = (Map) request.getSession().getAttribute(LOGIN_IN_GZH_SESSION);
	   String GZH_ID = (String) loginGZH.get("GZH_ID");
     
       // 根目录路径，可以指定绝对路径，比如 /var/www/upload/
       String rootPath = "c:/wp/fileUpload/"+GZH_ID+"/WebStore/";
       // 返回根目录URL，可以指定绝对路径，返回的是本地服务器
       //String rootUrl = request.getContextPath() + "/fileUpload/"+GZH_ID+"/WebStore/";
       // 返回根目录URL，可以指定绝对路径，返回的是网络服务器
       String rootUrl = "http://139.129.18.75:80/wp/fileUpload/"+GZH_ID+"/WebStore/";
       
       //图片扩展名  
       //String[] fileTypes = new String[]{"gif", "jpg", "jpeg", "png", "bmp"};  
       String[] fileTypes = new String[]{"jpg", "png"};
       String dirName = request.getParameter("dir");  
       if (dirName != null) {  
           if(!Arrays.<String>asList(new String[]{"image", "flash", "media", "file"}).contains(dirName)){  
               return "Invalid Directory name.";  
           }  
           rootPath += dirName + "/";  
           rootUrl += dirName + "/";  
           File saveDirFile = new File(rootPath);  
           if (!saveDirFile.exists()) {  
               saveDirFile.mkdirs();  
           }  
       }  
       //根据path参数，设置各路径和URL  
       String path = request.getParameter("path") != null ? request.getParameter("path") : "";  
       String currentPath = rootPath + path;  
       String currentUrl = rootUrl + path;  
       String currentDirPath = path;  
       String moveupDirPath = "";  
       if (!"".equals(path)) {  
           String str = currentDirPath.substring(0, currentDirPath.length() - 1);  
           moveupDirPath = str.lastIndexOf("/") >= 0 ? str.substring(0, str.lastIndexOf("/") + 1) : "";  
       }  
 
       //排序形式，name or size or type  
       String order = request.getParameter("order") != null ? request.getParameter("order").toLowerCase() : "name";  
 
       //不允许使用..移动到上一级目录  
       if (path.indexOf("..") >= 0) {  
           return "Access is not allowed.";  
       }  
       //最后一个字符不是/  
       if (!"".equals(path) && !path.endsWith("/")) {  
           return "Parameter is not valid.";  
       }  
       //目录不存在或不是目录  
       File currentPathFile = new File(currentPath);  
       if(!currentPathFile.isDirectory()){  
           return "Directory does not exist.";  
       }  
 
       //遍历目录取的文件信息  
       List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();  
       if(currentPathFile.listFiles() != null) {  
           for (File file : currentPathFile.listFiles()) {  
               Hashtable<String, Object> hash = new Hashtable<String, Object>();  
               String fileName = file.getName();  
               if(file.isDirectory()) {  
                   hash.put("is_dir", true);  
                   hash.put("has_file", (file.listFiles() != null));  
                   hash.put("filesize", 0L);  
                   hash.put("is_photo", false);  
                   hash.put("filetype", "");  
               } else if(file.isFile()){  
                   String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();  
                   hash.put("is_dir", false);  
                   hash.put("has_file", false);  
                   hash.put("filesize", file.length());  
                   hash.put("is_photo", Arrays.<String>asList(fileTypes).contains(fileExt));  
                   hash.put("filetype", fileExt);  
               }  
               hash.put("filename", fileName);  
               hash.put("datetime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(file.lastModified()));  
               fileList.add(hash);  
           }  
       }  
 
       if ("size".equals(order)) {  
           Collections.sort(fileList, new SizeComparator());  
       } else if ("type".equals(order)) {  
           Collections.sort(fileList, new TypeComparator());  
       } else {  
           Collections.sort(fileList, new NameComparator());  
       }  
       Map<String, Object> result = new HashMap<String, Object>();  
       result.put("moveup_dir_path", moveupDirPath);  
       result.put("current_dir_path", currentDirPath);  
       result.put("current_url", currentUrl);  
       result.put("total_count", fileList.size());  
       result.put("file_list", fileList); 
       return result;  
   }
   
   @RequestMapping(value = "/netUpload", method = RequestMethod.POST)  
   @ResponseBody  
   public String netUpload(HttpServletRequest request, HttpServletResponse response) {
	   Map<String,Object> record = HttpUtils.getRequestMap(request);
	   String pic = (String) request.getParameter("pic");
	   String[] arr = pic.split("\\|");

       String sstr = "";
       UpLoadIMG st = new UpLoadIMG();
       for (int i = 0; i < arr.length; i++)
       {
           if (arr[i].indexOf("http://") >= 0 || arr[i].indexOf("https://") >= 0)
           {
               String std = st.SaveUrlPics(request,arr[i], "../../uploads/image/");
               if (std.length() > 0)
               {
                   if (i == arr.length - 1)
                       sstr += std;
                   else
                       sstr += std + "|";
               }
           }
       }
	   return "1111111";  
   
   }
   
   public class UpLoadIMG
   {
       public String SaveUrlPics(HttpServletRequest request,String imgurlAry, String path)
       {	
    	   ServletContext application = request.getSession().getServletContext();
           String savePath =  "c:/wp/fileUpload/";
           // 文件保存目录URL
           String saveUrl = request.getContextPath() + "/fileUpload/";
    	   /*ServletContext application = request.getSession().getServletContext();
           String savePath = "c:/attached/";
           // 文件保存目录URL
           String saveUrl = "c:/attached/";*/
    	   
           if(!ServletFileUpload.isMultipartContent(request)){  
               return null;  
           }  
           //检查目录  
           /*File uploadDir = new File(savePath); 
           if(!uploadDir.isDirectory()){ 
               return getError("上传目录不存在。"); 
           } 
           //检查目录写权限 
           if(!uploadDir.canWrite()){ 
               return getError("上传目录没有写权限。"); 
           }*/  
     
           String dirName = request.getParameter("dir");  
           if (dirName == null) {  
               dirName = "image";  
           }  
             
           //定义允许上传的文件扩展名  
           Map<String, String> extMap = new HashMap<String, String>();  
           extMap.put("image", "gif,jpg,jpeg,png,bmp");  
           extMap.put("flash", "swf,flv");  
           extMap.put("media", "swf,flv,mp3,wav,wma,wmv,mid,avi,mpg,asf,rm,rmvb");  
           extMap.put("file", "doc,docx,xls,xlsx,ppt,htm,html,xml,txt,zip,rar,gz,bz2");  
             
           if(!extMap.containsKey(dirName)){  
               return null;  
           }  
           //创建文件夹  
           savePath += dirName + "/";  
           saveUrl += dirName + "/";  
           File saveDirFile = new File(savePath);  
           if (!saveDirFile.exists()) {  
               saveDirFile.mkdirs();  
           }  
             
           SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
           String ymd = sdf.format(new Date());  
           savePath += ymd + "/";  
           saveUrl += ymd + "/";  
           File dirFile = new File(savePath);  
           if (!dirFile.exists()) {  
               dirFile.mkdirs();  
           }  
             
           //最大文件大小  
           long maxSize = 1000000;  
             
           FileItemFactory factory = new DiskFileItemFactory();  
           ServletFileUpload upload = new ServletFileUpload(factory);  
           upload.setHeaderEncoding("UTF-8");  
           List<?> items = null;  
           try {  
               items = upload.parseRequest(request);  
           } catch (FileUploadException fe) {  
               return null;  
           }  
           Iterator<?> itr = items.iterator();  
           while (itr.hasNext()) {  
               FileItem item = (FileItem) itr.next();  
               String fileName = item.getName();  
               if (!item.isFormField()) {  
                   //检查文件大小  
                   if(item.getSize() > maxSize){  
                       return null;  
                   }  
                   //检查扩展名  
                   String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();  
                   if(!Arrays.<String>asList(extMap.get(dirName).split(",")).contains(fileExt)){  
                       return null;  
                   }  
     
                   SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");  
                   String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;  
                   try{  
                       File uploadedFile = new File(savePath, newFileName);  
                       item.write(uploadedFile);  
                   }catch(Exception e){  
                       return null;  
                   }  
                     
                   /*Map<String, Object> succMap = new HashMap<String, Object>();  
                   succMap.put("error", 0);  
                   succMap.put("url", saveUrl + newFileName); */ 
                   return saveUrl + newFileName;  
               }  
           }  
             
           return null;
    	   /*
    	   
    	   String strHTML = "";
    	   String dirPath = "1";
    	   String savePath =  "c:/wp/fileUpload/images/";
    	   
    	   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
           String ymd = sdf.format(new Date());  
           savePath += ymd + "/";
           File saveDirFile = new File(savePath); 
           try
           {
               String fileExt = imgurlAry.substring(imgurlAry.lastIndexOf(".") + 1).toLowerCase();
               SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");  
               String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt; 
              // WebClient wc = new WebClient();
             //  wc.DownloadFile(imgurlAry, dirPath + newFileName);
               strHTML = ymd + "/" + newFileName;
           }
           catch (Exception ex)
           {
               //return ex.Message;
           }
           return strHTML;*/
       }
   }
   
   private class NameComparator implements Comparator<Map<String, Object>> {  
       public int compare(Map<String, Object> hashA, Map<String, Object> hashB) {  
           if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {  
               return -1;  
           } else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {  
               return 1;  
           } else {  
               return ((String)hashA.get("filename")).compareTo((String)hashB.get("filename"));  
           }  
       }  
   }  
     
   private class SizeComparator implements Comparator<Map<String, Object>> {  
       public int compare(Map<String, Object> hashA, Map<String, Object> hashB) {  
           if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {  
               return -1;  
           } else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {  
               return 1;  
           } else {  
               if (((Long)hashA.get("filesize")) > ((Long)hashB.get("filesize"))) {  
                   return 1;  
               } else if (((Long)hashA.get("filesize")) < ((Long)hashB.get("filesize"))) {  
                   return -1;  
               } else {  
                   return 0;  
               }  
           }  
       }  
   }  
     
   private class TypeComparator implements Comparator<Map<String, Object>> {  
       public int compare(Map<String, Object> hashA, Map<String, Object> hashB) {  
           if (((Boolean)hashA.get("is_dir")) && !((Boolean)hashB.get("is_dir"))) {  
               return -1;  
           } else if (!((Boolean)hashA.get("is_dir")) && ((Boolean)hashB.get("is_dir"))) {  
               return 1;  
           } else {  
               return ((String)hashA.get("filetype")).compareTo((String)hashB.get("filetype"));  
           }  
       }  
   }
}
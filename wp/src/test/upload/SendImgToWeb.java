package test.upload;
import java.io.BufferedReader;  
import java.io.File;  
import java.io.FileNotFoundException;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.io.InputStreamReader;  
import java.io.OutputStreamWriter;  
import java.io.PrintWriter;  
import java.net.HttpURLConnection;  
import java.net.MalformedURLException;  
import java.net.URL;  
 


import javax.servlet.ServletInputStream;  
import javax.servlet.http.HttpServletRequest;  

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
 
public class SendImgToWeb {  
   /** 
    * 获得网络图片地址。或者图片地址 
    * @param url 
    * @return 
    */  
   public String getContentFromWeb(String url)  
   {  
       String filecontent="";  
       InputStream is=null;  
       BASE64Encoder base=new BASE64Encoder();  
       if(url.startsWith("http"))  
       {  
           try {  
               HttpURLConnection urlconn=(HttpURLConnection)new URL(url).openConnection();  
               is=urlconn.getInputStream();  
           } catch (MalformedURLException e) {  
               // TODO Auto-generated catch block  
               e.printStackTrace();  
           } catch (IOException e) {  
               // TODO Auto-generated catch block  
               e.printStackTrace();  
           }  
       }  
       int n=0;  
       byte[] b=null;  
       try {  
           while((n=is.available())>0)  
           {  
               n=is.read(b);  
               if(n==-1)break;  
               filecontent=filecontent+base.encode(b);  
                 
           }  
           is.close();  
       } catch (IOException e) {  
           // TODO Auto-generated catch block  
           e.printStackTrace();  
       }  
       return filecontent;  
   }  
     
   /** 
    * 将图片内容用post方式发送到url中 
    * @param url 
    * @param postcontent 
    */  
     
   public void sendImgbyPost(String url,String postcontent)  
   {  
       try {  
           HttpURLConnection huc=(HttpURLConnection)new URL(url).openConnection();  
           huc.setDoInput(true);  
           huc.setDoOutput(true);  
           huc.setRequestMethod("POST");  
             
           PrintWriter pw=new PrintWriter(new OutputStreamWriter(huc.getOutputStream()));  
           pw.print(postcontent);  
           pw.close();  
             
           BufferedReader br=new BufferedReader(new InputStreamReader(huc.getInputStream()));  
           String content="";  
           String line=br.readLine();  
           while(line!=null)  
           {  
               content=content+line;  
               line=br.readLine();  
                  
           }  
             
       } catch (MalformedURLException e) {  
           // TODO Auto-generated catch block  
           e.printStackTrace();  
       } catch (IOException e) {  
           // TODO Auto-generated catch block  
           e.printStackTrace();  
       }  
         
   }  
   /** 
    * 在服务器端获取发送过来的内容 
    * @param request 
    * @return 
    */  
   public String receiveContent(HttpServletRequest request)  
   {  
       int a = 0;  
        byte[] b = new byte[4096];  
       String result="";  
       try  
       {  
        ServletInputStream sis=request.getInputStream();  
       int line=sis.readLine(b, 0, b.length);  
       while(line!=-1)  
       {  
       result=result+new String(b,0,line);  
       line=sis.readLine(b, 0, b.length);  
       }  
       }  
       catch(Exception e)  
       {  
       e.printStackTrace();  
       }  
       return  result;  
   }  
     
   /** 
    * 将接受过来的信息生成文件 
    * @param request 
    * @param filename 
    */  
   public void createFile(HttpServletRequest request,String filename)  
   {  
       File file=new File(filename);  
       try {  
           FileOutputStream fos=new FileOutputStream(file);  
           String content=receiveContent(request);  
           BASE64Decoder base=new BASE64Decoder();  
           byte[] b=base.decodeBuffer(content);  
           fos.write(b);  
           fos.close();  
             
       } catch (FileNotFoundException e) {  
           // TODO Auto-generated catch block  
           e.printStackTrace();  
       } catch (IOException e) {  
           // TODO Auto-generated catch block  
           e.printStackTrace();  
       }  
         
   }  
 
}   
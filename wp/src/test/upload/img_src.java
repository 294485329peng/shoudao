package test.upload;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class img_src {
public   static   void   main(String[]   args)   {  
        String   html   =   "<section style=\"height:auto;border-image:url(https://mmbiz.qlogo.cn/mmbiz/wyice8kFQhf7mgAMiaVODbRicQ6zUOz26dKTd5j0J1mmD76icsSLicIiaFY9WcnwM7msyfzdvL4P1gFuVicgiba56gy8iaA/0?wx_fmt=png) 40 fill/ 1em /0px round;overflow:hidden;margin:0 auto;\"><section style=\"margin-bottom:1em;background:url(https://mmbiz.qlogo.cn/mmbiz/wyice8kFQhf7mgAMiaVODbRicQ6zUOz26dK3HO4L04HcL0fX4MKJbj4m2oDlP5ic5kWJNibKTicDfLKgiaeWfIFKruTPw/0?wx_fmt=png) repeat-y 0 -1em;background-size:100%;\"><section style=\"margin:1em 0;line-height:1.3em;font-size:1.3em;\">"
+"<p style=\"margin:0;text-align:center;\">"
	+"圣诞快乐"
+"</p>"
+"<section style=\"float:right;width:2.7em;margin-top:-1.7em;margin-right:1.8em;\"><img src=\"https://mmbiz.qlogo.cn/mmbiz/wyice8kFQhf7mgAMiaVODbRicQ6zUOz26dKnp4En6oUM5iblwSW9Xl7JFhOia1urfOPNhaOcIic36AYiciaf5CLOx3BtSg/0?wx_fmt=png\" alt=\"\" _src=\"https://mmbiz.qlogo.cn/mmbiz/wyice8kFQhf7mgAMiaVODbRicQ6zUOz26dKnp4En6oUM5iblwSW9Xl7JFhOia1urfOPNhaOcIic36AYiciaf5CLOx3BtSg/0?wx_fmt=png\" /> </section></section><section style=\"line-height:1.8em;font-size:0.875em;padding:0 1em;text-align:left;\">"
+"<p style=\"margin:0;margin-left:0.3em;\">"
	+"圣诞节到了，96微信向支持我们的朋友和我们所爱的朋友说声感谢，感谢你走进我的世界，我会尽我最大的努力给你更便捷的体验，祝大家圣诞快乐！"
+"</p>"
+"</section></section></section><section style=\"width:90%;margin:0 auto;margin-top:0.5em;overflow:hidden;text-align:center;\"><img src=\"https://mmbiz.qlogo.cn/mmbiz/p6Vlqvia1Uicx9AHAibBNgCrEKc6jnFcYtDEJeoN65F86el7gAV22iaicylSUaibY38kofqdScc7TsD3iceujJw6lOCjg/0?wx_fmt=jpeg\" _src=\"https://mmbiz.qlogo.cn/mmbiz/p6Vlqvia1Uicx9AHAibBNgCrEKc6jnFcYtDEJeoN65F86el7gAV22iaicylSUaibY38kofqdScc7TsD3iceujJw6lOCjg/0?wx_fmt=jpeg\" /></section>"
+"<p style=\"width:90%;margin:0 auto;\">"
	+"<img src=\"https://mmbiz.qlogo.cn/mmbiz/wyice8kFQhf7mgAMiaVODbRicQ6zUOz26dKDDs5NUqjXibC3E7lR8jricFRkr737ibyDhHmCARA7SFPUy9YGLc6oBZEg/0?wx_fmt=png\" style=\"width:4em;float:right;margin-left:0.2em;\" _src=\"https://mmbiz.qlogo.cn/mmbiz/wyice8kFQhf7mgAMiaVODbRicQ6zUOz26dKDDs5NUqjXibC3E7lR8jricFRkr737ibyDhHmCARA7SFPUy9YGLc6oBZEg/0?wx_fmt=png\" />圣诞节到了，96微信向支持我们的朋友和我们所爱的朋友说声感谢，感谢你走进我的世界，我会尽我最大的努力给你更便捷的体验，祝大家圣诞快乐！"
+"</p>"
+"<p style=\"width:90%;margin:0 auto;\">"
	+"<br />"
+"</p>"
+"<p style=\"width:90%;margin:0 auto;\">"
	+"<br />"
+"</p>";  
         
        System.out.println(getImgSrc(html));  
    }  

    public   static   final   Pattern   PATTERN   =   Pattern.compile("<img\\s+(?:[^>]*)src\\s*=\\s*([^>]+)",   Pattern.CASE_INSENSITIVE   |   Pattern.MULTILINE);  
     
    public   static   List   getImgSrc(String   html)   {  
        Matcher   matcher   =   PATTERN.matcher(html);  
        List   list   =   new   ArrayList();  
        while   (matcher.find())   {  
            String   group   =   matcher.group(1);  
            if   (group   ==   null)   {  
                continue;  
            }  
            //   这里可能还需要更复杂的判断,用以处理src="...."内的一些转义符  
            if   (group.startsWith("'"))   {  
                list.add(group.substring(1,   group.indexOf("'",   1)));  
            }   else   if   (group.startsWith("\""))   {  
                list.add(group.substring(1,   group.indexOf("\"",   1)));  
            }   else   {  
                list.add(group.split("\\s")[0]);  
            }  
        } 
        System.out.println(list.size());
        return   list;  
    }

}
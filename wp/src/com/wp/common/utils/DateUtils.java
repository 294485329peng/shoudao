/**
 * @Title: DateUtils.java
 * @Package org.zxgs.jweb.utils
 * @Description: TODO(用一句话描述该文件做什么)
 * @author wp
 * @date 2012-8-10 上午8:59:17
 * @version V1.0
*/
package com.wp.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @Title: DateUtils.java
 * @Package org.zxgs.jweb.utils
 * @Description: 时间通用类
 * @author wp
 * @date 2012-8-10 上午8:59:17
 * @version V1.0
 */
public class DateUtils {
	public static String nowSysTime="";
	public static final String DEFAULT_DATE_DAY = "yyyy-MM-dd";
	public static final String DEFAULT_DATE_TYPE="yyyy-MM-dd HH:mm:ss";
	/**
	 * 
	 *@Description: TODO(两个日期的差值)
	 *@author wp
	 *@param time1
	 *@param time2
	 *@return
	 */
	public static long getQuot(String time1, String time2) {
		long quot = 0;
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date1 = ft.parse(time1);
			Date date2 = ft.parse(time2);
			quot = date1.getTime() - date2.getTime();
			quot = quot / 1000 / 60 / 60 / 24;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return quot;
	}
	/**
	 * 获取当前时间的分钟数值,当n=1时为分钟数，n=5时为五分钟数
	 * 
	 * @author : wp
	 * @description :
	 * @modify : 修改人 时间 简单描述
	 * @return
	 */
	public static int getNowMinNum(int n) {
		@SuppressWarnings("deprecation")
		int min = (new Date().getHours() * 60 + new Date().getMinutes()) / n;
		return min;
	}
	/**
	 * 
	 * @author      : wp
	 * @description : 某一天的点数 返回时间格式  yyyy-MM-dd HH:mm   当n=1时为分钟数，n=5时为五分钟数
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @param ntime
	 * @return
	 */
	@SuppressWarnings({ "deprecation", "unused" })
	public static Date getDayTime(String dayDate,int n , int ntime) {
		String strTime = "";
		Calendar calendar = Calendar.getInstance();
		 
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		int x = (int) Math.floor(ntime * n / 60);
		int y = ntime * n % 60;
//		calendar.set(calendar.HOUR, x);
//		calendar.set(calendar.MINUTE, y);
//		calendar.set(calendar.SECOND, 0);
		Date date = null;
		try {
			date = df.parse(dayDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		date.setHours(x);
		date.setMinutes(y);
		date.setSeconds(0);
		return date;
	}
	/**
	 * 
	 *@Description: 取得系统当前时间 String 自定义格式 yyyy年MM月dd日
	 *@author wp
	 *@date 2012-8-10 上午8:59:52
	 *@param str   yyyy年MM月dd日
	 *@return
	 */
	public static String getCurrentDate(String str) {
		SimpleDateFormat df=new SimpleDateFormat(str); 
		Calendar rightNow = Calendar.getInstance();
		return df.format(rightNow.getTime());
	}
	public static  Date parseDate(String strFormat, String dateValue) {	
		if (dateValue == null)		
			return null;	
		if (strFormat == null)	
			strFormat = DEFAULT_DATE_TYPE;
			SimpleDateFormat dateFormat = new SimpleDateFormat(strFormat);	
		Date newDate = null;	
		try {		
			newDate = dateFormat.parse(dateValue);	
		} catch (ParseException pe) {	
				newDate = null;	
	   }	
		return newDate;
	}
	/**
	 * 
	 *@Description: 获取当前时间 格式为yyyy-MM-dd
	 *@author wp
	 *@return
	 */
	public static String getCurrentDateDay() {
		SimpleDateFormat df=new SimpleDateFormat(DEFAULT_DATE_DAY); 
		Calendar rightNow = Calendar.getInstance();
		return df.format(rightNow.getTime());
	}
	/**
	 * 
	 *@Description: 获取当前时间 格式为yyyy-MM-dd HH:mm:ss
	 *@author wp
	 *@return
	 */
	public static String getCurrentDate() {
		SimpleDateFormat df=new SimpleDateFormat(DEFAULT_DATE_TYPE); 
		Calendar rightNow = Calendar.getInstance();
		return df.format(rightNow.getTime());
	}
	/**
	 * 
	 * @author      : wp
	 * @description :  取得系统当前时间前n个月的相对应的一天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return  String  
	 */
	@SuppressWarnings("static-access")
	public static String getNMonthBeforeCurrentDay(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.MONTH, -n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());

	}
 
	/**
	 * 
	 * @author      : wp
	 * @description : 取得系统当前时间后n个月的相对应的一天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return String  
	 */
	@SuppressWarnings("static-access")
	public static String getNMonthAfterCurrentDay(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.MONTH, n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());

	}
 
	/**
	 * 
	 * @author      : wp
	 * @description : 取得系统当前时间前n天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return String yyyy-mm-dd
	 */
	@SuppressWarnings("static-access")
	public static String getNDayBeforeCurrentDate(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.DAY_OF_MONTH, -n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());
	}
 
	/**
	 * 
	 * @author      : wp
	 * @description : 取得系统当前时间后n天
	 * @modify      : 修改人 时间 简单描述 
	 * @param n
	 * @return String yyyy-MM-dd
	 */
	@SuppressWarnings("static-access")
	public static String getNDayAfterCurrentDate(int n,String str) {
		Calendar c = Calendar.getInstance();
		c.add(c.DAY_OF_MONTH, n);
		SimpleDateFormat df=new SimpleDateFormat(str); 
		return df.format(c.getTime());
	}
}

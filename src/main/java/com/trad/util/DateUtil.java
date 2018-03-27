package com.trad.util;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSON;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by C-F on 15/4/20.
 * 日期处理类
 */
public class DateUtil {
    private static String defaultDatePattern = "yyyy-MM-dd";

	public static final String COMMON_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

	public static final  String COMMON_DATE_TO_HOUR_RANK = "yyyy-MM-dd HH";
	
	public static final  DateFormat yyyy_MM_dd_HH_mm=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	public static final  DateFormat  HH_mm_ss=new SimpleDateFormat("HH:mm:ss");

	public static final  String DEFAULT_ONLY_DATE_FORMAT = "yyyy-MM-dd";

	public static final  String RANK_UPDATE_TIME_FORMAT = "yyyy年MM月dd日HH:mm";

	public static final  String RANK_UPDATE_TIME_FORMAT_2 = "yyyy年MM月dd日HH:mm:ss";

	public static  final String SEQUENCE_UPDATE_TIME_FORMAT = "yyyyMMddHHmmss";
	
    /**
     * 获得默认的 date pattern
     */
    public static String getDatePattern() {
        return defaultDatePattern;
    }

    /**
     * 返回预设Format的当前日期字符串
     */
    public static String getToday() {
        Date today = new Date();
        return format(today);
    }

    /**
     * 使用预设Format格式化Date成字符串
     */
    public static String format(Date date) {
        return date == null ? " " : format(date, getDatePattern());
    }

    /**
     * 使用参数Format格式化Date成字符串
     */
    public static String format(Date date, String pattern) {
        return date == null ? " " : new SimpleDateFormat(pattern).format(date);
    }

    /**
     * 使用预设格式将字符串转为Date
     */
    public static Date parse(String strDate) throws ParseException {
        return StringUtils.isBlank(strDate) ? null : parse(strDate,
                getDatePattern());
    }

    /**
     * 使用参数Format将字符串转为Date
     */
    public static Date parse(String strDate, String pattern) {
        try {
			return StringUtils.isBlank(strDate) ? null : new SimpleDateFormat(
			        pattern).parse(strDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return null;
    }

    /**
     * 在日期上增加数个整月
     */
    public static Date addMonth(Date date, int n) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, n);
        return cal.getTime();
    }

    public static String getLastDayOfMonth(String year, String month) {
        Calendar cal = Calendar.getInstance();
        // 年
        cal.set(Calendar.YEAR, Integer.parseInt(year));
        // 月，因为Calendar里的月是从0开始，所以要-1
        // cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);
        // 日，设为一号
        cal.set(Calendar.DATE, 1);
        // 月份加一，得到下个月的一号
        cal.add(Calendar.MONTH, 1);
        // 下一个月减一为本月最后一天
        cal.add(Calendar.DATE, -1);
        return String.valueOf(cal.get(Calendar.DAY_OF_MONTH));// 获得月末是几号
    }

    public static Date getDate(String year, String month, String day)
            throws ParseException {
        String result = year + "- "
                + (month.length() == 1 ? ("0 " + month) : month) + "- "
                + (day.length() == 1 ? ("0 " + day) : day);
        return parse(result);
    }

    /**
     * 天数间隔
     * @param startTime
     * @param endTime
     * @param format
     */
    public static long dateDiffDay(String startTime, String endTime, String format) {
        //按照传入的格式生成一个simpledateformate对象
        SimpleDateFormat sd = new SimpleDateFormat(format);
        long nd = 1000 * 24 * 60 * 60;//一天的毫秒数
        long nh = 1000 * 60 * 60;//一小时的毫秒数
        long nm = 1000 * 60;//一分钟的毫秒数
        long ns = 1000;//一秒钟的毫秒数
        long diff;
        try {
            //获得两个时间的毫秒时间差异
            diff = sd.parse(endTime).getTime() - sd.parse(startTime).getTime();
            long day = diff / nd;//计算差多少天
            long hour = diff % nd / nh;//计算差多少小时
            long min = diff % nd % nh / nm;//计算差多少分钟
            long sec = diff % nd % nh % nm / ns;//计算差多少秒
            return day;
//            //输出结果
//            System.out.println("时间相差：" + day + "天" + hour + "小时" + min + "分钟" + sec + "秒。");
        } catch (ParseException e) {
            e.printStackTrace();
            return -1;
        }
    }
    
    
    public static String dateToLongStr() {
    	return dateToLongStr(new Date());
    }
    
    public static String dateToLongStr(Date date) {
    	SimpleDateFormat sd = new SimpleDateFormat("yyyyMMddHHmmss");
    	String str = sd.format(date);
    	return str;
    }
    

    /**
     * 计算两个日期的日子差
     * @param start
     * @param end
     * @return
     */
    public static int dayInterval(Date start, Date end)
    {
    	if(start==null){
    		return -1;
    	}
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(start);
        int startDay = calendar.get(Calendar.DAY_OF_YEAR);
        calendar.setTime(end);
        int endDay = calendar.get(Calendar.DAY_OF_YEAR);
        return endDay - startDay;
    }
    
    /**
     * 时间戳
     * @return
     */
    public static int timestamp() {
    	long time = System.currentTimeMillis();
    	return (int) (time/1000);
    }
    
    //计算两个日期相差天数
    //开始时间   结束时间
    public static int differentDays(Date date1,Date date2)
    {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(date1);
        
        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(date2);
       int day1= cal1.get(Calendar.DAY_OF_YEAR);
        int day2 = cal2.get(Calendar.DAY_OF_YEAR);
        
        int year1 = cal1.get(Calendar.YEAR);
        int year2 = cal2.get(Calendar.YEAR);
        if(year1 != year2)   //同一年
        {
            int timeDistance = 0 ;
            for(int i = year1 ; i < year2 ; i ++)
            {
                if(i%4==0 && i%100!=0 || i%400==0)    //闰年            
                {
                    timeDistance += 366;
                }
                else    //不是闰年
                {
                    timeDistance += 365;
                }
            }
            
            return timeDistance + (day2-day1) ;
        }
        else    //不同年
        {
          //  System.out.println("判断day2 - day1 : " + (day2-day1));
            return day2-day1;
        }
    }
    
	/**
	 * 得到今天凌晨0点的时刻
	 */
	public static Date getZeroPoint(){
		Calendar calendar = Calendar.getInstance();	
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		calendar.set(year, month, day, 0, 0, 00); 
		return calendar.getTime();
	}
	
	/**
	 * 以今天为基准，第N天的凌晨点，如beforeday=-1，昨天凌晨点
	 * @param beforeday 
	 * @return
	 */
	public static Date getZeroPoint(int beforeday){
		Calendar calendar = Calendar.getInstance();	
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		calendar.set(year, month, day, 0, 0, 00); 
		calendar.add(Calendar.DATE, beforeday);
		return calendar.getTime();
	}
	
	/**
	 * 判断两个日期是否属于年内同一个星期,中国时间计算周
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isSameWeekOfYear(Date date1,Date date2){
		Calendar c = Calendar.getInstance();
		c.setTime(date1);
		c.add(Calendar.DATE, -1);
		int year1=c.get(Calendar.YEAR);
		int week1=c.get(Calendar.WEEK_OF_YEAR);
		c.setTime(date2);
		c.add(Calendar.DATE, -1);
		int year2=c.get(Calendar.YEAR);
		int week2=c.get(Calendar.WEEK_OF_YEAR);
		if(year1==year2&&week1==week2){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 判断两个日期是否属于同一个月份
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static boolean isSameMonthOfYear(Date date1,Date date2){
		Calendar c = Calendar.getInstance();
		c.setTime(date1);
		int year1=c.get(Calendar.YEAR);
		int month1=c.get(Calendar.MONTH);
		c.setTime(date2);
		int year2=c.get(Calendar.YEAR);
		int month2=c.get(Calendar.MONTH);
		if(year1==year2&&month1==month2){
			return true;
		}else{
			return false;
		}
	}
    
	/**
	 * 加减年
	 * 
	 * @param date
	 * @param day
	 * @return
	 */
	public static Date addYear(Date d, int years) {
		// DateTime ld=new DateTime(d);
		// return ld.plusYears(years).toDate();
		Calendar cd = Calendar.getInstance();
		cd.setTime(d);
		cd.add(Calendar.YEAR, years);// 增加一年
		Date date = cd.getTime();
		cd = null;
		return date;
	}

    /**
     * 加减月
     * @param date
     * @param day
     * @return
     */
    public static Date addMonths(Date d,int months){
//    	DateTime ld=new DateTime(d);
//    	return ld.plusMonths(months).toDate();
    	Calendar cd = Calendar.getInstance();   
        cd.setTime(d);
        cd.add(Calendar.MONTH, months);//增加一月 
        Date date =  cd.getTime();
        cd = null;
        return date;
    }



    /**
     * 加减天
     * @param date
     * @param day
     * @return
     */
    public static Date addDays(Date d,int days){
//    	DateTime ld=new DateTime(d);
//    	return ld.plusDays(days).toDate();
    	Calendar cd = Calendar.getInstance();   
        cd.setTime(d);
        cd.add(Calendar.DATE, days);
        Date data = cd.getTime();
        cd = null;
        return data;
    }
    
    
    
    /**
     * 加减小时
     * @param date
     * @param day
     * @return
     */
    public static Date addHour(Date date,int hour){
    	Calendar cd = Calendar.getInstance();
        cd.setTime(date);
        cd.add(Calendar.HOUR, hour);
        Date data = cd.getTime();
        cd = null;
        return data;
    }
    
    
    /**
     * 加减分钟
     * @param date
     * @param day
     * @return
     */
    public static Date addMinute(Date date,int minute){
    	Calendar cd = Calendar.getInstance();
        cd.setTime(date);
        cd.add(Calendar.MINUTE, minute);
        Date data = cd.getTime();
        cd = null;
        return data;
    }
    /**
     * 加减分钟
     * @param date
     * @param day
     * @return
     */
    public static Date addMinute(int minute){
    	Date date = new Date();
    	return addMinute(date, minute);
    }
    


    /** 
     * 获取当年的第一天 
     * @param year 
     * @return 
     */  
    public static Date getCurrYearFirst(){  
        Calendar currCal=Calendar.getInstance();    
        int currentYear = currCal.get(Calendar.YEAR);  
        currCal = null;
        return getYearFirst(currentYear);  
    }  
      
    /** 
     * 获取当年的最后一天 
     * @param year 
     * @return 
     */  
    public static Date getCurrYearLast(){  
        Calendar currCal=Calendar.getInstance();    
        int currentYear = currCal.get(Calendar.YEAR);  
        currCal = null;
        return getYearLast(currentYear);  
    }  

    /** 
     * 获取某年第一天日期 
     * @param year 年份 
     * @return Date 
     */  
    public static Date getYearFirst(int year){  
        Calendar calendar = Calendar.getInstance();  
        calendar.clear();  
        calendar.set(Calendar.YEAR, year);  
        Date currYearFirst = calendar.getTime();  
        calendar= null;
        return currYearFirst;  
    }  
    
    /** 
     * 获取某年最后一天日期 
     * @param year 年份 
     * @return Date 
     */  
    public static Date getYearLast(int year){  
        Calendar calendar = Calendar.getInstance();  
        calendar.clear();  
        calendar.set(Calendar.YEAR, year);  
        calendar.roll(Calendar.DAY_OF_YEAR, -1);  
        Date currYearLast = calendar.getTime();  
        calendar = null;
        return currYearLast;  
    }
    
    /**
     * 获取月份第一天
     * 
     * @return
     */
    public static Date getMonthFirst(int month){
    	Calendar c = Calendar.getInstance();    
        c.add(Calendar.MONTH, month);
        c.set(Calendar.DAY_OF_MONTH,1);//设置为1号,获取月份第一天 
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(c.getTime());
		
        c = null;
        Date d = parse(date, "yyyy-MM-dd");
        date = null;
        return d;
    }
    /**
     * 获取月份第后一天
     * 
     * @return
     */
    public static Date getMonthLast(int month){
    	Calendar c = Calendar.getInstance();    
        c.add(Calendar.MONTH, month+1);
        c.set(Calendar.DAY_OF_MONTH,0);//设置为1号,获取月份第一天 
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(c.getTime());
		
        c = null;
        Date d = parse(date, "yyyy-MM-dd");
        date = null;
        return d;
    }
    

    /**
     * 获取当前时间所在年的周数
     * @param date
     * @return
     */
    public static int getWeekOfYear() {
        return getWeekOfYear( new Date());
    }
    /**
     * 获取当前时间所在年的周数
     * @param date
     * @return
     */
    public static int getWeekOfYear(Date date) {
        Calendar c = Calendar.getInstance(); 
        c.setFirstDayOfWeek(Calendar.MONDAY);
        c.setMinimalDaysInFirstWeek(7);
        c.setTime(date);
 
        return c.get(Calendar.WEEK_OF_YEAR);
    }
    

    /**
     * 获取当前时间所在年的最大周数
     * @param year
     * @return
     */
    public static int getMaxWeekNumOfYear(int year) {
        Calendar c = Calendar.getInstance(); 
        c.set(year, Calendar.DECEMBER, 31, 23, 59, 59);
 
        return getWeekOfYear(c.getTime());
    }
 

    /**
     * 获取某年的第几周的开始日期
     * @param year
     * @param week
     * @return
     */
    public static Date getFirstDayOfWeek(int year, int week) {
        Calendar c = Calendar.getInstance(); 
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, Calendar.JANUARY);
        c.set(Calendar.DATE, 1);
 
        Calendar cal =  (Calendar) c.clone();
        cal.add(Calendar.DATE, week * 7);
 
        return getFirstDayOfWeek(cal.getTime());
    }
 
    /**
     * 获取某年的第几周的结束日期
     * @param year
     * @param week
     * @return
     */
    public static Date getLastDayOfWeek(int year, int week) {
        Calendar c = Calendar.getInstance(); 
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, Calendar.JANUARY);
        c.set(Calendar.DATE, 1);
 
        Calendar cal = (Calendar) c.clone();
        cal.add(Calendar.DATE, week * 7);
 
        return getLastDayOfWeek(cal.getTime());
    }
 
    /**
     * 获取当前时间所在周的开始日期
     * @param date
     * @return
     */
    public static Date getFirstDayOfWeek(Date date) {
        Calendar c = Calendar.getInstance(); 
        c.setFirstDayOfWeek(Calendar.MONDAY);
        c.setTime(date);
        c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday
        return c.getTime();
    }
 
    /**
     * 获取当前时间所在周的结束日期
     * @param date
     * @return
     */
    public static Date getLastDayOfWeek(Date date) {
        Calendar c = Calendar.getInstance(); 
        c.setFirstDayOfWeek(Calendar.MONDAY);
        c.setTime(date);
        c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + 6); // Sunday
        return c.getTime();
    }
    
    public static void main(String[] args) {
    	
    }
    
    /**
     * 指定日期加上天数后的日期
     * @param num 为增加的天数
     * @param newDate 创建时间
     * @return
     * @throws ParseException 
     */
    public static String plusDay(int num,String newDate) throws ParseException{
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date  currdate = format.parse(newDate);
        System.out.println("现在的日期是：" + currdate);
        Calendar ca = Calendar.getInstance();
        ca.add(Calendar.DATE, num);// num为增加的天数，可以改变的
        currdate = ca.getTime();
        String enddate = format.format(currdate);
        System.out.println("增加天数以后的日期：" + enddate);
        return enddate;
    }
    
    public static String addDate(Date date,long day) throws ParseException {
    	 long time = date.getTime(); // 得到指定日期的毫秒数
    	 day = day*24*60*60*1000; // 要加上的天数转换成毫秒数
    	 time+=day; // 相加得到新的毫秒数
    	 return DateUtil.format(new Date(time)); // 将毫秒数转换成日期
    }
}

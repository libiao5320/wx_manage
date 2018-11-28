package cc.royao.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

    
    private final static long MILLISECONDS_EVERY_DAY = 24L * 3600 * 1000;
    
    /** 完整时间 yyyy-MM-dd HH:mm:ss */
    public static final String simple                  = "yyyy-MM-dd HH:mm:ss";
    
    public static final String sdf1 = "yyyy-MM-dd";
    
    /**
     * 将字符类型  yyyy-MM-dd装成日期类型
     * 
     * @param date
     * @return
     * @throws Exception
     */
    public static Date getDate1(String date) throws Exception{
    	SimpleDateFormat sdf=new SimpleDateFormat(sdf1);
    	return sdf.parse(date);
    }
    /**
     * 将天数加上多少天然后返回
     * @param date
     * @param day
     * @return
     */
    public static Date getDateAddDays(Date date,int day){
    	Calendar cl=Calendar.getInstance();
    	cl.setTime(date);
    	cl.add(Calendar.DAY_OF_YEAR, day);
    	return cl.getTime();
    }
    private DateUtil() {
    }

    /**
     * <p>当前日期时间</p>
     *
     * @return
     *
     */
    public static Date current() {
        return new Date();
    }

    /**
     * <p>判断指定日期是否在有效期之内。</p>
     *
     * <p>若指定时间是：2011-06-01 09:12:00，有期效为 10 天。当前时间在 2011-06-11 09:12:00 之后则表示已经不在有效期内。</p>
     *
     * @param date   指定时间
     * @param period  有效期（天）
     * @return
     *
     */
    public static boolean isIndate(Date date, int period) {
        return date.getTime() + MILLISECONDS_EVERY_DAY * period <= System.currentTimeMillis();
    }

    /**
     * <p>将 Date 中的时、分、秒、毫秒清零</p>
     *
     * @param date
     * @return
     *
     */
    public static Date clearTime(Date date) {
        if (date == null) {
            return null;
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    /**
     * <p>在日期基础上做基于日的加和减，并且将时、分、秒、毫秒清零</p>
     *
     * @param date           指定的日期
     * @param changeDays     变化的天数（负数表示减少，正数表示增加）
     * @return
     *
     */
    public static Date changeDayAndClearTime(Date date, int changeDays) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.DAY_OF_MONTH, changeDays);
        c.set(Calendar.HOUR, 0);
        c.set(Calendar.MINUTE, 0);
        c.set(Calendar.SECOND, 0);
        c.set(Calendar.MILLISECOND, 0);
        return c.getTime();
    }

    /**
     * <p>增加日期数</p>
     */
    public static Date incrementDay(Date date, int increment) {
        if (date == null) {
            return null;
        }
        if (increment < 1) {
            return date;
        }
        return changeDay(date, increment);
    }

    /**
     * <p>减少日期数</p>
     */
    public static Date decrementDay(Date date, int decrement) {
        if (date == null) {
            return null;
        }
        if (decrement < 1) {
            return date;
        }
        return changeDay(date, -decrement);
    }

    private static Date changeDay(Date date, int change) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.DAY_OF_MONTH, change);
        return c.getTime();
    }
    /**
     * 增加月份
     */
    public static Date incrementMonth(Date date, int increment) {
        if (date == null) {
            return null;
        }
        if (increment < 1) {
            return date;
        }
        return changeMonth(date, increment);
    }
    
    /**
     * 减少月份
     */

    public static Date decrementMonth(Date date, int decrement) {
        if (date == null) {
            return null;
        }
        if (decrement < 1) {
            return date;
        }
        return changeMonth(date, -decrement);
    }

    private static Date changeMonth(Date date, int change) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONTH, change);
        return c.getTime();
    }

    /**
	 * 获取系统当前日期(精确到毫秒)，格式：yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public  static String getDateFormatter(){
		Date date=new Date();
		DateFormat df=new SimpleDateFormat(simple);
		return df.format(date);
	}
    
    /**
     * <p>以 datetime 格式化日期</p>
     *
     * @param date
     * @return
     *
     */
    public static String formatDatetime(Date date) {
        if (date == null) {
            return null;
        }
        return format("yyyy-MM-dd HH:mm:ss", date);
    }
    
    /**
     * <p>以 datetime 格式化日期</p>
     *
     * @param date
     * @return
     *
     */
    public static String formatDatetimes(Date date) {
        if (date == null) {
            return null;
        }
        return format("HHmmssyyyyMMdd ", date);
    }

    /**
     * <p>以 date 格式化日期</p>
     *
     * @param date
     * @return
     *
     */
    public static String formatDate(Date date) {
        if (date == null) {
            return null;
        }
        return format("yyyyMMdd", date);
    }

    public static String format(String pattern, Date date) {
        return new SimpleDateFormat(pattern).format(date);
    }

    public static String format(String pattern) {
        return new SimpleDateFormat(pattern).format(current());
    }

    public static Date parse(String pattern, String strDateTime) {
        Date date = null;
        if (strDateTime == null || pattern == null)
            return null;
        try {
            SimpleDateFormat formatter = new SimpleDateFormat(pattern);
            formatter.setLenient(false);
            date = formatter.parse(strDateTime);
        } catch (ParseException e) {
            return null;
        }
        return date;
    }
    /**
     * 计算两个日期相差的年份
     * 
     * @param beginDate
     * @param endDate
     * @return
     */
    public static int getCompareYear(Date beginDate,Date endDate){
    	if(null ==beginDate || null ==endDate){
    		return 0;
    	}
    	Calendar begin = Calendar.getInstance();
    	Calendar end = Calendar.getInstance();
    	begin.setTime(beginDate);
    	end.setTime(endDate);
    	int year= end.get(Calendar.YEAR)-begin.get(Calendar.YEAR);
		return year;
    }
    
}

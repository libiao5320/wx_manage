package cc.royao.utils;

import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Locale;
import java.util.Map;

/**
 * 
 * @author yangx
 * @className 
 * @date 2016年3月14日下午7:57:32
 */
public class Validate {
    public static final String EMAIL_EXPRESSION = "^([_A-Za-z0-9-])+@(([A-Za-z0-9-])+\\.)+([a-zA-Z0-9]{2,4})+";

    public static final String MOBILE_EXPRESSION = "^1[3|4|5|6|7|8][0-9]{9}";

    /**
     * 验证字符串是否为空值
     * 
     * @param str
     * @return
     */
    public static boolean isEmpty(String str) {
        return (null == str) || (str.trim().length() == 0);
    }

    public static boolean isNotEmpty(String str) {
        return (str != null) && (str.length() > 0);
    }

    public static boolean isNotEmpty(Number id) {
        return id != null;
    }

    /**
     * 验证数组
     * 
     * @param array
     * @return
     */
    public static boolean isEmpty(Object[] array) {
        return (array == null) || (array.length == 0);
    }

    /**
     * 验证集合
     * 
     * @param collection
     * @return
     */
    public static boolean isEmpty(Collection<?> collection) {
        return (collection == null) || (collection.size() == 0);
    }

    /**
     * 验证map是否为空
     * 
     * @param map
     * @return
     */
    public static boolean isEmpty(Map<?, ?> map) {
        return (map == null) || (map.size() == 0);
    }

    public static boolean isLong(String str) {
        if (isEmpty(str)) {
            return false;
        }
        try {
            Long.valueOf(str);
        } catch (NumberFormatException ne) {
            return false;
        }
        return true;
    }

    /**
     * 验证是否为日期类型
     * 
     * @param value
     * @param locale
     * @return
     */
    public static boolean isDate(String value, Locale locale) {
        if (value == null) {
            return false;
        }

        DateFormat formatter = null;
        if (locale != null) {
            formatter = DateFormat.getDateInstance(3, locale);
        } else {
            formatter = DateFormat.getDateInstance(3, Locale.getDefault());
        }

        formatter.setLenient(false);
        try {
            formatter.parse(value);
        } catch (ParseException e) {
            return false;
        }

        return true;
    }

    public static boolean isDate(String value, String datePattern, boolean strict) {
        if ((value == null) || (datePattern == null) || (datePattern.length() <= 0)) {
            return false;
        }

        SimpleDateFormat formatter = new SimpleDateFormat(datePattern);
        formatter.setLenient(false);
        try {
            formatter.parse(value);
        } catch (ParseException e) {
            return false;
        }

        return (!strict) || (datePattern.length() == value.length());
    }

    /**
     * 验证字符串是否为email地址
     * 
     * @param value
     * @return
     */
    public static boolean isEmail(String value) {
        return validExpression(value, EMAIL_EXPRESSION);
    }

    /**
     * 正则表达试的验证
     * @param value
     * @param expression
     * @return
     */
    public static boolean validExpression(String value, String expression) {
        return value.matches(expression);
    }

    /**
     * 验证字符串是否为手机号码
     * 
     * @param value
     * @return
     */
    public static boolean isMobile(String value) {
        return validExpression(value, MOBILE_EXPRESSION);
    }

    /**
     * 验证是否为url地址
     * 
     * @param url
     * @return
     */
    public static boolean isUrl(String url) {
        if (url == null) {
            return false;
        }

        if (url.startsWith("https://")) {
            url = "http://" + url.substring(8);
        }

        try {
            new URL(url);

            return true;
        } catch (MalformedURLException e) {
        }
        return false;
    }
}

package cc.royao.utils;

import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by libia on 2016/1/25.
 */
public class Utf8CharConvert {

    public static Object conventUtf8Char(Object object) throws UnsupportedEncodingException {


        if (null != object) {

            if (object instanceof Map) {
                Map map = (Map) object;
                Map result = new HashMap();
                Set set = map.keySet();
                Iterator it = set.iterator();

                while (it.hasNext()) {
                    String key = (String) it.next();
                    Object value = map.get(key);
                    if (value instanceof String) {
                        String s = (String) value;
                        result.put(key, new String(s.getBytes("iso-8859-1"), "utf-8"));
                    } else
                        result.put(key, value);

                }
                return result;
            } else if (object instanceof String) {

                String value = (String) object;
                String result = new String(value.getBytes("iso-8859-1"), "utf-8");

            } else if (object instanceof List) {

                List l = (List) object;
                List result = new ArrayList();
                for (int i = 0; i < l.size(); i++) {
                    Object value = l.get(i);
                    if (value instanceof String) {
                        String s = (String) value;
                        result.add(new String(s.getBytes("iso-8859-1"), "utf-8"));
                    } else
                        result.add(value);

                }
                return result;

            }


        }

        return null;


    }
}

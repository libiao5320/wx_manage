package cc.royao.utils;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class MapUtil {

	
		@SuppressWarnings("rawtypes")
		public static Map<String,Object> MapFormat(Map map){
			Map<String,Object> reslut = new HashMap<String, Object>();
			
			Iterator entries = map.entrySet().iterator();
			 while (entries.hasNext()) {
				 Map.Entry entry = (Map.Entry) entries.next();
				 String value="";
				 String name = (String) entry.getKey();  
			     Object valueObj = entry.getValue();
			     if(valueObj instanceof String[]){
			    	 String[] values = (String[])valueObj;
			    	 for(int i=0;i<values.length;i++){  
			                value = values[i] + ",";  
			            }  
			            value = value.substring(0, value.length()-1);
			     }
			     System.out.println(value+"----------"+name);
			     reslut.put(name, value);
			 }
			
			return reslut;
		}
		
		
		//文件名称处理
		public static String handlerFileName(String fileName) {
			//处理名称start
			fileName = (new Date()).getTime()+"_"+fileName;
			//时间戳+文件名，防止覆盖重名文件
			String pre = StringUtils.substringBeforeLast(fileName, ".");
			String end = StringUtils.substringAfterLast(fileName, ".");
			fileName = pre+"."+end;//用MD5编码文件名，解析附件名称
			//处理名称end
			return fileName;
		}
}

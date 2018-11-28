package cc.royao.commons.httpClient;

import cc.royao.utils.AdminConfig;

import com.alibaba.fastjson.JSON;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpUtil {

	/**
	 * 通过post向服务器端发送数据，并获得服务器端输出流
	 * @param urlPath  请求路径
	 * @param params  Map中key为请求参数，value为请求参数的值
	 * @param encoding  编码方式
	 * @throws Exception
	 */
	public static ResponseContent getInputStreamByPost(String urlPath,
			RequestContent content, String encoding) throws IOException {

		String path = AdminConfig.httpUrl+urlPath;
		ResponseContent  responseContent = null;
		String data = JSON.toJSONString(content);
		
		URL url = new URL(path);
		// 打开连接
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		// 设置提交方式
		conn.setDoOutput(true);
		conn.setDoInput(true);
		conn.setRequestMethod("POST");
		// post方式不能使用缓存
		conn.setUseCaches(false);
		conn.setInstanceFollowRedirects(true);
		// 设置连接超时时间
		conn.setConnectTimeout(8 * 1000);
		// 配置本次连接的Content-Type，配置为application/x-www-form-urlencoded
		conn.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded");
		// 维持长连接
		conn.setRequestProperty("Connection", "Keep-Alive");
		conn.setRequestProperty("Accept-Charset", "utf-8");
		conn.setRequestProperty("contentType", "utf-8");
		// 设置浏览器编码
		conn.setRequestProperty("Charset", "UTF-8");
		OutputStreamWriter dos = new OutputStreamWriter(conn.getOutputStream());
		// 将请求参数数据向服务器端发送
		// dos.writeBytes(data);
		dos.write(new String(data.getBytes(encoding)));
		dos.flush();
		dos.close();


		InputStream input  = null;
		if( conn.getResponseCode() == 200 )
			input = conn.getInputStream();
		else {
			throw new IOException("Http invoke error : " +conn.getResponseCode());
		}
		BufferedReader bufferReader = new BufferedReader(new InputStreamReader(input,"utf-8"));
		StringBuffer buffer = new StringBuffer();
		String jsonObj = "";
		try {
			while(!( (jsonObj =  bufferReader.readLine()) == null ) )
			{
				buffer.append(jsonObj);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if( null != buffer )
			responseContent	 = (ResponseContent) JSON.parseObject(buffer.toString(),ResponseContent.class);
		return responseContent;


	}

	// 通过输入流获得字节数组
	public static byte[] readStream(InputStream is) throws Exception {
		byte[] buffer = new byte[1024];
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		int len = 0;
		while ((len = is.read(buffer)) != -1) {
			bos.write(buffer, 0, len);
		}
		is.close();
		return bos.toByteArray();
	}
	
	public static String readStreamToString(InputStream is ){
		BufferedReader r = new BufferedReader(new InputStreamReader(is));
		String result = "";
		try {
				result += r.readLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				r.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}
	
	  /**  
     * 数组转对象  
     * @param bytes  
     * @return  
     */  
    public static Object toObject (byte[] bytes) {      
        Object obj = null;      
        try {        
            ByteArrayInputStream bis = new ByteArrayInputStream (bytes);        
            ObjectInputStream ois = new ObjectInputStream (bis);        
            obj = ois.readObject();      
            ois.close();   
            bis.close();   
        } catch (IOException ex) {        
            ex.printStackTrace();   
        } catch (ClassNotFoundException ex) {        
            ex.printStackTrace();   
        }      
        return obj;    
    }   
}

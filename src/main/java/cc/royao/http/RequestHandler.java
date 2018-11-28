package cc.royao.http;

import com.alibaba.fastjson.JSON;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * Created by libia on 2016/1/15.
 */
public class RequestHandler {

    public static RequestContent execute(HttpServletRequest request) {



        InputStream in;
        BufferedReader reader = null;
        String str = "";
        StringBuffer buffer = new StringBuffer();


        try {
            str = request.getQueryString();
            in = request.getInputStream();
            reader = new BufferedReader(new InputStreamReader(in,"utf-8"));

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String input = null;
        try {
            while (!((input = reader.readLine()) == null)) {
                buffer.append(input);
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


        RequestContent requestContent = JSON.parseObject(buffer.toString(), RequestContent.class);
        return requestContent;
    }


}

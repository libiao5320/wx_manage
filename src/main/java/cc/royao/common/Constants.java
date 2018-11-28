package cc.royao.common;

import org.springframework.core.io.support.PropertiesLoaderUtils;

import java.io.IOException;
import java.util.Properties;

/**
 * Created by libia on 2016/1/18.
 */
public class Constants {


        private static Properties configProperties;

        public final static String PAGE_SUCCESS = "success";
        public final static String PAGE_FAIL = "fail";
        public final static String PAGE_NOTFOUND= "notfound";
        public final static String PAGE_ERROR= "error";



        public final static int PAGE_SIZE = 10;
//        public final static String PAGE_ERROR= "error";



        public final static int  STAUS_NOTMAL = 1;
        public final static int  STAUS_SUSPEND = 2;
        public final static int  STAUS_DEL = -1;

        public final static String CENTER_URL = configProperties.getProperty("center_url");

        public final static String IS_DEBUG = configProperties.getProperty("is_debug");

        public final static String SESSION_USERINFO = "userinfo";
        public final static String SESSION_PRIVILEGEINFO = "privilegeinfo";
        public final static String SERVLETCONTEXT_MENU = "MENU";




        static
        {
                try {
                        configProperties = PropertiesLoaderUtils.loadAllProperties("config.propeties");
                } catch (IOException e) {
                        e.printStackTrace();
                }
        }



}

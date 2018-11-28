package cc.royao.utils;

import java.io.IOException;
import java.io.InputStream;
import java.text.MessageFormat;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.ServletContextResource;

public class Config {
    private final static Logger logger = Logger.getLogger(Config.class);

    /**
     * 资源文件名称
     */
    private final static String CONFIG_PROPERTY_FILENAME = "config.properties";

    private static Properties properties;

    static {
        try {
            loadConfig();
        } catch (IOException e) {
            throw new IllegalStateException("load message resource " + CONFIG_PROPERTY_FILENAME + " error", e);
        }
    }

    public static String get(String name, Object... args) {
        String message = properties.getProperty(name);
        if (args == null || args.length == 0) {
            return message;
        }
        return MessageFormat.format(message, args);
    }

    private static void loadConfig() throws IOException {
        if (properties != null) {
            return;
        }
        properties = new Properties();
        properties.load(getInputStream());
    }

    /**
     * 加载资源文件
     * @return
     */
    private static InputStream getInputStream() {
    	
        // 从当前类加载器中加载资源
//        InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream(CONFIG_PROPERTY_FILENAME);


        WebApplicationContext webApplicationContext  = ContextLoader.getCurrentWebApplicationContext();


        ServletContextResource servletContextResource = new ServletContextResource(webApplicationContext.getServletContext(),"WEB-INF/config.properties");

        InputStream is  = null;

        try {
            is = servletContextResource.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (is != null) {
            logger.info("load message file " + CONFIG_PROPERTY_FILENAME + " from current thread class loader context");
            return is;
        }

        logger.info("cannot load message file " + CONFIG_PROPERTY_FILENAME + " from current thread class loader context");

        // 从系统类加载器中加载资源
        is = ClassLoader.getSystemResourceAsStream(CONFIG_PROPERTY_FILENAME);
        if (is != null) {
            logger.info("load message file " + CONFIG_PROPERTY_FILENAME + " from system class loader context");
            return is;
        }
        throw new IllegalStateException("cannot find " + CONFIG_PROPERTY_FILENAME + " anywhere");
    }
}

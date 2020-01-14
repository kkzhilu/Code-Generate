package com.mysql.factory;

import com.alibaba.fastjson.JSONObject;
import com.mysql.bean.ConfigurationInfo;
import com.mysql.bean.GlobleConfig;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/9 17:05
 * description:  配置文件解析器
 * version:      V1.0
 * ******************************
 */
public class PropertiesFactory {

    /***
     * 配置文件KEYS
     */
    private static final String[] KEYS = {"ip", "port", "driver", "dataBase", "encoding", "loginName", "passWord"
            , "include", "projectName", "packageName", "authorName", "rootPath"};

    /***
     * 配置文件默认Values
     */
    private static final String[] VALUES = {"127.0.0.1", "3306", "com.mysql.jdbc.Driver", "db_file", "UTF-8", "root", ""
            , "*", "Demo", "com.demo", "Kerwin", "F:\\code"};

    /***
     * 加载全局配置
     * @throws IOException 默认抛出IO异常
     */
    public static void loadProperties() throws IOException {
        // 兼容Jar包外 处理配置文件
        String filePath = System.getProperty("user.dir") + File.separator + "application.properties";
        InputStream inStream;
        if (new File(filePath).exists()) {
            inStream = new FileInputStream(filePath);
        } else {
            inStream = PropertiesFactory.class.getClassLoader().getResourceAsStream("application.properties");
        }

        Properties prop = new Properties();
        prop.load(inStream);

        // FastJson 构造对象
        JSONObject json = new JSONObject();

        for (int i = 0; i < KEYS.length; i++) {
            String value = prop.getProperty(KEYS[i], VALUES[i]);
            json.put(KEYS[i], value);
        }

        ConfigurationInfo configurationInfo = json.toJavaObject(ConfigurationInfo.class);
        configurationInfo.setIncludeMap(parseInclude(configurationInfo.getInclude()));

        GlobleConfig.setGlobleConfig(configurationInfo);
        logger.info("Properties load Successful, Msg is: " + json);
    }

    /***
     * 解析需要构造的表Map方法
     */
    private static Map<String, String> parseInclude(String include) {
        Map<String, String> result = new HashMap<>();
        if (StringUtils.isBlank(include)) {
            return result;
        }

        String[] strings = include.split(";");
        for (String key : strings) {
            result.put(key, key);
        }

        return result;
    }

    private static Logger logger = LoggerFactory.getLogger(PropertiesFactory.class);
}

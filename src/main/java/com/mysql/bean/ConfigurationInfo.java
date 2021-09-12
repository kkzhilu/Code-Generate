package com.mysql.bean;

import lombok.Data;

import java.util.Map;

/**
 * ******************************
 * author：      Kerwin
 * createTime:   2020/1/9 17:08
 * description:  解析配置信息
 * version:      V1.0
 * ******************************
 */
@Data
public class ConfigurationInfo {

    /**
     * Ip
     */
    private String ip;

    /**
     * port
     */
    private String port;

    /**
     * driver
     */
    private String driver;

    /**
     * 数据库名
     */
    private String dataBase;

    /**
     * 编码
     */
    private String encoding;

    /**
     * 用户名
     */
    private String loginName;

    /**
     * 密码
     */
    private String passWord;

    /***
     * 需要处理的表名 以 ; 划分
     */
    private String include;

    /***
     * 需要处理的表名Map
     */
    private Map<String, String> includeMap;

    /***
     * 需要处理的自定义Handle名 以 ; 划分
     */
    private String customHandleInclude;

    /***
     * 需要处理的自定义Handle名
     */
    private Map<String, String> customHandleIncludeMap;

    /**
     * 项目名
     */
    private String projectName;

    /**
     * 包名
     */
    private String packageName;

    /**
     * 作者名
     */
    private String authorName;

    /**
     * 文件根目录
     */
    private String rootPath;

    /**
     * 项目根目录
     */
    private String projectPath;
}

package com.mysql.bean;

import lombok.Data;

/**
 * ******************************
 * author：      柯贤铭
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
}

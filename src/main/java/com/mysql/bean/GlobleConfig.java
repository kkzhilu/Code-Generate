package com.mysql.bean;

import com.mysql.factory.PropertiesFactory;

import java.io.IOException;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/9 17:11
 * description:  单例模式 -> 全局配置信息
 * version:      V1.0
 * ******************************
 */
public final class GlobleConfig {

    // 配置信息
    private static Configuration CONFIGURATION = null;

    /***
     * 获取全局配置
     * 单例模式 双重锁校验
     */
    public static Configuration getGlobleConfig() {
        if (null == CONFIGURATION) {
            synchronized (GlobleConfig.class) {
                if (null == CONFIGURATION) {
                    try {
                        PropertiesFactory.loadProperties();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return CONFIGURATION;
    }

    public static void setGlobleConfig(Configuration CONFIGURATION) {
        GlobleConfig.CONFIGURATION = CONFIGURATION;
    }

    private GlobleConfig() {}
}

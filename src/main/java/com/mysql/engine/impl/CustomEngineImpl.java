package com.mysql.engine.impl;

import com.mysql.bean.ClassInfo;
import com.mysql.bean.ConfigurationInfo;
import com.mysql.bean.GlobleConfig;
import com.mysql.factory.ClassInfoFactory;
import com.mysql.intercept.CustomEngine;
import org.reflections.Reflections;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;

import java.util.List;
import java.util.Set;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/17 9:18
 * description:  CustomEngineImpl 基于自定义拦截接口的方法调用
 *               基于org.reflections进行全量文件接口扫描
 * version:      V1.0
 * ******************************
 */
public final class CustomEngineImpl {

    /***
     * 扫描全包获取 实现CustomEngine接口的类
     */
    private static Set<Class<? extends CustomEngine>> toDos () {
        Reflections reflections = new Reflections(new ConfigurationBuilder()
                .setUrls(ClasspathHelper.forPackage(""))
                .filterInputsBy(input -> {
                    assert input != null;
                    return input.endsWith(".class");
                }));

        return reflections.getSubTypesOf(CustomEngine.class);
    }

    public static void handleCustom() {
        Set<Class<? extends CustomEngine>> classes = toDos();
        for (Class<? extends CustomEngine> aClass : classes) {
            try {
                // 基于反射构建对象 - 调用handle方法
                CustomEngine engine = aClass.newInstance();
                engine.handle(GlobleConfig.getGlobleConfig(), ClassInfoFactory.getClassInfoList());
            } catch (InstantiationException | IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }
}

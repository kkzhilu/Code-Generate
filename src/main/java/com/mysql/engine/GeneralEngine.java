package com.mysql.engine;

import com.mysql.bean.ClassInfo;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/10 9:18
 * description:  具体涉及GeneralEngine
 * version:      V1.0
 * ******************************
 */
public interface GeneralEngine {

    /***
     * 执行器执行
     */
    void execute();

    /**
     * 生成固有的文件
     */
    void genFix();

    /**
     * 生成控制层 GeneralEngine
     */
    void genController(ClassInfo classInfo);

    /**
     * 生成业务层(
     */
    void genService(ClassInfo classInfo);

    /**
     * 生成持久层类
     */
    void genRepositoryClass(ClassInfo classInfo);

    /**
     * 生成持久层xml
     */
    void genRepositoryXml(ClassInfo classInfo);

    /**
     * 生成实体
     */
    void genEntity(ClassInfo classInfo);

    /**
     * 生成配置文件(包括pom.xml,application.yml,application.properties)
     */
    void genConfig();
}

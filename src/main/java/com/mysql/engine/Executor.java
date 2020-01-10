package com.mysql.engine;

import com.mysql.bean.ClassInfo;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/10 9:17
 * description:  代码生成顶级接口
 * version:      V1.0
 * ******************************
 */
public interface Executor {

    /**
     * 执行生成计划
     */
    void execute(ClassInfo classInfo);
}

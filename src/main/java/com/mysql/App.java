package com.mysql;

import com.mysql.engine.AbstractEngine;

/**
 * ******************************
 * author：      Kerwin
 * createTime:   2020/1/9 16:58
 * description:  Code-Generate 代码生成器运行类
 * version:      V1.0
 * ******************************
 */
public class App {

    /***
     * 执行 - 构建项目
     */
    public static void main(String[] args){
        AbstractEngine engine = AbstractEngine.init();
        engine.execute();
    }
}

package com.mysql.bean;

import lombok.Data;

import java.util.List;

/**
 * ******************************
 * author：      Kerwin
 * createTime:   2020/1/9 17:08
 * description:  ClassInfo 表信息
 * version:      V1.0
 * ******************************
 */
@Data
public class ClassInfo {

    /***
     * 表名
     */
    private String tableName;

    /**
     * class类名
     */
    private String className;

    /**
     * class实体参数名 如: classInfo
     */
    private String modelName;

    /**
     * class注释
     */
    private String classComment;

    /***
     * 主键字段及值 (默认以持有字段的 index=0 为主键)
     */
    private FieldInfo key;

    /**
     * 持有字段
     */
    private List<FieldInfo> fieldList;
}
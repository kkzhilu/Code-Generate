package com.mysql.bean;

import lombok.Data;

import java.util.List;

/**
 * ******************************
 * author：      柯贤铭
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
     * class注释
     */
    private String classComment;

    /**
     * 持有字段
     */
    private List<FieldInfo> fieldList;
}
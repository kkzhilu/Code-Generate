package com.mysql.bean;

import lombok.Data;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/9 17:08
 * description:  FieldInfo 字段信息
 * version:      V1.0
 * ******************************
 */
@Data
public class FieldInfo {

    /**
     * 字段名
     */
    private String columnName;

    /**
     * Model名
     */
    private String fieldName;

    /**
     * 所属类
     */
    private String fieldClass;

    /**
     * 字段注释
     */
    private String fieldComment;
}

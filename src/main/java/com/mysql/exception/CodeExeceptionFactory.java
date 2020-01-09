package com.mysql.exception;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2019/8/28 11:23
 * description:  Code Exception
 * version:      V1.0
 * ******************************
 */
public class CodeExeceptionFactory{

    /**
     * Properties Error
     */
    public static CodeExeception propertiesError (String message) {
        return new CodeExeception("properties is wrong: " + message);
    }
}

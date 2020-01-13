package ${packageName}.common;

import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Api响应类
 * ApiResult.java
 * @author ${authorName}
 * @date ${.now?string('yyyy/MM/dd')}
 */
public class ApiResult<T> implements Serializable {

    /**
     * 状态码
     */
    private Integer code;

    /**
     * 数据
     */
    private T data;

    /**
     * 错误信息
     */
    private String msg;

    /***
     * 时间
     */
    private String time;

    /***
     * 地址
     */
    private String path;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public ApiResult(Integer code, T data, String msg, String path) {
        this.code = code;
        this.data = data;
        this.msg = msg;
        this.path = path;
        this.time = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
    }
}
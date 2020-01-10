package ${packageName}.common;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;

import java.io.Serializable;

/**
 * ${classInfo.classComment}
 * @author ${authorName}
 * @data ${.now?string('yyyy-MM-dd hh:mm:ss')}
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ${genConfig.resultName} implements Serializable {
    private static final int SUCCESS_STATUS = 0;
    private static final int FAIL_STATUS = 1;
    private static final String SUCCESS_MSG = "success";
    private static final String FAIL_MSG = "fail";
    private Integer code;
    private String msg;
    private Object data;
    private Integer count;

    public ${genConfig.resultName}() {
    }

    public ${genConfig.resultName}(int code, String msg, Object data, Integer count) {
        this.code = code;
        this.msg = msg;
        this.data = data;
        this.count = count;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public static ${genConfig.resultName} success() {
        return new ${genConfig.resultName}(SUCCESS_STATUS, SUCCESS_MSG, null, null);
    }

    public static ${genConfig.resultName} success(Object data) {
        return new ${genConfig.resultName}(SUCCESS_STATUS, SUCCESS_MSG, data, null);
    }

    public static ${genConfig.resultName} fail() {
        return new ${genConfig.resultName}(FAIL_STATUS, FAIL_MSG, null, null);
    }

    public static ${genConfig.resultName} fail(String msg) {
        return new ${genConfig.resultName}(FAIL_STATUS, msg, null, null);
    }

    public static ${genConfig.resultName} page(Object data, int count) {
        return new ${genConfig.resultName}(SUCCESS_STATUS, SUCCESS_MSG, data, count);
    }
}

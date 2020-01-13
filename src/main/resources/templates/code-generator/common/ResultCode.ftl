package ${packageName}.common;

/***
 * 返回码
 */
public enum ResultCode {

    success                 ( 1, "成功"),

    wrong                   ( 0, "无查询结果"),

    failed                  (-1, "失败"),
    ;

    private Integer code;

    private String descr;

    ResultCode(Integer code, String descr) {
        this.code = code;
        this.descr = descr;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }
}
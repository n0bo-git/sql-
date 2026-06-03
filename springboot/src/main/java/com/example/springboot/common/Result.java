package com.example.springboot.common;

/**
 * 接口统一返回包装类
 */
public class Result {

    public static final String CODE_SUCCESS = "200";
    public static final String CODE_AUTH_ERROR = "401";
    public static final String CODE_SYS_ERROR = "500";

    /**
     * 请求的返回编码  200   401   404  500
     * 编码表示这次请求是成功还是失败
     * 或者说  可以看出失败的类型是什么
     */
    private String code;
    /**
     * msg表示错误的详细信息
     */
    private String msg;
    /**
     * 数据从什么地方返回出去？
     * 就是这个data
     */
    private Object data;

    public Result() {}

    public Result(String code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getMsg() { return msg; }
    public void setMsg(String msg) { this.msg = msg; }

    public Object getData() { return data; }
    public void setData(Object data) { this.data = data; }

    // simple builder implementation
    public static Builder builder() { return new Builder(); }

    public static class Builder {
        private String code;
        private String msg;
        private Object data;

        public Builder code(String code) { this.code = code; return this; }
        public Builder msg(String msg) { this.msg = msg; return this; }
        public Builder data(Object data) { this.data = data; return this; }
        public Result build() { return new Result(code, msg, data); }
    }

    public static Result success() {
        return Result.builder().code(CODE_SUCCESS).msg("请求成功").build();
    }

    public static Result success(Object data) {
        return new Result(CODE_SUCCESS, "请求成功", data);
    }

    public static Result error(String msg) {
        return new Result(CODE_SYS_ERROR, msg, null);
    }

    public static Result error(String code, String msg) {
        return new Result(code, msg, null);
    }

    public static Result error() {
        return new Result(CODE_SYS_ERROR, "系统错误", null);
    }

}

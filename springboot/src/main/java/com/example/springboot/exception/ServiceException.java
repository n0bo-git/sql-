package com.example.springboot.exception;

/**
 * 自定义异常
 */
public class ServiceException extends RuntimeException {

    private final String code;

    public ServiceException(String msg) {
        super(msg);
        this.code = "500";
    }

    public ServiceException(String code, String msg) {
        super(msg);
        this.code = code;
    }

    public String getCode() { return code; }

}

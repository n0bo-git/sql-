package com.example.springboot.common;

import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.example.springboot.entity.User;
import com.example.springboot.mapper.UserMapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;


/**
 * JWT认证拦截器
 * 作用：拦截请求并验证JWT令牌的有效性，实现基于令牌的身份认证
 * 仅允许携带有效令牌的请求访问受保护接口，或标记了@AuthAccess注解的接口
 */
public class JwtInterceptor implements HandlerInterceptor {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private UserMapper userMapper; // 用户数据访问接口，用于查询用户信息验证身份

    /**
     * 请求处理前执行的拦截方法
     * 验证请求中的JWT令牌，通过则放行，否则直接返回 JSON 401 错误
     *
     * @param request  HTTP请求对象，用于获取请求头或参数中的token
     * @param response HTTP响应对象
     * @param handler  拦截到的处理器（方法或资源）
     * @return boolean 认证通过返回true（放行），否则返回false（拦截）
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 1. 从请求头或URL参数中获取token
        String token = request.getHeader("token");  // 优先从请求头获取token
        if (StrUtil.isBlank(token)) {
            token = request.getParameter("token");  // 若请求头无token，则从URL参数获取
        }

        // 2. 处理无需认证的接口（标记了@AuthAccess注解的方法）
        if (handler instanceof HandlerMethod) {
            AuthAccess annotation = ((HandlerMethod) handler).getMethodAnnotation(AuthAccess.class);
            if (annotation != null) {
                return true;  // 存在该注解，接口无需认证，直接放行
            }
        }

        // 3. 验证token是否存在
        if (StrUtil.isBlank(token)) {
            return writeAuthError(response, "token为空，请重新登录");
        }

        // 4. 解析token获取用户ID
        String userId;
        try {
            userId = JWT.decode(token).getAudience().get(0);
        } catch (JWTDecodeException e) {
            return writeAuthError(response, "token格式错误，请重新登录");
        }

        // 5. 根据用户ID查询数据库验证用户是否存在
        User user;
        try {
            user = userMapper.selectById(Integer.valueOf(userId));
        } catch (NumberFormatException e) {
            return writeAuthError(response, "token中用户ID无效，请重新登录");
        }
        if (user == null) {
            return writeAuthError(response, "用户不存在，请重新登录");
        }

        // 6. 验证token的有效性（使用用户密码作为密钥验证签名）
        try {
            JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256(user.getPassword())).build();
            jwtVerifier.verify(token);
        } catch (JWTVerificationException e) {
            return writeAuthError(response, "token已过期或签名错误，请重新登录");
        }

        // 7. 所有验证通过，将用户ID存入request供后续使用
        request.setAttribute("userId", userId);
        return true;
    }

    /**
     * 向客户端写入 JSON 格式的 401 认证错误响应
     * 不能在拦截器中抛异常（不会被 @ControllerAdvice 捕获），必须手动写响应
     */
    private boolean writeAuthError(HttpServletResponse response, String message) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);  // HTTP 401
        response.setContentType("application/json;charset=UTF-8");
        try {
            PrintWriter writer = response.getWriter();
            Map<String, Object> result = new HashMap<>();
            result.put("code", "401");
            result.put("msg", message);
            result.put("data", null);
            writer.write(objectMapper.writeValueAsString(result));
            writer.flush();
        } catch (IOException ignored) {
            // 响应已提交或 IO 异常，无法写入
        }
        return false;  // 不放行
    }
}

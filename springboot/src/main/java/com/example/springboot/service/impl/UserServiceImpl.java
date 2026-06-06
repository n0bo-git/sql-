package com.example.springboot.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.springboot.entity.User;
import com.example.springboot.exception.ServiceException;
import com.example.springboot.mapper.UserMapper;
import com.example.springboot.service.IUserService;
import com.example.springboot.utils.TokenUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public boolean save(User entity) {
        if (StrUtil.isBlank(entity.getPassword())) {
            entity.setPassword("123");
        }
        if (entity.getRole() == null) {
            entity.setRole(2);  // 默认普通用户
        }
        return super.save(entity);
    }

    /** role 为 null 时不加条件 */
    public User selectByUsername(String username, Integer role) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        if (role != null) {
            queryWrapper.eq("role", role);
        }
        return getOne(queryWrapper);
    }

    public User login(User user) {
        User dbUser = selectByUsername(user.getUsername(), user.getRole());
        if (dbUser == null) {
            throw new ServiceException("用户名或密码错误");
        }
        if (!user.getPassword().equals(dbUser.getPassword())) {
            throw new ServiceException("用户名或密码错误");
        }
        String token = TokenUtils.createToken(dbUser.getId().toString(), dbUser.getPassword());
        dbUser.setToken(token);
        return dbUser;
    }

    public User register(User user) {
        User dbUser = userMapper.selectOne(new LambdaQueryWrapper<User>().eq(User::getUsername, user.getUsername()));
        if (dbUser != null) {
            throw new ServiceException("用户名已存在");
        }
        if (user.getRole() == null) {
            user.setRole(2);
        }
        userMapper.insert(user);
        return user;
    }

    public void resetPassword(User user) {
        User dbUser = userMapper.selectOne(new LambdaQueryWrapper<User>().eq(User::getUsername, user.getUsername()));
        if (dbUser == null) {
            throw new ServiceException("用户不存在");
        }
        dbUser.setPassword("123");
        updateById(dbUser);
    }

    @Override
    public void updatePassword(User user) {
        int update = userMapper.updatePassword(user);
        if (update < 1) {
            throw new ServiceException("原始密码错误");
        }
    }
}

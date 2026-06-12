package com.example.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.springboot.entity.HelloTest;
import org.apache.ibatis.annotations.*;

import java.lang.reflect.Type;
import java.util.List;


public interface HelloMapper extends BaseMapper<Type> {
    @Select("select * from hellotest")
    List<HelloTest> selectAll();
    @Insert("insert into hellotest(id, name) values(#{id}, #{name})")
    void insertHello(HelloTest HelloTest);
    @Update("update hellotest set name = #{name} where id = #{id}")
    void updateHello(HelloTest helloTest);

    @Delete("delete from hellotest where id = #{id}")
    void deleteById(Long id);
}
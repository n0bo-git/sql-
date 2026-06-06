package com.example.springboot;

import com.example.springboot.entity.HelloTest;
import com.example.springboot.mapper.HelloMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
class SpringbootApplicationTests {

	@Autowired
	private HelloMapper helloMapper;

	@Test
	void contextLoads() {



	}

}

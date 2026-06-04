package com.example.springboot.controller;


import com.example.springboot.common.AuthAccess;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/hello")
public class HelloController {

    @AuthAccess
    @GetMapping
    public  String hello(){
        return "hello";
    }
}

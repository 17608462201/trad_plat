package com.trad;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.trad.bean.User;
import com.trad.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})  
public class TestMyBatis {

	 private static Logger logger = Logger.getLogger(TestMyBatis.class);  
	    @Resource  
	    private UserService userService = null;  
	  
	    @Test  
	    public void test1() {  
	        //User user = userService.getUserById(1);  
	         //System.out.println("查询获取到的用户名为："+user.getUserName());  
	         //logger.info("查询获取到的用户名为："+user.getUserName());  
	        }
}

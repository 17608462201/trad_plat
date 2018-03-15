package com.trad.redis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisTest {

	public static void main(String[] args) {
		 JedisPoolConfig config = new JedisPoolConfig();
         config.setMaxIdle(1000);
         JedisPool  jedisPool = new JedisPool(config, "192.168.1.101", 6379, 2000, "myRedis");
         Jedis js = jedisPool.getResource();
        System.out.println(js.ping());
	}
	
}

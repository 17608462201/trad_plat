package com.trad.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import com.trad.exception.TradBusinessException;

public class CommonUtils {
 
	Logger logger  = LoggerFactory.getLogger(CommonUtils.class);
	
	private static CommonUtils common = new CommonUtils();
	
	private CommonUtils(){}
	
	public static CommonUtils getInstance(){
		synchronized (common) {
			if(common != null){
				return common;
			}else{
				return new CommonUtils();
			}
		}
	}
	
	/**
	 * 根据传入的fieldName,targetValue设置obj值
	 * @param obj
	 * @param fieldName
	 * @param targetValue
	 * @throws TradBusinessException
	 * @throws NoSuchFieldException
	 * @throws SecurityException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public void setField(Object obj,String fieldName,String targetValue) throws TradBusinessException, NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException{
		if(obj ==null || StringUtils.isEmpty(fieldName)){
			logger.error("传入的参数出错，obj或者field Name为空！");
			throw new TradBusinessException();
		}
		Field field = obj.getClass().getDeclaredField(fieldName);
		field.setAccessible(true);
		 switch (field.getGenericType().toString()) {
		case "class java.lang.String":
			field.set(obj, targetValue);
			break;
		case "class java.lang.Integer":
			field.set(obj, Integer.parseInt(targetValue));
			break;
		case "class java.lang.Float":
			field.set(obj, Float.parseFloat(targetValue));
			break;
		case "class java.lang.Double":
			field.set(obj, Double.parseDouble(targetValue));
			break;
		case "class java.lang.Boolean":
			field.set(obj, Boolean.parseBoolean(targetValue));
			break;
		case "class java.lang.Short":
			field.set(obj, Short.parseShort(targetValue));
			break;
		case "class java.lang.Date":
			field.set(obj, new Date(targetValue));
			break;
		default:
			field.set(obj, targetValue);
			break;
		}
	}
}

package com.trad.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class IDGenerator {
	
	static Logger logger =  LoggerFactory.getLogger(IDGenerator.class);

	/**
	 * 根据oldID生成新ID
	 * @param oldID
	 * @return
	 */
	public static synchronized String getPrivateId(String oldID){
		if(StringUtils.isEmpty(oldID)){
			logger.error("传入的oldID 为空，请检查参数配置，oldID={}",oldID);
			return "";
		}
		String returnStr = null;
		String prefix = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		String oldPrefix = oldID.substring(0,8);
		if(StringUtils.isEmpty(oldPrefix)){
			logger.error("传入的oldID规则不符合定义，请检查参数配置，oldID={}",oldID);
			return "";
		}
		//如果当天的序号已存在则+1，不存在则生成新的
		if(oldPrefix.equals(prefix)){
			String suffix = oldID.substring(8);
			int suffixInt = Integer.parseInt(suffix);
			returnStr = prefix+getStringSuffix(suffixInt);
		}else{
			returnStr = prefix+"0001";
		}
		return returnStr;
	}
	
	private static String getStringSuffix(int suffixInt){
	    int increInt = suffixInt +1;
	    String increStr = String.valueOf(increInt);
	    for(int i=0;i<=4-increStr.length();i++){
	    	increStr = "0"+increStr;
	    }
		return increStr;
	}
	
	public static void main(String[] args) {
		for(int i=1;i<100;i++){
			System.out.println(IDGenerator.getPrivateId("2018041900"+i));
		}
	}
}

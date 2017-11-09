package com.trad.util;

import com.trad.security.ThreeDes;

public final class SercurityUtils {

	public static final String CRYPT_KEY = "trad_plat_desKey_@#$*_123456";
	/**
	 * 传入已加密的byte[]
	 * 
	 * @param cryptSrc
	 * @return 解密后的byte[]
	 */
	public static byte[] decryptDES(final byte[] cryptSrc){
		return ThreeDes.decryptMode(ThreeDes.hex(CRYPT_KEY), cryptSrc);
	}
	
	/**
	 * 传入需要加密的byte[]
	 * 
	 * @param src
	 * @return 加密后的byte[]
	 */
	public static byte[] encryptDES(final byte[] src){
		return ThreeDes.encryptMode(ThreeDes.hex(CRYPT_KEY), src);
	}
}

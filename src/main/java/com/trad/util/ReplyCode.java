package com.trad.util;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 类名称:返回码常量类
 * </p>
 * <p>
 * 类描述: 返回码常量类
 * </p>
 * <p>
 * 创建时间 13-1-8 下午6:52
 * </p>
 * 
 * @version 1.0
 */
public final class ReplyCode {

    /** 车机和SI通用 **/

    /**
     * <p>
     * 属性描述:处理成功，返回应答。
     * </p>
     */
    public static final String SUCCESS = "200";

    /**
     * <p>
     * 属性描述:处理无结果，此应答码针对查询处理类的请求，根据请求参数查无记录导致无法处理业务则返回此码。
     * </p>
     */
    public static final String NORESULT = "204";

    /**
     * <p>
     * 属性描述:处理失败，请求协议体不符合协议规范-协议体长度不符合规范或是协议中必添项未填写。
     * </p>
     */
    public static final String FORMEERROR = "400";

    /**
     * <p>
     * 属性描述:处理失败，请求协议体不符合协议规范-请求参数值的格式错误(例如：协议要求为数值，但实际传输为汉字，则返回此码)。
     * </p>
     */
    public static final String PARAERROR = "400";

    /**
     * <p>
     * 属性描述:处理失败，用户身份验证错误
     * </p>
     */
    public static final String IDENTITYERROR = "401";

    /**
     * <p>
     * 属性描述:处理失败，用户服务已停用，无法使用服务
     * </p>
     */
    public static final String BEYONDFEE = "401";
    /**
     * <p>
     * 属性描述:用户未购买服务套餐，无法使用服务
     * </p>
     */
    public static final String NOPAY = "401";

    /**
     * 无法获得路由信息
     */
    public static final String NOROUTINFO = "401";

    /**
     * <p>
     * 属性描述:车机鉴权失败
     * </p>
     */
    public static final String AUTHORIZATIONFAIL = "403";

    /**
     * <p>
     * 属性描述:处理失败，服务器处理能力达到极限，无法处理请求。
     * </p>
     */
    public static final String BEYONGDMAX = "429";

    /**
     * <p>
     * 属性描述: 请求超时 
     * </p>
     */
    public static final String REQUESTTIMEOUT = "504";

    /**
     * <p>
     * 属性描述: 该服务不可用 
     * </p>
     */
    public static final String SERVICEUNAVAILABLE = "503";

    /**
     * <p>
     * 属性描述: 处理失败，服务器内部错误 说明：以下情况均表示为0500 服务器链接数据库失败； 服务器链接缓存失败； 解码请求失败； 编码失败； 日志记录失败.
     * </p>
     */
    public static final String INSIDEERROR = "500";

    /** 对应SI返回码 **/

    /**
     * <p>
     * 属性描述:数据下发失败，车机状态异常
     * </p>
     */
    public static final String SMSDOWNDATAERROR = "601";

    /**
     * <p>
     * 属性描述:数据下发未全部成功
     * </p>
     */
    public static final String SISENDREQUESTNOTALLSUCCESS = "602";

    /**
     * <p>
     * 属性描述:上行消息重复
     * </p>
     */
    public static final String MESSAGEDUPLICATED = "603";

    /**
     * <p>
     * 属性描述:返回码MAP
     * </p>
     */
    public static final Map<String, String> REPLAY_MAP = new HashMap<String, String>() {
        private static final long serialVersionUID = 1L;
        {
            put(SUCCESS, "服务器处理成功，返回应答。");
            put(NORESULT, "服务器处理失败，此应答码针对查询处理类的请求，根据请求参数查无记录导致无法处理业务则返回此码。");
            put(BEYONGDMAX, "服务器处理失败，服务器处理能力达到极限，无法处理请求。");
            put(FORMEERROR, "服务器处理失败，请求协议体不符合协议规范-请求参数值的格式错误。");
            put(PARAERROR, "服务器处理失败，请求协议体不符合协议规范-请求参数值的格式错误。");
            put(IDENTITYERROR, "服务器处理失败，用户身份验证错误。");
            put(BEYONDFEE, "服务器处理失败，用户身份验证错误。");
            put(NOPAY, "服务器处理失败，用户身份验证错误。");
            put(SMSDOWNDATAERROR, "服务器处理失败，数据发送到车机失败。");
            put(SISENDREQUESTNOTALLSUCCESS, "服务器处理失败，批量数据下发未完全下发成功。");
            put(REQUESTTIMEOUT, "请求超时。");
            put(INSIDEERROR, "服务器处理失败，服务器内部错误。");
            put(SERVICEUNAVAILABLE, "服务繁忙！");
        }
    };

}

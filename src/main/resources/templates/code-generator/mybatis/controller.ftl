package ${packageName}.web;

import com.alibaba.fastjson.JSONObject;
import ${packageName}.entity.*;
import ${packageName}.ApiResult;
import ${packageName}.PageList;
import ${packageName}.ResultCode;
import ${packageName}.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 控制层
 * ${classInfo.classComment}Controller
 * @author ${authorName}
 * @date ${.now?string('yyyy/MM/dd')}
 */
@Controller
@RequestMapping(value = "/${classInfo.modelName}")
public class ${classInfo.className}Controller {

    @Resource
    ${classInfo.className}Service service;

    /**
     * 具体字段请根据实际情况处理
     * 参数请求报文:
     *
     * {
     *   "eid": 9999,
     *   "projectid": 999,
     *   "parentDirId": 999
     * }
     */
    @RequestMapping(value = "/insert")
    @ResponseBody
    public ApiResult insert (@RequestBody ${classInfo.className} ${classInfo.modelName}, HttpServletRequest request) {
        int affectRows = service.insert(${classInfo.modelName});
        return new ApiResult<>(ResultCode.success.getCode(), affectRows, ResultCode.success.getDescr(), request.getRequestURI());
    }

    /**
     * 参数请求报文:
     *
     * [
     *     {
     *         "eid": 9999,
     *         "projectid": 999,
     *         "parentDirId": 999,
     *         "scriptDirName": "sdasd"
     *     },
     *     {
     *         "eid": 9999,
     *         "projectid": 999,
     *         "parentDirId": 999,
     *         "scriptDirName": "sdasd"
     *     }
     * ]
     */
    @RequestMapping(value = "/batchInsert")
    @ResponseBody
    public ApiResult batchInsert (@RequestBody List<${classInfo.className}> list, HttpServletRequest request) {
        int affectRows = service.batchInsert(list);
        return new ApiResult<>(ResultCode.success.getCode(), affectRows, ResultCode.success.getDescr(), request.getRequestURI());
    }

    /**
     * 参数请求报文:
     *
     * {
     *   "eid": 9999,
     *   "projectid": 999,
     *   "parentDirId": 999
     * }
     */
    @RequestMapping(value = "/update")
    @ResponseBody
    public ApiResult update (@RequestBody ${classInfo.className} ${classInfo.modelName}, HttpServletRequest request) {
        int affectRows = service.update(${classInfo.modelName});
        return new ApiResult<>(ResultCode.success.getCode(), affectRows, ResultCode.success.getDescr(), request.getRequestURI());
    }

    /**
     * 参数请求报文:
     *
     * {
     *   "key":1
     * }
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public ApiResult delete (@RequestBody Object key, HttpServletRequest request) {
        int affectRows = service.delete(key);
        return new ApiResult<>(ResultCode.success.getCode(), affectRows, ResultCode.success.getDescr(), request.getRequestURI());
    }

    /**
     * 参数请求报文:
     *
     * [
     *     9,
     *     11
     * ]
     */
    @RequestMapping(value = "/batchDelete")
    @ResponseBody
    public ApiResult batchDelete (@RequestBody List<Object> keys, HttpServletRequest request) {
        int affectRows = service.batchDelete(keys);
        return new ApiResult<>(ResultCode.success.getCode(), affectRows, ResultCode.success.getDescr(), request.getRequestURI());
    }

    /**
     * 参数请求报文:
     *
     * {
     *   "key":1
     * }
     */
    @RequestMapping(value = "/selectByKey")
    @ResponseBody
    public ApiResult selectByKey (@RequestBody Object key, HttpServletRequest request) {
        ${classInfo.className} ${classInfo.modelName} = service.selectByKey(key);
        return new ApiResult<>(ResultCode.success.getCode(), ${classInfo.modelName}, ResultCode.success.getDescr(), request.getRequestURI());
    }

    /***
    * 参数请求报文:
    *
    * {
    *   "eid": 9999,
    *   "projectid": 999,
    *   "parentDirId": 999
    * }
    */
    @RequestMapping(value = "/selectList")
    @ResponseBody
    public ApiResult selectList (@RequestBody ${classInfo.className} ${classInfo.modelName}, HttpServletRequest request) {
        List<${classInfo.className}> result = service.selectList(${classInfo.modelName});
        return new ApiResult<>(ResultCode.success.getCode(), result, ResultCode.success.getDescr(), request.getRequestURI());
    }

    /***
     * 参数请求报文:
     *
     * {
     *     "eid": 1,
     *     "page": 1,
     *     "pageSize": 15
     * }
     */
    @RequestMapping(value = "/selectPage")
    @ResponseBody
    public ApiResult selectPage (@RequestBody JSONObject object, HttpServletRequest request) {
        Integer page     = (Integer) object.getOrDefault("page"    , 1);
        Integer pageSize = (Integer) object.getOrDefault("pageSize", 15);

        // 剔除page, pageSize参数
        object.remove("page");
        object.remove("pageSize");

        ${classInfo.className} ${classInfo.modelName} = object.toJavaObject(${classInfo.className}.class);
        PageList<${classInfo.className}> pageList = service.selectPage(${classInfo.modelName}, page, pageSize);
        return new ApiResult<>(ResultCode.success.getCode(), pageList, ResultCode.success.getDescr(), request.getRequestURI());
    }
}

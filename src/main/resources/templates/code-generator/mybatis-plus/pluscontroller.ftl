package ${packageName}.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import ${packageName}.common.${genConfig.resultName};
import ${packageName}.entity.${classInfo.className};
import ${packageName}.service.${classInfo.className}Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * ${classInfo.classComment}
 * @author ${authorName}
 * @data ${.now?string('yyyy-MM-dd hh:mm:ss')}
 */
@Controller
@RequestMapping("/${classInfo.className?uncap_first}")
public class ${classInfo.className}Controller {
    private final static Logger logger = LoggerFactory.getLogger(${classInfo.className}Controller.class);
    @Autowired
    private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;

    /**
     * 新增
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public ${genConfig.resultName} add(${classInfo.className} ${classInfo.className?uncap_first}) {
        try {
            ${classInfo.className?uncap_first}Service.insert(${classInfo.className?uncap_first});
            return ${genConfig.resultName}.success(${classInfo.className?uncap_first});
        } catch (Exception e) {
            logger.error("save error:", e);
            return ${genConfig.resultName}.fail(e.getMessage());
        }
    }

    /**
     * 编辑
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public ${genConfig.resultName} update(${classInfo.className} ${classInfo.className?uncap_first}) {
        try {
            if (${classInfo.className?uncap_first}.getId() == null) {
                return ${genConfig.resultName}.fail("id不可为空!");
            }
            ${classInfo.className?uncap_first}Service.updateById(${classInfo.className?uncap_first});
            return ${genConfig.resultName}.success(${classInfo.className?uncap_first});
        } catch (Exception e) {
            logger.error("update error:", e);
            return ${genConfig.resultName}.fail(e.getMessage());
        }
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public ${genConfig.resultName} delete(@PathVariable("id") Long id) {
        try {
            if (id == null) {
                return ${genConfig.resultName}.fail("id不可为空!");
            }
            ${classInfo.className?uncap_first}Service.deleteById(id);
            return ${genConfig.resultName}.success();
        } catch (Exception e) {
            logger.error("delete error:", e);
            return ${genConfig.resultName}.fail(e.getMessage());
        }
    }

    /**
     * 分页查询
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public ${genConfig.resultName} list(${classInfo.className} ${classInfo.className?uncap_first},
                          @RequestParam(name = "page", required = false, defaultValue = "0") int pageNumber,
                          @RequestParam(name = "limit", required = false, defaultValue = "10") int pageSize) {
        try {
            //分页构造器
            Page<${classInfo.className}> page = new Page<>(pageNumber, pageSize);
            int i = ${classInfo.className?uncap_first}Service.selectCount(null);
            //条件构造器
            EntityWrapper<${classInfo.className}> wrapper = new EntityWrapper<>(${classInfo.className?uncap_first});
            //执行分页
            ${classInfo.className?uncap_first}Service.selectPage(page, wrapper);
            List<${classInfo.className}> records = page.getRecords();
            //返回结果
            return ${genConfig.resultName}.page(records, i);
        } catch (Exception e) {
            logger.error("list error:", e);
            return ${genConfig.resultName}.fail(e.getMessage());
        }
    }
    /**
     * 获取单条
     */
	@RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Result get(@PathVariable Long id) {
        try {
            ${classInfo.className} ${classInfo.className?uncap_first} = ${classInfo.className?uncap_first}Service.selectById(id);
            return Result.success(${classInfo.className?uncap_first});
        } catch (Exception e) {
            logger.error("get error:", e);
            return Result.fail(e.getMessage());
        }
    }

}

package ${packageName}.service;

import java.util.Map;
import java.util.List;
import ${packageName}.entity.*;
import ${packageName}.common.PageList;

/**
 * 业务层
 * ${classInfo.classComment}Service
 * @author ${authorName}
 * @date ${.now?string('yyyy/MM/dd')}
 */
public interface ${classInfo.className}Service {

    /**
     * [新增]
     **/
    int insert(${classInfo.className} ${classInfo.modelName});

    /**
     * [批量新增]
     **/
    int batchInsert(List<${classInfo.className}> list);

    /**
     * [更新]
     **/
    int update(${classInfo.className} ${classInfo.modelName});

    /**
     * [删除]
     **/
    int delete(Object key);

    /**
     * [批量删除]
     **/
    int batchDelete(List<Object> keys);

    /**
     * [主键查询]
     **/
    ${classInfo.className} selectByKey(Object key);

    /**
     * [条件查询]
     **/
    List<${classInfo.className}> selectList (${classInfo.className} ${classInfo.modelName});

    /**
     * [分页条件查询]
     **/
    PageList<${classInfo.className}> selectPage (${classInfo.className} ${classInfo.modelName}, Integer page, Integer pageSize);

    /**
     * [总量查询]
     **/
    int total(${classInfo.className} ${classInfo.modelName});
}

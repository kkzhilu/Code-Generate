package ${packageName}.dao;

import ${packageName}.entity.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * dao层接口
 * ${classInfo.classComment}Dao
 * @author ${authorName}
 * @date ${.now?string('yyyy/MM/dd')}
 */
@Mapper
public interface ${classInfo.className}Dao {

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
    int batchDelete(List<Object> list);

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
    List<${classInfo.className}> selectPage (@Param("${classInfo.modelName}") ${classInfo.className} ${classInfo.modelName}, @Param("page") Integer page, @Param("pageSize") Integer pageSize);

    /**
     * [总量查询]
     **/
    int total(${classInfo.className} ${classInfo.modelName});
}

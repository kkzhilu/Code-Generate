package ${packageName}.mapper;
import  ${packageName}.entity.${classInfo.className};
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * ${classInfo.classComment}
 * @author ${authorName}
 * @data ${.now?string('yyyy-MM-dd hh:mm:ss')}
 */
@Mapper
public interface ${classInfo.className}Mapper extends BaseMapper<${classInfo.className}> {



}

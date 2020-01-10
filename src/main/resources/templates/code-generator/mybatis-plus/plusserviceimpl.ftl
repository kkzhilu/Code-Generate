package ${packageName}.service.impl;
import ${packageName}.service.${classInfo.className}Service;
import ${packageName}.entity.${classInfo.className};
import ${packageName}.mapper.${classInfo.className}Mapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * ${classInfo.classComment}
 * @author ${authorName}
 * @data ${.now?string('yyyy-MM-dd hh:mm:ss')}
 */
@Service
public class ${classInfo.className}ServiceImpl extends ServiceImpl<${classInfo.className}Mapper, ${classInfo.className}> implements ${classInfo.className}Service {


}

package ${packageName}.entity;

import java.io.Serializable;
import lombok.Data;
import java.util.Date;
import java.util.List;
import com.baomidou.mybatisplus.annotations.KeySequence;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
*  ${classInfo.classComment}
* @author ${authorName} ${.now?string('yyyy-MM-dd')}
*/
@SuppressWarnings("ALL")
@TableName("${classInfo.tableName?upper_case}")
@KeySequence(value = "S_${classInfo.tableName?upper_case}", clazz = Integer.class)
@Data
public class ${classInfo.className} extends BaseModel {

<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
<#list classInfo.fieldList as fieldItem >
    /**
    * ${fieldItem.fieldComment}
    */
    private ${fieldItem.fieldClass} ${fieldItem.fieldName};
</#list>
</#if>
}
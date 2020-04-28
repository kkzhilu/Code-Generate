# 基础介绍

| 说明     | 内容 |
| :------- | ---- |
| 项目名   | ${config.projectName} |
| 作者     | ${config.authorName} |
| 数据库IP | ${config.ip} |
| 数据库名 | ${config.dataBase} |

<#if classInfos?exists && classInfos?size gt 0>
<#list classInfos as classInfo >
## ${classInfo.tableName}表结构说明
| 代码字段名 | 字段名 | 数据类型（代码） | 数据类型 | 长度 | NullAble | 注释 |
| :--------- | ------ | ---------------- | -------- | ---- | -------------- | ---- |
<#list classInfo.fieldList as fieldItem >
| ${fieldItem.fieldName} | ${fieldItem.columnName} | ${fieldItem.fieldClass} | ${fieldItem.dataType} | ${fieldItem.maxLength} | ${fieldItem.nullAble} | ${fieldItem.fieldComment} |
</#list>

</#list>
</#if>








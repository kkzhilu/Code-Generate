<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.dao.${classInfo.className}Dao">

    <resultMap id="BaseResultMap" type="${packageName}.entity.${classInfo.className}" >
    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <result column="${fieldItem.columnName}" property="${fieldItem.fieldName}" />
    </#list>
    </#if>
    </resultMap>

    <sql id="Base_Column_List">
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
        <#list classInfo.fieldList as fieldItem >
        `${fieldItem.columnName}`<#if fieldItem_has_next>,</#if>
        </#list>
        </#if>
    </sql>

    <!-- 插入数据 -->
    <insert id="insert" parameterType="${packageName}.entity.${classInfo.className}">
        INSERT INTO ${classInfo.tableName}
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <#list classInfo.fieldList as fieldItem >
            <#if fieldItem.columnName != "id_" >
            ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}
                `${fieldItem.columnName}`<#if fieldItem_has_next>,</#if>
            ${r"</if>"}
            </#if>
            </#list>
            </#if>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <#list classInfo.fieldList as fieldItem >
            ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}
                ${r"#{"}${fieldItem.fieldName}${r"}"}<#if fieldItem_has_next>,</#if>
            ${r"</if>"}
            </#list>
            </#if>
        </trim>
    </insert>

    <!-- 批量插入数据 -->
    <insert id="batchInsert" parameterType="java.util.List">
        INSERT INTO ${classInfo.tableName} ( <include refid="Base_Column_List" /> ) VALUES
        <foreach collection="list" item="curr" index="index" separator=",">
            (
            <#list classInfo.fieldList as fieldItem >
                ${r"#{"}curr.${fieldItem.fieldName}${r"}"}<#if fieldItem_has_next>,</#if>
            </#list>
            )
        </foreach>
    </insert>

    <!-- 更新 -->
    <update id="update" parameterType="${packageName}.entity.${classInfo.className}">
        UPDATE ${classInfo.tableName}
        <set>
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
        <#list classInfo.fieldList as fieldItem >
        <#if fieldItem.fieldName != classInfo.key.fieldName>
            ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}`${fieldItem.columnName}` = ${r"#{"}${fieldItem.fieldName}${r"}"}<#if fieldItem_has_next>,</#if>${r"</if>"}
        </#if>
        </#list>
        </#if>
        </set>
        WHERE `${classInfo.key.columnName}` = ${r"#{"}${classInfo.key.fieldName}${r"}"}
    </update>

    <!-- 删除 -->
    <delete id="delete">
        DELETE FROM ${classInfo.tableName}
        WHERE `${classInfo.key.columnName}` = ${r"#{"}key${r"}"}
    </delete>

    <!-- 批量删除 -->
    <delete id="batchDelete" parameterType = "java.util.List">
        DELETE FROM ${classInfo.tableName} WHERE ${classInfo.key.columnName} IN
        <foreach collection="list"  item="item" open="(" separator="," close=")"  >
            ${r"#{"}item${r"}"}
        </foreach>
    </delete>

    <!-- 主键查询 -->
    <select id="selectByKey" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${classInfo.tableName}
        WHERE `${classInfo.key.columnName}` = ${r"#{"}key${r"}"}
    </select>

    <!-- 条件查询 -->
    <select id="selectList" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${classInfo.tableName}
        <where>
            <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <#list classInfo.fieldList as fieldItem >
            ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}
                and `${fieldItem.columnName}` = ${r"#{"}${fieldItem.fieldName}${r"}"}
            ${r"</if>"}
            </#list>
            </#if>
        </where>
    </select>

    <!-- 分页条件查询 -->
    <select id="selectPage" resultMap="BaseResultMap">
        SELECT <include refid="Base_Column_List" />
        FROM ${classInfo.tableName}
        <where>
            <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
            <#list classInfo.fieldList as fieldItem>
            ${r"<if test ='null != "}${classInfo.modelName}.${fieldItem.fieldName}${r"'>"}
                and `${fieldItem.columnName}` = ${r"#{"}${classInfo.modelName}.${fieldItem.fieldName}${r"}"}
            ${r"</if>"}
            </#list>
            </#if>
        </where>
        limit ${r"#{"}page,jdbcType=INTEGER${r"}"}, ${r"#{"}pageSize,jdbcType=INTEGER${r"}"}
    </select>

    <!-- 总量查询 -->
    <select id="total" resultType="java.lang.Integer">
        SELECT count(*) FROM ${classInfo.tableName}
        <where>
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
        <#list classInfo.fieldList as fieldItem>
            ${r"<if test ='null != "}${fieldItem.fieldName}${r"'>"}
                and `${fieldItem.columnName}` = ${r"#{"}${fieldItem.fieldName}${r"}"}
            ${r"</if>"}
        </#list>
        </#if>
        </where>
    </select>
</mapper>
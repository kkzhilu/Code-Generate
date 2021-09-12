package com.mysql.intercept;

import com.mysql.bean.ClassInfo;
import com.mysql.bean.ConfigurationInfo;
import com.mysql.engine.AbstractEngine;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.List;
import java.util.Map;

/**
 * ******************************
 * author：      Kerwin
 * createTime:   2020/1/17 9:00
 * description:  自定义拦截接口
 * version:      V1.0
 * ******************************
 */
public interface CustomEngine {

    /***
     * @apiNote
     * 自定义Handle 接口 -> 程序将会自动拦截实现了CustomHandle接口的类, 统一调用 handle方法
     * CustomEngine.execute 方法直接使用
     * @param config        项目核心配置
     * @param classInfos    所有表集合
     */
    void handle(ConfigurationInfo config, List<ClassInfo> classInfos);

    /***
     * @apiNote
     * 基于模板和参数 转化成指定目录的文件
     * @param params              参数     --> Map<String,Object> 结构
     * @param templateName        模板名称 --> eg: "code-generator/mybatis/mapper_xml.ftl"
     * @param filePath            文件路径
     * @throws IOException        IO异常
     * @throws TemplateException  模板异常
     */
    default void execute(Map<String, Object> params, String templateName, String filePath) throws IOException, TemplateException {
        // 获取模板构造器
        Configuration configuration = AbstractEngine.getConfiguration();

        // 构建文件路径
        File file = new File(filePath);
        file.getParentFile().mkdirs();

        // 基于模板, 写入至文件之中
        Writer writer = new FileWriter(new File(filePath));
        Template template = configuration.getTemplate(templateName);
        template.process(params, writer);
        writer.flush();
        writer.close();
    }
}

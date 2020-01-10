package com.mysql.engine.impl;

import com.mysql.bean.ClassInfo;
import com.mysql.bean.ConfigurationInfo;
import com.mysql.bean.GlobleConfig;
import com.mysql.engine.AbstractEngine;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/10 9:24
 * description:  默认实现类
 * version:      V1.0
 * ******************************
 */
public final class DefaultEngine extends AbstractEngine {

    private static final String SPACER = File.separator;

    private ConfigurationInfo config;

    private Configuration configuration;

    public DefaultEngine () {
        config = GlobleConfig.getGlobleConfig();

        configuration = AbstractEngine.getConfiguration();
    }

    /***
     * 生成Class文件
     * @param classInfo      ClassInfo
     * @param templateName   模板地址
     * @param classSuffix    文件后缀
     */
    private void genClass(ClassInfo classInfo, String templateName,  String parentPackage, String classSuffix) {
        // 构建文件地址
        String path     = config.getPackageName().replace(".", SPACER);
        String rootPath = config.getRootPath() + File.separator + config.getProjectName();
        String filePath = rootPath + "/src/main/java/" + path + SPACER
                + parentPackage.replace(".", SPACER) + classInfo.getClassName() + classSuffix;
        logger.info("文件地址:{}", filePath);

        process(classInfo, templateName, filePath);
    }

    private void process(ClassInfo classInfo, String templateName, String filePath) {
        try {
            File file = new File(filePath);
            file.getParentFile().mkdirs();

            Writer writer = new FileWriter(new File(filePath));

            Template template = configuration.getTemplate(templateName);

            Map<String, Object> params = new HashMap<>(16);
            params.put("classInfo"  , classInfo);
            params.put("authorName" , config.getAuthorName());
            params.put("packageName", config.getPackageName());
            params.put("projectName", config.getProjectName());
            params.put("genConfig"  , config);
            template.process(params, writer);
            writer.flush();
            writer.close();
        } catch (IOException | TemplateException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void genFix() {

    }

    @Override
    public void genController(ClassInfo classInfo) {
        genClass(classInfo, "code-generator/mybatis-plus/pluscontroller.ftl", "controller", "Controller.java");
    }

    @Override
    public void genService(ClassInfo classInfo) {

    }

    @Override
    public void genRepositoryClass(ClassInfo classInfo) {

    }

    @Override
    public void genRepositoryXml(ClassInfo classInfo) {

    }

    @Override
    public void genEntity(ClassInfo classInfo) {

    }

    @Override
    public void genUi(ClassInfo classInfo) {

    }

    @Override
    public void genConfig() {

    }

    private static Logger logger = LoggerFactory.getLogger(DefaultEngine.class);
}

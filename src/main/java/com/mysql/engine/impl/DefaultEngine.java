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
 * author：      Kerwin
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

        // Example: F:\code\Demo\src\main\java\com\demo\controller\ScriptDirController.java
        String filePath = config.getProjectPath() + SRC_MAIN_JAVA + path + SPACER
                + parentPackage.replace(".", SPACER) + SPACER + classInfo.getClassName() + classSuffix;
        logger.info("文件地址:{}", filePath);

        process(classInfo, templateName, filePath);
    }

    /***
     * FreeMarker 模板固定方法
     * @param classInfo
     * @param templateName
     * @param filePath
     */
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
        // 生成固定文件 ApiResult,PageList,ResultCode
        ClassInfo apiResult = new ClassInfo();
        apiResult.setClassName("ApiResult");
        genClass(apiResult, "code-generator/common/ApiResult.ftl"  , "common", ".java");

        ClassInfo pageList = new ClassInfo();
        pageList.setClassName("PageList");
        genClass(pageList, "code-generator/common/PageList.ftl"    , "common", ".java");

        ClassInfo resultCode = new ClassInfo();
        resultCode.setClassName("ResultCode");
        genClass(resultCode, "code-generator/common/ResultCode.ftl", "common", ".java");

        // Application.class
        ClassInfo application = new ClassInfo();
        application.setClassName("Application");
        genClass(application, "code-generator/common/Application.ftl", "", ".java");
    }

    @Override
    public void genController(ClassInfo classInfo) {
        genClass(classInfo, "code-generator/mybatis/controller.ftl", "web", "Controller.java");
    }

    @Override
    public void genService(ClassInfo classInfo) {
        genClass(classInfo, "code-generator/mybatis/service.ftl", "service", "Service.java");

        genClass(classInfo, "code-generator/mybatis/service_impl.ftl", "service.impl", "ServiceImpl.java");
    }

    @Override
    public void genRepositoryClass(ClassInfo classInfo) {
        genClass(classInfo, "code-generator/mybatis/mapper.ftl", "dao", "Dao.java");
    }

    @Override
    public void genRepositoryXml(ClassInfo classInfo) {
        // 构建文件地址
        String path     = config.getPackageName().replace(".", SPACER);
        String rootPath = config.getRootPath() + File.separator + config.getProjectName();

        // Example: C:\Users\Administrator\Desktop\Codes\KerwinBoots\src\main\resources\mapper\ScriptDirMapper.xml
        String filePath = rootPath + SRC_MAIN_RESOURCE + SPACER + "mapper" + SPACER
                        + classInfo.getClassName() + "Mapper.xml";

        process(classInfo, "code-generator/mybatis/mapper_xml.ftl", filePath);
    }

    @Override
    public void genEntity(ClassInfo classInfo) {
        genClass(classInfo, "code-generator/mybatis/model.ftl", "entity", ".java");
    }

    @Override
    public void genConfig() {
        // 构建文件地址
        String path     = config.getPackageName().replace(".", SPACER);
        String rootPath = config.getRootPath() + File.separator + config.getProjectName();

        // POM依赖
        ClassInfo pom = new ClassInfo();
        pom.setClassName("pom");
        process(pom, "code-generator/common/pom.ftl", rootPath + POM + pom.getClassName() + ".xml");

        // logback日志
        ClassInfo log = new ClassInfo();
        log.setClassName("logback-spring");
        process(log, "code-generator/common/logback-spring.ftl", rootPath + SRC_MAIN_RESOURCE + log.getClassName() + ".xml");

        // 配置文件
        ClassInfo properties = new ClassInfo();
        properties.setClassName("application");
        process(properties, "code-generator/common/applicationCongih.ftl", rootPath + SRC_MAIN_RESOURCE + properties.getClassName() + ".properties");
    }

    private static final String SRC_MAIN_JAVA     = SPACER + "src" + SPACER + "main" + SPACER + "java" + SPACER;

    private static final String SRC_MAIN_RESOURCE = SPACER + "src" + SPACER + "main" + SPACER + "resources" + SPACER;

    private static final String POM               = SPACER;

    private static Logger logger = LoggerFactory.getLogger(DefaultEngine.class);
}

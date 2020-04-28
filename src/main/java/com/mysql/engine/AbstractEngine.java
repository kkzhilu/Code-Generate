package com.mysql.engine;

import com.mysql.bean.ClassInfo;
import com.mysql.bean.GlobleConfig;
import com.mysql.engine.impl.CustomEngineImpl;
import com.mysql.engine.impl.DefaultEngine;
import com.mysql.factory.ClassInfoFactory;
import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Locale;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/10 9:20
 * description:  AbstractEngine 抽象
 * version:      V1.0
 * ******************************
 */
public abstract class AbstractEngine implements GeneralEngine {

    private static Configuration configuration;

    /***
     * 获取FreeMaker创建模板
     */
    public static Configuration getConfiguration() {
        if (configuration == null) {
            configuration = new Configuration(Configuration.VERSION_2_3_23);
            try {
                configuration.setTemplateLoader(new ClassTemplateLoader(AbstractEngine.class,"/templates/"));
                configuration.setNumberFormat("#");
                configuration.setClassicCompatible(true);
                configuration.setDefaultEncoding("UTF-8");
                configuration.setLocale(Locale.CHINA);
            } catch (Exception e) {
                e.printStackTrace();
            }
            configuration.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
        }
        return configuration;
    }

    @Override
    public void execute() {
        List<ClassInfo> classInfos = ClassInfoFactory.getClassInfoList();
        for (ClassInfo classInfo : classInfos) {
            genController(classInfo);
            genEntity(classInfo);
            genRepositoryClass(classInfo);
            genService(classInfo);
            genRepositoryXml(classInfo);
            genConfig();
            genFix();
        }

        logger.info(GlobleConfig.getGlobleConfig().getProjectName() + " Build Complete.");

        // 执行自定义拦截接口 执行
        logger.info("=== Begin To Execute Custom Module... ===");
        CustomEngineImpl.handleCustom();
    }

    /***
     * 初始化工程
     * 加载配置文件, 加载数据库连接, 加载数据表字段信息, 加载FreeMaker模板
     * 获得执行器
     */
    public static AbstractEngine init() {
        return new DefaultEngine();
    }

    private static Logger logger = LoggerFactory.getLogger(AbstractEngine.class);
}

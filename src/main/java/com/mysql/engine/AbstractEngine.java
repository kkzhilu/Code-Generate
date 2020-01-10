package com.mysql.engine;

import com.mysql.bean.ClassInfo;
import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;

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
    public void execute(ClassInfo classInfo) {
        genFix();
        genController(classInfo);
        genEntity(classInfo);
        genRepositoryClass(classInfo);
        genService(classInfo);
        genRepositoryXml(classInfo);
        genUi(classInfo);
        genConfig();
    }
}

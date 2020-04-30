package com.mysql.intercept.impl;

import com.mysql.bean.ClassInfo;
import com.mysql.bean.ConfigurationInfo;
import com.mysql.intercept.CustomEngine;
import com.mysql.util.IOTools;
import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/3/21 17:19
 * description:  基于LayUi的增删改查模板
 * version:      V1.0
 * ******************************
 */
public class LayUiHtmlImpl implements CustomEngine {
    @Override
    public void handle(ConfigurationInfo config, List<ClassInfo> classInfos) {
        // 复制公有文件
        copyCommonFiles(config);

        // 参数
        Map<String, Object> params = new HashMap<>();
        params.put("config"    , config);
        params.put("classInfos", classInfos);

        // 处理需要复制的config.js init.json
        String configJs    = config.getProjectPath() + STATIC + SPACER + "api"  + SPACER + "config.js";
        String initJson    = config.getProjectPath() + STATIC + SPACER + "api"  + SPACER + "init.json";
        String welcomeHtml = config.getProjectPath() + STATIC + SPACER + "page" + SPACER + "welcome.html";
        String indexHtml   = config.getProjectPath() + STATIC + SPACER + "index.html";

        try {
            this.execute(params, "code-generator/layui-html/api/config.ftl"       , configJs);
            this.execute(params, "code-generator/layui-html/api/init.ftl"         , initJson);
            this.execute(params, "code-generator/layui-html/page-file/welcome.ftl", welcomeHtml);
            this.execute(params, "code-generator/layui-html/index.ftl"            , indexHtml);
        } catch (IOException | TemplateException e) {
            e.printStackTrace();
        }

        // 针对所有数据表处理 table, add, edit 界面
        for (ClassInfo info : classInfos) {

            // 类参数
            params.put("classInfo", info);

            String table = config.getProjectPath() + STATIC + SPACER + "page" + SPACER + info.getClassName() + "-table.html";
            String add   = config.getProjectPath() + STATIC + SPACER + "page" + SPACER + info.getClassName() + "-add.html";
            String edit  = config.getProjectPath() + STATIC + SPACER + "page" + SPACER + info.getClassName() + "-edit.html";
            String see   = config.getProjectPath() + STATIC + SPACER + "page" + SPACER + info.getClassName() + "-see.html";
            try {
                this.execute(params, "code-generator/layui-html/page-file/table.ftl" , table);
                this.execute(params, "code-generator/layui-html/page-file/add.ftl"   , add);
                this.execute(params, "code-generator/layui-html/page-file/edit.ftl"  , edit);
                this.execute(params, "code-generator/layui-html/page-file/see.ftl"   , see);
            } catch (IOException | TemplateException e) {
                e.printStackTrace();
            }
        }

        logger.info("=== LayUi Html Part Build Complete. ===");
    }

    private void copyCommonFiles (ConfigurationInfo config) {
        try {
            // 复制 css, images, js, lib
            IOTools.loadRecourseFromJarByFolder("/templates/code-generator/layui-html/css",
                    config.getProjectPath() + STATIC, this.getClass(),
                    "/templates/code-generator/layui-html/css");

            IOTools.loadRecourseFromJarByFolder("/templates/code-generator/layui-html/images",
                    config.getProjectPath() + STATIC, this.getClass(),
                    "/templates/code-generator/layui-html/images");

            IOTools.loadRecourseFromJarByFolder("/templates/code-generator/layui-html/js",
                    config.getProjectPath() + STATIC, this.getClass(),
                    "/templates/code-generator/layui-html/js");

            IOTools.loadRecourseFromJarByFolder("/templates/code-generator/layui-html/lib",
                    config.getProjectPath() + STATIC, this.getClass(),
                    "/templates/code-generator/layui-html/lib");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static final String SPACER = File.separator;

    private static final String SRC_MAIN_RESOURCE = SPACER + "src" + SPACER + "main" + SPACER + "resources" + SPACER;

    private static final String STATIC = SRC_MAIN_RESOURCE + SPACER + "static" + SPACER;

    private static Logger logger = LoggerFactory.getLogger(LayUiHtmlImpl.class);
}

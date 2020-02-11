package com.mysql.intercept.impl;

import com.mysql.bean.ClassInfo;
import com.mysql.bean.ConfigurationInfo;
import com.mysql.intercept.CustomEngine;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/2/11 15:21
 * description:  表结构Impl
 * version:      V1.0
 * ******************************
 */
public class DataMdImpl implements CustomEngine {

    @Override
    public void handle(ConfigurationInfo config, List<ClassInfo> classInfos) {
        Map<String, Object> params = new HashMap<>();
        params.put("config"    , config);
        params.put("classInfos", classInfos);

        // 构建文件地址
        String filePath = config.getProjectPath() + SRC_MAIN_RESOURCE + SPACER + "DataSource.md";

        try {
            this.execute(params, "code-generator/common/DataMd.ftl", filePath);
        } catch (IOException | TemplateException e) {
            e.printStackTrace();
        }
    }

    private static final String SPACER = File.separator;

    private static final String SRC_MAIN_RESOURCE = SPACER + "src" + SPACER + "main" + SPACER + "resources" + SPACER;
}

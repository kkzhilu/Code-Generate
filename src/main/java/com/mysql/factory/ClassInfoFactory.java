package com.mysql.factory;

import cn.hutool.core.collection.CollectionUtil;
import com.mysql.bean.ClassInfo;
import com.mysql.bean.ConfigurationInfo;
import com.mysql.bean.GlobleConfig;
import com.mysql.util.DataBaseUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * ******************************
 * author：      Kerwin
 * createTime:   2020/1/9 18:24
 * description:  ClassInfoFactory
 * version:      V1.0
 * ******************************
 */
public class ClassInfoFactory {

    private volatile static List<ClassInfo> CLASS_INFO_LIST = new ArrayList<>();

    public static List<ClassInfo> getClassInfoList() {
        if (CollectionUtil.isEmpty(CLASS_INFO_LIST)) {
            synchronized (ClassInfoFactory.class) {
                if (CollectionUtil.isEmpty(CLASS_INFO_LIST)) {
                    try {
                        // 获取配置项
                        ConfigurationInfo config = GlobleConfig.getGlobleConfig();

                        List<String> tableNames = DataBaseUtil.getAllTableNames();
                        for (String tableName : tableNames) {
                            // 仅加载 *; 配置项 或者 include包含项才进行处理
                            if("*;".equals(config.getInclude()) || config.getIncludeMap().containsKey(tableName)) {
                                ClassInfo classInfo = DataBaseUtil.parseClassInfo(tableName);
                                CLASS_INFO_LIST.add(classInfo);
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return CLASS_INFO_LIST;
    }
}

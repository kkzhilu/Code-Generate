package com.mysql.util;

import com.mysql.factory.ClassInfoFactory;
import com.mysql.factory.PropertiesFactory;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

/**
 * Created by Kerwin Cotter on 2020/1/9.
 *
 * StepOne: 加载配置文件
 */
public class UtilTest {

    @Before
    public void before() throws IOException {
        PropertiesFactory.loadProperties();
    }

    @Test
    public void loadProperties() throws IOException {
        PropertiesFactory.loadProperties();
    }

    @Test
    public void getConnection() {
        System.out.println(DBUtil.getConnection());
    }

    @Test
    public void getClassInfoList() {
        System.out.println(ClassInfoFactory.getClassInfoList());
    }
}
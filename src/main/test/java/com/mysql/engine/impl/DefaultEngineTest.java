package com.mysql.engine.impl;

import com.mysql.bean.ClassInfo;
import com.mysql.engine.Executor;
import com.mysql.factory.ClassInfoFactory;
import com.mysql.factory.PropertiesFactory;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.util.List;

/**
 * Created by Kerwin Cotter on 2020/1/10.
 */
public class DefaultEngineTest {

    private List<ClassInfo> classInfos = null;

    private DefaultEngine executor = null;

    @Before
    public void before() throws IOException {

        classInfos = ClassInfoFactory.getClassInfoList();

        executor = new DefaultEngine();
    }

    @Test
    public void genFix() {

    }

    @Test
    public void genController() {
        for (ClassInfo classInfo : classInfos) {
            executor.genController(classInfo);
        }
    }

    @Test
    public void genService() {
        for (ClassInfo classInfo : classInfos) {
            executor.genService(classInfo);
        }
    }

    @Test
    public void genRepositoryClass() {
    }

    @Test
    public void genRepositoryXml() {
    }

    @Test
    public void genEntity() {
        for (ClassInfo classInfo : classInfos) {
            executor.genEntity(classInfo);
        }
    }

    @Test
    public void genUi() {
    }

    @Test
    public void genConfig() {
    }
}
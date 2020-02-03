#  [Code-Generate](https://github.com/kkzhilu/Code-Generate) 代码生成器

## 简介

 🚀  一个基于原生Mysql & SpringBoot & Mybatis 的代码生成器，建表之后即可完全解放双手，适合：

- 规律性定制化开发
- 解决双手，一键完成固有代码
- 原生mybatis.xml 文件，所有细节尽在掌握
- 支持拦截接口，允许开发者继承接口实现自定义文件内容



## 使用说明

该项目为普通Java项目，使用时需要本地Java环境 + 可连接的Mysql数据库

拉取代码后，对如下内容进行配置（```resources/application.properties```）即可
![image-20200203181537363](http://ww1.sinaimg.cn/large/006j28Gply1gbjebybgz9j30jr0fl0t9.jpg)



```Main方法 @see App.java```

```java
public class App {
    /***
     * 执行 - 构建项目
     */
    public static void main(String[] args){
        AbstractEngine engine = AbstractEngine.init();
        engine.execute();
    }
}
```

> 生成的结果是一个Maven项目，直接用IDE打开即可



## 效果演示

数据库如下图所示：

![image-20200203182200943](http://ww1.sinaimg.cn/large/006j28Gply1gbjecuobvrj306j053a9w.jpg)



代码生成编译运行图：

![image-20200203182231778](http://ww1.sinaimg.cn/large/006j28Gply1gbjed1xgpvj311y0kjtcl.jpg)



## 技术细节

```本项目主要的核心即两个通过mysql内置的表字段查询配合FreeMaker模板，构建具有一定规律性，通用的代码内容```

- FreeMaker  DefaultEngine.java process方法
- mybatis 原生XML，包含增，批量增，删，批量删，多条件分页查询，列表查询，单一查询，单一数据修改等
- logback日志
- SpringBoot
- 拔插式拦截器（基于org.reflections实现）- 支持继承指定接口，不改变其他代码情况下实现想要的功能



## 协议

### GNU General Public License v3.0



## 最后

该项目是从无到有一点点构建出来的，适合初学者和刚入门的人进行学习，更加适合大佬们直接快速构建简单Demo，把时间花在更有价值的事情上，欢迎各位Star & Fork.



点我：[GitHub地址]( https://github.com/kkzhilu/Code-Generate/tree/master )


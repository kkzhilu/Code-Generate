<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>成绩分析系统</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="/lib/layui/css/layui.css" th:href="@{/lib/layui/css/layui.css}" media="all">
  <link rel="stylesheet" href="/css/admin/admin.css" th:href="@{/css/admin/admin.css}" media="all" >
  <link rel="stylesheet" href="/lib/layui/css/layer.css" th:href="@{/lib/layui/css/layer.css}" media="all">
</head>
<body class="layui-layout-body" layadmin-themealias="default">
  
  <div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
      <div class="layui-header">
        <!-- 头部区域 -->
        <ul class="layui-nav layui-layout-left">
          <li class="layui-nav-item layadmin-flexible" lay-unselect="">
            <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
              <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
            </a>
          </li>
          <li class="layui-nav-item layui-hide-xs" lay-unselect="">
            <a href="/page/loginPage" target="_blank" title="登录">
              <i class="layui-icon layui-icon-website"></i>
            </a>
          </li>
          <li class="layui-nav-item" lay-unselect="">
            <a href="javascript:;" layadmin-event="refresh" title="刷新">
              <i class="layui-icon layui-icon-refresh-3"></i>
            </a>
          </li>
          <!--<li class="layui-nav-item layui-hide-xs" lay-unselect="">
            <input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search" layadmin-event="serach" lay-action="template/search.html?keywords="> 
          </li>-->
        <span class="layui-nav-bar"></span>
        </ul>
      </div>
      
      <!-- 侧边菜单 -->
      <div class="layui-side layui-side-menu">
        <div class="layui-side-scroll">
          <div class="layui-logo" lay-href="home/console.html">
            <span>${genCofig.projectName}</span>
          </div>
          <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
            <#list genConfig.classInfoList as classItem>
              <li class="layui-nav-item">
                <a class=""><#if classItem.classComment??>${classItem.classComment}<#else>${classItem.className}</#if>管理</a>
                <dl class="layui-nav-child">
                  <dd><a lay-href="/${classItem.tableName}/add.html">添加<#if classItem.classComment??>${classItem.classComment}<#else>${classItem.className}</#if></a></dd>
                  <dd><a lay-href="/${classItem.tableName}/list.html">查询<#if classItem.classComment??>${classItem.classComment}<#else>${classItem.className}</#if></a></dd>
                </dl>
              </li>
            </#list>
          </ul>
        </div>
      </div>

      <!-- 页面标签 -->
      <div class="layadmin-pagetabs" id="LAY_app_tabs">
        <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
        <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
        <div class="layui-icon layadmin-tabs-control layui-icon-down">
          <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
            <li class="layui-nav-item" lay-unselect="">
              <a href="javascript:;"><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child layui-anim-fadein">
                <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
              </dl>
            </li>
          <span class="layui-nav-bar"></span>
          </ul>
        </div>
        <div class="layui-tab" lay-unauto="" lay-allowclose="true" lay-filter="layadmin-layout-tabs">
          <ul class="layui-tab-title" id="LAY_app_tabsheader">
            <li lay-id="home/console.html" lay-attr="home/console.html" class="layui-this"><i class="layui-icon layui-icon-home"></i><i class="layui-icon layui-unselect layui-tab-close">ဆ</i></li>
          </ul>
        </div>
      </div>
      
      
      <!-- 主体内容 -->
      <div class="layui-body" id="LAY_app_body">
        <div class="layadmin-tabsbody-item layui-show">
          <iframe src="https://www.baidu.com" frameborder="0" class="layadmin-iframe"></iframe>
        </div>
      </div>
      
      <!-- 辅助元素，一般用于移动设备下遮罩 -->
      <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
  </div>

  <script src="/lib/layui/layui.js" th:src="@{/lib/layui/layui.js}"></script>
  <script src="/lib/jquery/jquery-3.2.1.min.js" th:src="@{/lib/jquery/jquery-3.2.1.min.js}"></script>
  <script>
  layui.config({
    base: '/js/admin/' //静态资源所在路径
    // base: '../js/admin/' //静态资源所在路径
  }).extend({
    index: 'index' //主入口模块
  }).use('index');
  </script>

  <style id="LAY_layadmin_theme">.layui-side-menu, .layadmin-pagetabs .layui-tab-title li:after, .layadmin-pagetabs .layui-tab-title li.layui-this:after, .layui-layer-admin .layui-layer-title, .layadmin-side-shrink .layui-side-menu .layui-nav > .layui-nav-item > .layui-nav-child {
    background-color: #20222A !important;
  }

  .layui-nav-tree .layui-this, .layui-nav-tree .layui-this > a, .layui-nav-tree .layui-nav-child dd.layui-this, .layui-nav-tree .layui-nav-child dd.layui-this a {
    background-color: #009688 !important;
  }

  .layui-layout-admin .layui-logo {
    background-color: #20222A !important;
  }
  </style>
</body>
</html>
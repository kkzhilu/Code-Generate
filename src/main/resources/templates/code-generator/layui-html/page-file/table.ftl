<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${classInfo.className}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
    <script src="../api/config.js"></script>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">

                        <#-- 搜索 -->
                        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
                        <#list classInfo.fieldList as fieldItem >
                        <div class="layui-inline">
                            <label class="layui-form-label">${fieldItem.fieldComment}</label>
                            <div class="layui-input-inline">
                                <input type="text" name="${fieldItem.fieldName}" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        </#list>
                        </#if>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary" lay-submit  lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm data-add-btn" lay-event="add">添加信息</button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>
    </div>
</div>
<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: RequestUrl('/${classInfo.modelName}/formPage'),
            toolbar: '#toolbarDemo',
            cols: [[
                <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
                <#list classInfo.fieldList as fieldItem >
                {field: '${fieldItem.fieldName}', title: '${fieldItem.fieldComment}', sort: true},
                </#list>
                </#if>
                {title: '操作', minWidth: 50, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [10, 15, 20],
            limit: 15,
            page: true
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(removeObjectEmptyKey(data.field));
            console.log("Query:" + result);

            // 查询提示
            var msgTips = layer.msg('查询中,请稍后...', {icon:16, time:false, shade:0});

            // 执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    searchParams: result
                }
            }, 'data');

            // 关闭msg提示
            layer.close(msgTips);
            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加数据',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: RequestUrl('/page/${classInfo.className}-add.html')
                });

                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                var index = layer.open({
                    title: '编辑数据',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: RequestUrl('/page/${classInfo.className}-edit.html') + '?key=' + data.${classInfo.key.fieldName}
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.msg('是否删除所选数据?', {
                    time: 5000 ,
                    btn: ['确定', '取消'],
                    yes: function(index){
                        $.ajax({
                            url:RequestUrl('/${classInfo.modelName}/formDelete'),
                            data:{"key":data.${classInfo.key.fieldName}},
                            type:"Post",
                            dataType:"json",
                            success:function(data){
                                if (data >= 1) {
                                    layer.close(index);
                                    window.location.reload();
                                } else {
                                    layer.msg("删除失败")
                                }
                            },
                            error:function(data){
                                layer.alert("删除失败!")
                            }
                        });
                    }
                });
                return false;
            }
        });
    });
</script>
</body>
</html>
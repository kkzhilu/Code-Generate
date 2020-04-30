<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${classInfo.className}-see</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
    <script src="../api/config.js"></script>
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">

    <div class="layui-form-item">
        <label class="layui-form-label">${classInfo.key.fieldComment}</label>
        <div class="layui-input-block">
            <input type="text" name="${classInfo.key.fieldName}" class="layui-input" readonly="readonly">
        </div>
    </div>

    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
    <#if fieldItem.fieldName != classInfo.key.fieldName>
    <div class="layui-form-item">
        <label class="layui-form-label">${fieldItem.fieldComment}</label>
        <div class="layui-input-block">
            <input type="text" name="${fieldItem.fieldName}"  value="" class="layui-input" readonly="readonly">
        </div>
    </div>
    </#if>
    </#list>
    </#if>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="saveBtn">关闭</button>
        </div>
    </div>
</div>
<script src="../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        // 获取前端传递来的Key, 并渲染界面
        var key = getQueryVariable("key");
        $.ajax({
            url:RequestUrl('/${classInfo.modelName}/formSelectByKey'),
            data:{"key":key},
            type:"Post",
            dataType:"json",
            success:function(data){
                if (data) {
                    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
                    <#list classInfo.fieldList as fieldItem >
                     $("[name='${fieldItem.fieldName}']").val(data.${fieldItem.fieldName});
                    </#list>
                    </#if>
                }
            },
            error:function(data){
                console.log("Error:" + data);
            }
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            // 关闭弹出层
            var iframeIndex = parent.layer.getFrameIndex(window.name);
            parent.layer.close(iframeIndex);
            window.parent.location.reload();
            return false;
        });
    });
</script>
</body>
</html>
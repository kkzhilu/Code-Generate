<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${classInfo.className}-edit</title>
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
        <label class="layui-form-label required">${classInfo.key.fieldComment}</label>
        <div class="layui-input-block">
            <input type="text" name="${classInfo.key.fieldName}" lay-verify="required" lay-reqtext="${classInfo.key.fieldComment}不能为空" class="layui-input" readonly="readonly">
            <tip>不可修改主键信息</tip>
        </div>
    </div>

    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
    <#if fieldItem.fieldName != classInfo.key.fieldName>
    <div class="layui-form-item">
        <label class="layui-form-label required">${fieldItem.fieldComment}</label>
        <div class="layui-input-block">
            <input type="text" name="${fieldItem.fieldName}" lay-verify="required" lay-reqtext="${fieldItem.fieldComment}不能为空" placeholder="请输入${fieldItem.fieldComment}" value="" class="layui-input">
            <tip>填写${fieldItem.fieldComment}</tip>
        </div>
    </div>
    </#if>
    </#list>
    </#if>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
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
            layer.msg('是否确定提交?', {
                time: 2000 ,
                btn: ['确定', '取消'],
                yes: function(index){
                    $.ajax({
                        url:RequestUrl('/${classInfo.modelName}/formUpdate'),
                        data:{"params":JSON.stringify(removeObjectEmptyKey(data.field))},
                        type:"Post",
                        dataType:"json",
                        success:function(data){
                            if (data.code >= 1) {
                                layer.msg(data.msg);

                                // 关闭弹出层
                                var iframeIndex = parent.layer.getFrameIndex(window.name);
                                parent.layer.close(iframeIndex);
                                window.parent.location.reload();
                            } else {
                                layer.msg("编辑失败, 请检查数据");
                            }
                        },
                        error:function(data){
                            layer.alert("编辑失败!")
                        }
                    });
                    layer.close(index);
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
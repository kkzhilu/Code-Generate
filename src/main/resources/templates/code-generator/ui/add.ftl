<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
<meta charset="UTF-8">
<title>${classInfo.classComment}添加</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="/lib/layui/css/layui.css" th:href="@{/lib/layui/css/layui.css}" media="all">
<script src="/lib/layui/layui.js" th:src="@{/lib/layui/layui.js}" charset="utf-8"></script>
<script src="/lib/jquery/jquery-3.2.1.min.js" th:src="@{/lib/jquery/jquery-3.2.1.min.js}"></script>
<script src="/js/common/public.js" th:src="@{/js/common/public.js}"></script>
<style type="text/css">
    .form-padding{
        padding: 10px;
    }

    .upload-file {
        margin-left: 80px;
        width: 200px;
        height: 200px;
        text-align: center;
        display: inline-block;
        line-height: 200px;
    }
</style>
</head>
<body>
<form class="layui-form form-padding" id="add-form">
    <#list classInfo.fieldList as fieldItem >
        <div class="layui-form-item">
            <label class="layui-form-label">${fieldItem.fieldComment}</label>
            <div class="layui-input-inline">
                <input type="text" name="${fieldItem.fieldName}" required lay-verify="required" placeholder="${fieldItem.fieldName}" autocomplete="on"
                       class="layui-input" >
            </div>
        </div>
    </#list>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <div class="layui-btn"  id="submit">立即提交</div>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<#--<div class="layui-btn upload upload-file"  id="#upload">点击或拖拽至此上传</div>-->
<script type="application/javascript" th:inline="none">
    (function () {
        var layer;
        layui.use('element', function () {
            var element = layui.element;
        });
        layui.use('form', function () {
            /*var form = layui.form;
            //监听提交
            form.on('submit(formDemo)', function (data) {
                layer.msg(JSON.stringify(data.field));
                return false;
            });*/
        });
        layui.use('layer', function () {
            layer = layui.layer;
        });
        layui.use('upload', function () {
            var upload = layui.upload; //得到 upload 对象
            upload.render({
                elem: '.upload'
                ,url:'/inside/student/inside/addBatch'
                ,bindAction:'#upload'
                , done: function (res, index, upload) {
                    var item = this.item;
                    layer.msg(res.msg)
                }
                , drag: true
                ,accept: 'file'
            })
        })
        function bindAction(){
            $('#submit').click(function () {
                add(constructArgs($('#add-form')))
            })
        }
        function add(param) {
            jQuery.ajax({
                url: '/${classInfo.className?uncap_first}/add',
                type: 'post',
                data: param,
                success: function (data) {
                    layer.msg(data.msg)
                },
                error:function (e) {
                    console.log(e);
                    layer.msg('未知错误');
                }
            })
        }
        bindAction();
    })()

</script>
</body>
</html>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org" lang="en">
<head>
<meta charset="UTF-8">
<title>${classInfo.classComment}查询</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="/lib/layui/css/layui.css" th:href="@{/lib/layui/css/layui.css}" media="all">
<script src="/lib/layui/layui.js" th:src="@{/lib/layui/layui.js}" charset="utf-8"></script>
<script src="/lib/jquery/jquery-3.2.1.min.js" th:src="@{/lib/jquery/jquery-3.2.1.min.js}"></script>
<script src="/js/common/public.js" th:src="@{/js/common/public.js}"></script>
<style type="text/css">
    .form-padding {
        padding: 10px;
    }

</style>
</head>
<body>
<form class="layui-form form-padding" id="search-form">
    <div class="layui-form-item">
        <#list classInfo.fieldList as fieldItem >
            <label class="layui-form-label">${fieldItem.fieldComment}</label>
            <div class="layui-input-inline">
                <input type="text" name="${fieldItem.fieldName}" autocomplete="on" class="layui-input">
            </div>
        </#list>
        <div class="layui-input-inline">
            <div class="layui-btn" id="submit">搜索</div>
        </div>

    </div>
</form>
<table id="list" lay-filter="data-table"></table>
<script type="text/html" id="toolBar">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
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

        function bindAction() {
            $('#submit').click(function () {
                render(constructArgs($('#search-form')))
            })
        }

        function update(param) {
            jQuery.ajax({
                url: '/${classInfo.className?uncap_first}/update'
                , type: 'POST'
                , data: param
                , success: function (data) {
                    layer.msg(data.msg)
                },
                error: function (e) {
                    console.log(e);
                    layer.msg('未知错误');
                }
            })
        }

        function render(param) {
            var table = null;
            layui.use('table', function () {
                table = layui.table;
                table.render({
                    elem: '#list'
                    , autoSort: false
                    , initSort: {
                        field: 'id' //排序字段，对应 cols 设定的各字段名
                        , type: 'desc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
                    }
                    , defaultToolbar: ['filter', 'print']
                    //,width: 900
                    //,height: 274
                    , cellMinWidth: 80
                    , cols: [[
                        <#list classInfo.fieldList as fieldItem >
                        <#if fieldItem_index !=0>, </#if>{
                            field: '${fieldItem.fieldName}',
                            title: '<#if fieldItem.fieldComment??>${fieldItem.fieldName}<#else>${fieldItem.fieldComment}</#if>',
                            align: 'center',
                            edit: true,
                            sort: true
                        }
                        </#list>
                        , {fixed: 'right', title: '操作', toolbar: '#toolBar', align: 'center', width: 120}
                    ]]
                    , url: '/${classInfo.className?uncap_first}/list'
                    , response: {
                        statusName: 'code' //规定数据状态的字段名称，默认：code
                        , statusCode: 0 //规定成功的状态码，默认：0
                        , msgName: 'msg' //规定状态信息的字段名称，默认：msg
                        , countName: 'count' //规定数据总数的字段名称，默认：count
                        , dataName: 'data' //规定数据列表的字段名称，默认：data
                    }
                    , where: param
                    , skin: 'row' //表格风格
                    , even: true
                    //,size: 'lg' //尺寸

                    , page: true //是否显示分页
                    //, limits: [3, 5, 10]
                    , loading: true //请求数据时，是否显示loading
                });
                table.on('sort(data-table)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                    //尽管我们的 table 自带排序功能，但并没有请求服务端。
                    //有些时候，你可能需要根据当前排序的字段，重新向服务端发送请求，从而实现服务端排序，如：
                    table.reload('list', {
                        initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
                        , where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                            orderFiled: obj.field //排序字段
                            , orderType: obj.type //排序方式
                        }
                    });
                });
                table.on('edit(data-table)', function (obj) {
                    var value = obj.value //得到修改后的值
                        , data = obj.data //得到所在行所有键值
                        , field = obj.field; //得到字段
                    var param = {
                        id: data.id
                    };
                    param[field] = value;
                    layer.confirm('确定更改?', function () {
                        update(param);
                    })

                })
                table.on('tool(data-table)', function (obj) {
                    var data = obj.data; //获得当前行数据
                    var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                    var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
                    if (layEvent === 'del') {
                        layer.confirm('确定删除?', function () {
                            jQuery.ajax({
                                url: '/${classInfo.className?uncap_first}/delete/' + data.id,
                                type: 'DELETE',
                                success: function (data) {
                                    obj.del();
                                    layer.msg(data.msg)
                                },
                                error: function (e) {
                                    console.log(e);
                                    layer.msg('未知错误');
                                }
                            })
                        })
                    }
                })
            });
        }

        bindAction();
    })()

</script>
</body>
</html>
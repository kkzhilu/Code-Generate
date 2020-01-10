function constructArgs(target) {
    let inputs = target.find('input');
    let args = {};
    $.each(inputs, function (i, n) {
        if (n.name !== null && n.name !== '') {
            if (n.value !== null && n.value !== '') {
                args[n.name] = n.value;
            }
        }
    })
    let selects = target.find('select');
    $.each(selects, function (i, n) {
        let attr = $(n).parent().find('dd[class=layui-this]').attr('lay-value');
        if (attr !== '') {
            args[$(n).attr('name')] = attr;
        }
    })
    return args;
}
// 确定访问路径
var localPath = "http://127.0.0.1:8080";

/**
 * 请求地址
 * @return {string}
 */
function RequestUrl(path) {
    return localPath + path;
}

/***
 * 获取地址中参数值
 * @param variable
 * @returns {*}
 */
function getQueryVariable(variable){
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i = 0;i < vars.length; i++) {
        var pair = vars[i].split("=");
        if(pair[0] === variable){return pair[1];}
    }
    return(false);
}

/***
 * 移除对象空值参数
 * @param json
 * @returns {*}
 */
function removeObjectEmptyKey(json) {
    var value;
    for (var key in json) {
        if (json.hasOwnProperty(key)) {
            value = json[key];
            if (value === undefined || value === '' || value === null) {
                delete json[key]
            }
        }
    }
    return json;
}
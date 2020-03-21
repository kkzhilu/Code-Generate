{
  "homeInfo": {
    "title": "首页",
    "href": "page/welcome.html"
  },
  "logoInfo": {
    "title": "Virus",
    "image": "images/logo.png",
    "href": ""
  },
  "menuInfo": [
    {
      "title": "常规管理",
      "icon": "fa fa-address-book",
      "href": "",
      "target": "_self",
      "child": [
        <#if classInfos?exists && classInfos?size gt 0>
          <#list classInfos as classInfo >
          {
            "title": "${classInfo.classComment}",
            "href":  "page/${classInfo.className}-table.html",
            "icon": "fa fa-home",
            "target": "_self"
          } <#if classInfo_has_next>,</#if>
          </#list>
        </#if>
      ]
    }
  ]
}
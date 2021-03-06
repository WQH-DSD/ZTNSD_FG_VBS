<%--
  Created by IntelliJ IDEA.
  User: msi-
  Date: 2020/12/4
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>适配网站 - 标题脚本</title>
    <link rel="shortcut icon" href="<%=basePath%>favicon.ico">
    <link href="<%=basePath%>h+_ui/css/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="<%=basePath%>h+_ui/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">

    <!-- Morris -->
    <link href="<%=basePath%>h+_ui/css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">

    <!-- Gritter -->
    <link href="<%=basePath%>h+_ui/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

    <link href="<%=basePath%>h+_ui/css/animate.min.css" rel="stylesheet">
    <link href="<%=basePath%>h+_ui/css/style.min.css?v=4.0.0" rel="stylesheet"><base target="_blank">

    <!-- 自由添加 -->
    <link href="<%=basePath%>css/plugins/codemirror/codemirror.css" rel="stylesheet">
    <link href="<%=basePath%>css/plugins/codemirror/ambiance.css" rel="stylesheet">
    <link href="<%=basePath%>css/style.css?v=2.2.0" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="row wrapper border-bottom white-bg page-heading">

    <div class="col-lg-8">
        <h2>标题脚本</h2>
        <ol class="breadcrumb">
            <li>
                <a>网站列表</a>
            </li>
            <li>
                <a>添加脚本</a>
            </li>
            <li>
                <strong>标题脚本</strong>
            </li>
        </ol>
    </div>
    <div class="col-lg-4">
        <button type="button" class="btn btn-primary btn-sm" onclick="loadSession()">加载已收藏</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="saveToSession()">收藏到session</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="reg()">点击验证</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="nextPage(2)">下一步</button>

        <div class="btn-group">
            <button data-toggle="dropdown" class="btn btn-warning dropdown-toggle">脚本列表 <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="<%=basePath%>nextPage/1/${information.id}" target="_self">标题</a>
                </li>
                <li><a href="<%=basePath%>nextPage/2/${information.id}" target="_self">正文</a>
                </li>
                <li><a href="<%=basePath%>nextPage/3/${information.id}" target="_self">发布日期</a>
                </li>
                <li><a href="<%=basePath%>nextPage/4/${information.id}" target="_self">文号</a>
                </li>
                <li><a href="<%=basePath%>nextPage/6/${information.id}" target="_self">附件</a>
                </li>
                <li><a href="<%=basePath%>regsinglenews/${information.id}" target="_self">新闻适配结果预览</a>
                </li>
                <li><a href="<%=basePath%>regten/${information.websiteid}/${information.id}" target="_self">网站适配结果预览</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-lg-6">
            <form id="myform" action="<%=basePath%>regsinglecode" method="post">
                <input type="hidden" id="informationid" name="informationid" value="${information.id}">
                <input type="hidden" id="codetype" name="codetype" value="1">

                <div class="ibox ">
                    <div class="ibox-title">
                        <h5>脚本代码&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                        ${result}
                    </div>
                    <div class="ibox-content">
                        <div class="textarea">
                            <c:choose>
                                <c:when test="${adapter.title == null||adapter.title.equals('')}">
                                    <%--                                    <textarea id="code1" name="title" >
                                    /*
                                    v1.25 lawstar title branch  2019-10-18  by yjs
                                    */

                                    //入口函数,全部使用小写字母
                                    function entry(str) {
                                       // str = str.toLowerCase();
                                        str =getTitle_fgw(str)  //  getTitle_fgw getAppdate_sfb getreleaseDate_useAppdate wenhao getContent  getAttach
                                        // getAppdate   getTitle_fgw getreleaseDate wenhao  wenhao_special  getContent getContent_jtb  getAttach  getTitle  // getAppdate_sfb    getContent wenhao_sfb  getAttach_qd
                                        return str;
                                    }

                                    //标题,
                                    function getTitle(str) {
                                        start_token = "名称</td>";
                                        end_token = "</td>";
                                        var idx = str.indexOf(start_token);
                                        var idx_2 = str.indexOf(end_token, idx+start_token.length);
                                        var title = "";
                                        if(idx>-1 && idx_2>-1 ){
                                            title = str.substring(idx + start_token.length, idx_2);
                                            title = replaceAllHtlm(title);
                                        }

                                        return title.trim();
                                    }
                                    //标题,发改委，标题里面有文号，处理掉
                                    function getTitle_fgw(str) {
                                        start_token = "<title>";
                                        end_token = "</title>";
                                        var idx = str.indexOf(start_token);
                                        var idx_2 = str.indexOf(end_token, idx);
                                        var title = "";
                                        if(idx>-1 && idx_2>-1 ){
                                            title = str.substring(idx + start_token.length, idx_2);
                                            title = replaceAllHtlm(title);
                                            if(title.length>0){
                                                idx = title.search("- 中华人民共和国教育部");
                                                if(idx>0){
                                                    title = title.substring(0,idx);
                                                    title = title.replaceAll(br_str,"");
                                                    title = title.trim();
                                                   // idx = title.indexOf("省");
                                                    //if(idx==0){
                                                   //     title = "贵州"+title;
                                                    //}
                                                }
                                            }

                                        }

                                        return title.trim();
                                    }


                                    // 同步读取 2018-8-21
                                    /*
                                     var fs = require("fs");
                                    var data = fs.readFileSync('d:/js/input5.html');
                                    var srcStr = entry(data.toString())
                                    //getTitle  getreleaseDate_swj wenhao_swj getContent5
                                    console.log("str=" + srcStr);
                                    console.log("程序执行完毕。");
                                     */
                                            </textarea>--%>
                                    <textarea id="code1" name="title" >
                                            ${lawstar_title}
                                    </textarea>
                                </c:when>
                                <c:otherwise>

                                    <textarea id="code1" name="title" >
                                            ${adapter.title}
                                    </textarea>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="title">
            </form>
        </div>
        <div class="col-lg-6">
            <div class="ibox ">
                <div class="ibox-title">
                    <h5>网站源代码&nbsp;&nbsp;&nbsp;&nbsp;</h5>
                    <a href="${information.source}" target="_blank">${information.source}</a>
                </div>
                <div class="ibox-content">
                                <textarea id="code2" style="margin: 0px; height: 693px; width: 770px;">
                                    ${information.newscontentnotupdate}
                                </textarea>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

<!-- Mainly scripts -->
<script src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
<script src="<%=basePath%>js/bootstrap.min.js?v=3.4.0"></script>
<script src="<%=basePath%>js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="<%=basePath%>js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<script src="<%=basePath%>js/plugins/jeditable/jquery.jeditable.js"></script>

<!-- Data Tables -->
<script src="<%=basePath%>js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="<%=basePath%>js/plugins/dataTables/dataTables.bootstrap.js"></script>

<!-- Custom and plugin javascript -->
<script src="<%=basePath%>js/hplus.js?v=2.2.0"></script>
<script src="<%=basePath%>js/plugins/pace/pace.min.js"></script>


<!-- Peity -->
<script src="<%=basePath%>js/plugins/peity/jquery.peity.min.js"></script>

<!-- CodeMirror -->
<script src="<%=basePath%>js/plugins/codemirror/codemirror.js"></script>
<script src="<%=basePath%>js/plugins/codemirror/mode/javascript/javascript.js"></script>

<script type="text/javascript">


    var editor = CodeMirror.fromTextArea(document
        .getElementById("code1"), {
        lineNumbers : true,
        matchBrackets : true,
        styleActiveLine : true,
        theme: "ambiance"
    });


    var isQuery = false;//设置一个请求开关
    function reg() {


        var targetUrl = $("#myform").attr("action");

        var title = editor.getValue();
        var informationid = $("#informationid").val();
        var codetype = $("#codetype").val();
        if (!isQuery) {
            $.ajax({
                type: 'post',
                url: targetUrl,
                cache: false,
                data: {"title": title, "informationid": informationid, "codetype": codetype},
                beforeSend: function (XMLHttpRequest) {
                    isQuery = true;
                    this;//调用本次ajax请求时配置的options参数，下面每个回调方法都适应。
                },
                success: function (data) {
                    alert(data);
                    isQuery = false;//本次请求成功完成时，重置激活按钮
                },
                error: function () {
                    alert("请求失败")
                    isQuery = false;//本次请求失败时，重置激活按钮
                }
            })
        } else {
            alert("代码上传中...");
        }
    }
    function lastPage(page) {
        var informationid = $("#informationid").val();
        window.location.href = "<%=basePath%>nextPage/"+page+"/"+informationid;
    }
    function nextPage(page) {
        var informationid = $("#informationid").val();
        window.location.href = "<%=basePath%>/nextPage/"+page+"/"+informationid;
    }
    function saveToSession() {
        var title = editor.getValue();
        $.ajax({
            type:'post',
            url:"<%=basePath%>saveToSession",
            cache: false,
            data:{"title":title,"codeType":1},
            success:function(){
                alert("收藏成功");
            },
            error:function(){
                alert("请求失败")
            }
        })
    }
    function loadSession() {
        $.ajax({
            type:'post',
            url:"<%=basePath%>loadSession",
            cache: false,
            data:{"codeType":1},
            success:function(data){
                editor.setValue(data)
            },
            error:function(){
                alert("请求失败")
            }
        })
    }
</script>


</html>

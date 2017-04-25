<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta charset="utf-8">
    <title>农场登陆</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- CSS -->
    <link rel="stylesheet" href="assets/css/reset.css">
    <link rel="stylesheet" href="assets/css/supersized.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/tool/selfjs.js"></script>

<script type="text/javascript">
var ctx = '${pageContext.request.contextPath}';
function login(){
	$.post(ctx + '/login', serializeObject($('form')), function (data){
		if(data.success){
			location = ctx + '/mobile/user/getFarmDetail';
		}else{
			alert(data.message);
		}
	});
};

if('${message }' != ''){
	alert('${message }');
}

</script>
    </head>
    <body>
		<h1>${message }</h1>
        <div class="page-container">
            <h1>登录</h1>
            <form action="javascript:login();" method="post">
            	<input type="hidden" name="userRole" value="1" />
                <input type="text" name="userPhoneAndUserName" class="username" placeholder="用户名">
                <input type="password" name="passWord" class="password" placeholder="密码">
                <button type="submit">提交</button>
                <div class="error"><span>+</span></div>
            </form>
            <div class="connect">
                <p>Or connect with:</p>
                <p>
                    <a class="facebook" href=""></a>
                    <a class="twitter" href=""></a>
                </p>
            </div>
        </div>
		
        <!-- Javascript -->
        <script src="assets/js/jquery-1.8.2.min.js"></script>
        <script src="assets/js/supersized.3.2.7.min.js"></script>
        <script src="assets/js/supersized-init.js"></script>
        <script src="assets/js/scripts.js"></script>

    </body>

</html>



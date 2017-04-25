<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<title>后台管理系统</title>
<link rel="stylesheet" type="text/css"
	href="../jquery-easyui-1.4.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="../jquery-easyui-1.4.5/themes/icon.css">
<script type="text/javascript" src="../jquery-easyui-1.4.5/jquery.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="selftool/syUtils.js"></script>
<script type="text/javascript">
$(function(){
	var ctx = '${pageContext.request.contextPath}';
	/*
	if('${adminUser }' == ''){// 说明没有登陆
		// 去登陆
		location = ctx + '/index.jsp';
	}
	*/
});
$(function(){
	$('#cc').layout();
	
	/*
	$('#loginFrame').dialog({
		title:'登陆',
		width:280,
		height:180,
		closable:false,
		modal:true,
		resizable:true,
		buttons:[{
			text:'重置',
			handler:function(){
				$('#loginForm').form('reset');
			}
		},{
			text:'登陆',
			handler:function(){
				var userName = $('#userName').val();
				var passWord = $('#passWord').val();
				$.post(ctx + '/sys/user/backLogin', {'userName':userName, 'passWord':passWord}, function(data){
					if(data.success){
						$('#loginFrame').dialog('close');
						$.messager.show({
							title:'系统消息',
							msg:'登陆成功!',
							timeout:3000
						});
					}else{
						$.messager.alert('提示','您的用户名或密码不正确!', 'info');
					}
				});
			}
		}]
	});
	*/
});
</script>
<style type="text/css">
	*{
		font-size:13px;
		font-family:微软雅黑;
	}
	#nt{
		margin:18px 30px;
		float:right;
	}
	#nd{
		margin:15px 26px;
		float:left;
		font-size:28px;
	}
	#nt td{
		font-size:18px;
		
	}
</style>
</head>
<body id="cc" fit="true" oncontextmenu="return false">
	<div id="loginFrame">
		<form id="loginForm" method="post">
			<table>
	    		<tr>
	    			<td>用户名:</td><!-- value="admin" -->
	    			<td><input id="userName" class="easyui-textbox" type="text" name="name" data-options="required:true"/></td>
	    		</tr>
	    		<tr>
	    			<td>密码:</td>
	    			<td><input id="passWord" class="easyui-textbox" type="password" name="password" data-options="required:true"/></td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	<%-- 北部 --%>
    <div data-options="region:'north',collapsible:false" style="height:70px;overflow:hidden;background:#d8e5f3;" >
    	<div id="nd">欢乐农场后台管理系统</div>
    	<table id="nt">
			<tr>
				<td>欢迎您:</td>
				<td>管理员</td>
				<td>
					<a href="${pageContext.request.contextPath }/sys/user/quitLogin">
					<span style="font-size:18px;">退出</span>
					</a>
				</td>
			</tr>    	
    	</table>
    </div>
    <%-- 南部 --%>
    <%--
    <div data-options="region:'south'" style="height:40px;text-align:center;padding-top:12px;">
    	<a style="text-decoration:none;margin:0 auto;" href="http://www.hfwxkf.com/"  target="_blank">
    		安徽好牛软件&copy;版权所有
   		</a>
    </div>
     --%>
    <%--西部 split:是否可以改变大小--%>
    <div data-options="region:'west',iconCls:'icon-reload',title:'导航菜单',split:true,border:false" style="width:180px;" href="west.jsp">
    </div>
    <%-- 东部 --%>
    <!-- <div data-options="region:'east',iconCls:'icon-reload',title:'East',split:true" style="width:100px;"></div>   -->
    <%-- 中间部分 --%>
    <div data-options="region:'center',border:false" href="center.jsp" style="overflow: hidden;">
    </div>
    
</body>
</html>

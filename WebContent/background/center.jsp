<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	var centerTabs;// 中间面板
	$(function(){
		centerTabs = $('#maintabs').tabs({
			plain:true,
			border:true,
		});
	});
	
	function addTab(node){
		if(centerTabs.tabs('exists', node.text)){//如果该选项面板存在的话选中该面板
			centerTabs.tabs('select', node.text);
		}else{
			// 如果有url属性并且不为空
			if(node.attributes != undefined && node.attributes.url != undefined && node.attributes.url.length > 0){
				centerTabs.tabs('add',{
					title:node.text,
					closable:true,
					content:'<iframe src="datagrid/' + node.attributes.url + '" frameborder="0" style="border:0;width:100%;height:99%"/>',
					tools:[{
						iconCls:'icon-mini-refresh',
						handler:function(){
							refreshTab(node.text);
						}
					}]
				});
			}
		}
	}
	
	// 重新加载该页面
	function refreshTab(title){
		var tab = centerTabs.tabs('getTab', title);
		centerTabs.tabs('update',{
			tab:tab,
			options : tab.panel('options')
		});
	}
</script>
<div id="maintabs" fit="true" border="false" style="overflow:hidden;">
	<div title="欢迎页" class="easyui-layout" style="overflow: hidden;">
		<img style="width:100%;height:100%;" src="../images/bg.jpg">
	</div>
</div>



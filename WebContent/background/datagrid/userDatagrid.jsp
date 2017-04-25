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
	href="../../jquery-easyui-1.4.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="../../jquery-easyui-1.4.5/themes/icon.css">
<link rel="stylesheet" href="../selftool/self.css" type="text/css"></link>
<script type="text/javascript" src="../../jquery-easyui-1.4.5/jquery.min.js"></script>
<script type="text/javascript" src="../../jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../selftool/syUtils.js"></script>
<script type="text/javascript">
	var ctx = '${pageContext.request.contextPath}';
	var datagrid;
	var editRow = undefined; //定义全局变量：当前编辑的行
	$(function() {
		datagrid = $('#datagrid').datagrid({
			//需要把这个回调函数放在datagrid的初始化方法里
			onLoadSuccess : function(){
			  //解决一个样式bug
			  $(".borderdiv").remove();
			  var height = $(".datagrid-view2 .datagrid-body").outerHeight() - $(".datagrid-view2 .datagrid-btable").outerHeight();
			  if(height > 0){
			    $(".datagrid-view2 .datagrid-body").css("position", "relative").append("<div class='borderdiv'></div>");
			    $(".borderdiv").css({
			      height : height,
			      borderLeft : "1px solid #ccc",
			      position : "absolute",
			      right : "18px"
			    });
			  }
			},
			url : ctx + '/showDataList',
			iconCls : 'icon-save',
			pagination : true,
			pageSize : 15,
			pageList : [15, 20, 30, 40, 50],
			fit : true,
			fitColumns : true,
			idField : 'userId',// 翻页会选中其他列选中的数据 
			// 初始化
			sortName : 'addTime',
			sortOrder : 'asc',
			columns : [[
			{
				field:'userId', 
				checkbox:true
			},{// 一定要给宽
				title:'姓名', 
				field:'realName', 
				width:100,
				align:'center',
			},{
				title:'手机号码', 
				field:'userPhone', 
				width:100,
				align:'center',
			},{
				title : '密码',
				field : 'passWord',
				width : 70,
				align : 'center',
			},{
				title:'推荐人',
				field:'refereeId', 
				width:100,
				align:'center',
			},{
				title:'注册时间', 
				field:'addTime',
				width:150,
				align:'center',
			},{
				title:'用户余额', 
				field:'userMoney',
				width:150,
				align:'center',
				editor: { type: 'validatebox', options: { required: true} }
			},{
				title:'农场积分', 
				field:'farmIntegral',
				width:150,
				align:'center',
				editor: { type: 'validatebox', options: { required: true} }
			},{
				title:'所剩肥料', 
				field:'fertilizer',
				width:150,
				align:'center',
			},{
				title:'所剩的肉', 
				field:'remainMeat',
				width:150,
				align:'center',
			}]],
			toolbar:[{
				text:'余额充值',
				iconCls:'icon-add',
				handler:function(){
					add();
				}
			},'-',{
				text:'删除数据',
				iconCls:'icon-remove',
				handler:function(){
					del();
				}
			},'-',{ text: '修改数据', iconCls: 'icon-save', handler: function () {
                //保存时结束当前编辑的行，自动触发onAfterEdit事件如果要与后台交互可将数据通过Ajax提交后台
                datagrid.datagrid("endEdit", editRow);
            }
            }, '-',
            { text: '取消编辑', iconCls: 'icon-redo', handler: function () {
                //取消当前编辑行把当前编辑行罢undefined回滚改变的数据,取消选择的行
                editRow = undefined;
                datagrid.datagrid("rejectChanges");
                datagrid.datagrid("unselectAll");
            }
            }],
            onDblClickRow: function (rowIndex, rowData) {
            	//双击开启编辑行
                if (editRow != undefined) {
                	// 取消当前行的选中
                    editRow = undefined;
                    datagrid.datagrid("rejectChanges");
                    datagrid.datagrid("unselectAll");
                }
                if (editRow == undefined) {
                    datagrid.datagrid("beginEdit", rowIndex);
                    editRow = rowIndex;
                }
            },
            onAfterEdit: function (rowIndex, rowData, changes) {
                //endEdit该方法触发此事件
                console.log(rowData);
                // 修改数据库
                $.post(ctx + '/sys/user/updateUser', rowData, function(data){
					$.messager.alert('提示', data.message, 'info');
				});
                editRow = undefined;
            },
			// 数据加载之前
			onBeforeLoad:function(param){
				param['className'] = 'UserService';
				return true;
			}
		});
	});
	
	
	// 添加数据
	function add(){
		var arr = datagrid.datagrid('getSelections');
		if(arr.length == 0){
			$.messager.alert('提示', '您还没有选择数据!', 'info');
			return;
		}else if(arr.length > 1){
			$.messager.alert('提示', '请只选择一条数据!', 'info');
			return;
		}
		var obj = {};
		var userId = arr[0].userId;
		obj['userId'] = userId;
		var addDialog;
		addDialog = $('#add').dialog({
			title: '余额充值',
			width: 306,
			height: 150,
			collapsible: true,
		    resizable: true,
		    closed: false,
		    cache: false,    
		    modal: true,
		    buttons:[{
				text:'重置',
				handler:function(){
					$('#addForm').form('reset');
				}
			},{
				text:'充值',
				handler:function(){
					obj['userMoney'] = $('#userMoney').val();
					$.post(ctx + '/sys/user/addUserMoney', obj, function(data){
						if(data.success){
				    		$.messager.show({
					    		title:'系统消息',
					    		msg:data.message,
					    		timeout:2000,
					    		showType:'slide'
					    	});
				    		$('#addForm').form('reset');
				    		addDialog.dialog('close');
					    	datagrid.datagrid('load');
				    	}else{
				    		$.messager.alert('提示','添加失败!', 'info');
				    	}
					});
				}
			}]
		});
	}
	
	// 删除数据
	function del(){
		var arr = datagrid.datagrid('getSelections');
		console.log(arr);
		if(arr.length == 0){
			$.messager.alert('提示', '您还没有选择数据!', 'info');
			return;
		}
		$.messager.confirm('确认对话框', '您确认要删除吗？', function(r){
			if (r){
				$.post(ctx + '/sys/user/deleteUser', {"arr":arr}, function(data){
					console.log(data);
					$.messager.alert('提示', data.message, 'info');
					if(data.success == true){// 删除成功
						datagrid.datagrid('load', {});
						datagrid.datagrid('clearSelections');
					}
				});
			}
		});
	}
	
	// 清空搜索内容
	function clear(){
		$('#searchForm').form('clear');
		datagrid.datagrid('load', {});
	}
	
	// 搜索数据
	function search(){
		datagrid.datagrid('load', serializeObject($('#searchForm').form()));
	}
	
</script>
<style type="text/css">
	*{
		font-family:微软雅黑;
	}
</style>
</head>
<body class="easyui-layout" oncontextmenu="return false">
	<!-- 搜索部分 -->
   	<div data-options="region:'north',title:'搜索数据',split:false,border:false,collapsed:false" style="height:94px;" class="datagrid-toolbar">
		<form id="searchForm" method="post">
			<table style="margin-top:4px;">
				<tr align="right">
					<th>姓名:</th>
					<td><input type="text" class="easyui-textbox" name="realName" /></td>
					<th>手机号:</th>
					<td><input class="easyui-numberbox" type="text" name="userPhone" data-options="min:1,"/></td>
				</tr>
				<tr align="right">
					<th>注册时间:</th>
					<td><input type="text" class="easyui-datebox" editable="false" name="startTime" /></td>
					<th>到:</th>
					<td><input type="text" class="easyui-datebox" editable="false" name="endTime" /></td>
					<td><a id="btn" href="javascript:search();" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a></td>
					<td><a id="btn" href="javascript:clear();" class="easyui-linkbutton" data-options="iconCls:'icon-undo'">重置</a></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 显示数据部分 -->
 	<div data-options="region:'center',split:true,border:false">
 		<%-- datagrid表格 --%>
		<table id="datagrid"></table>
 	</div>
 	<!-- 添加数据的dialog -->
	<div id="add" style="display:none;">
		<form id="addForm" method="post" style="width:230px;margin:0 auto;">
			<table>
				<tr>
	    			<td></td>
	    			<td>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>金额:</td>
	    			<td>
	    				<input id="userMoney" class="easyui-textbox" type="text" name="name" data-options="required:false" style="width:150px;"/>
	    			</td>
	    		</tr>
	    	</table>
	    </form>
	</div>
	
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#textaa{
		border:1px solid red;
		width:100px;
		height:100px;
		font-family:微软雅黑;
	}
	#backTree{
	    -webkit-user-select:none;
	    -moz-user-select:none;
	    -ms-user-select:none;
	    user-select:none;
	}
</style>
<script type="text/javascript">
var ctx = '${pageContext.request.contextPath}';
	var treedata = 
		[
		    {
		        "text": "管理首页",
		        "children": [
		            {
		                "text": "农场管理",
		                "attributes": {
	                    	"url": "userDatagrid.jsp",
		                }
		            },
		            {
		                "text": "提现申请",
		                "attributes": {
	                    	"url": "askCashDatagrid.jsp",
		                }
		            },
		            {
		                "text": "摘取记录",
		                "attributes": {
	                    	"url": "pickDatagrid.jsp",
		                }
		            },
		            {
		                "text": "神兽收益记录",
		                "attributes": {
	                    	"url": "animalDatagrid.jsp",
		                }
		            }
		        ]
		    }
		];
	$(function(){
		$('#backTree').tree({
			data:treedata,
			lines:'true',
			onClick:function(node){
				addTab(node);
			},
			onDblClick:function(node){
				if(node.state == 'closed'){
					$(this).tree('expand', node.target);
				}else{
					$(this).tree('collapse', node.target);
				}
			}
		});
		
		// 禁用右键
		$('#backTree').tree({
			onContextMenu:function(e,node){
				e.preventDefault();
			}
		});
	});	
</script>
<ul id="backTree"></ul>




	<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>我的主页</title>
  <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/font.css" type="text/css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/app.css" type="text/css" />
  
   <!-- jQuery -->
  <script src="${pageContext.request.contextPath }/bootstrap/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath }/bootstrap/vendor/jquery/bootstrap.js"></script>
  
  <script type="text/javascript">
  	var ctx = '${pageContext.request.contextPath }';
  	
  	$(function(){
		if('${user }' == ''){// 说明没有登陆
			// 去登陆
			location = '/hn_farm/index.jsp';
		}
	});
  	
  	function buyTree(buyType){
  		// buyType:1余额购买,1积分购买
  		var obj = {};
  		obj['buyType'] = buyType;
  	
  		if($('#orange').val() != ''){
  			obj['orange'] = $('#orange').val();
  		}
  		if($('#apple').val() != ''){
  			obj['apple'] = $('#apple').val();
  		}
  		if($('#banana').val() != ''){
  			obj['banana'] = $('#banana').val();
  		}
  		if($('#feiliao').val() != ''){
  			obj['feiliao'] = $('#feiliao').val();
  		}
  		if($('#animalrent').val() != ''){
  			obj['animalrent'] = $('#animalrent').val();
  		}
  		if($('#animal').val() != ''){
  			obj['animal'] = $('#animal').val();
  		}
  		
  		console.log(obj);
  		$.post(ctx + '/mobile/user/buyTree', obj, function(data){
  			alert(data.message);
  		});
  	}
  	
	function buyFood(buyType){
		// buyType:1余额购买,1积分购买
  		var obj = {};
  		obj['buyType'] = buyType;
  		if($('#fertilizer').val() != ''){
  			obj['fertilizer'] = $('#fertilizer').val();
  		}
  		if($('#meat').val() != ''){
  			obj['meat'] = $('#meat').val();
  		}
  		console.log(obj);
  		var arr = Object.keys(obj);
  		if(arr.length == 1){
  			alert('请选择购买商品!');
  			return;
  		}
  		$.post(ctx + '/mobile/user/buyFood', obj, function(data){
  			alert(data.message);
  		});
  	}
  	
  	function buyAnimal(buyType){
  		// buyType:1余额购买,1积分购买
  		var obj = {};
  		obj['buyType'] = buyType;
  		if($('#buyAnimal').val() > 1){
  			alert('神兽只能购买一只!');
  			return;
  		}
  		if($('#buyAnimal').val() != ''){
  			obj['buyAnimal'] = $('#buyAnimal').val();
  		}
  		var arr = Object.keys(obj);
  		if(arr.length == 1){
  			alert('请选择购买商品!');
  			return;
  		}
  		$.post(ctx + '/mobile/user/buyAnimal', obj, function(data){
  			alert(data.message);
  		});
  	}
  	
</script>
<style type="text/css">
</style>
</head>
<body>
  <div class="app app-header-fixed" id="app">
	<jsp:include page="menu.jsp"></jsp:include>

    <!-- content -->
    <div class="app-content">
    <img src="/hn_farm/images/bg1.png" class="img-responsive img-thumbnail" />
    	<h1 class="text-center"><strong>商城中心</strong></h1>
    	<p class="text-center">备注:积分购买9.5折,购买的果树自动种植</p>
    	<table class="table table-bordered table-striped">
		    <tr class="text-center active">
		    	<td><strong>商品类型</strong></td>
	            <td><strong>商品价格(元)</strong></td>
	            <td><strong>果实</strong></td>
	            <td style="width:100px;"><strong>购买数量</strong></td>
    		</tr>
    		<tr class="text-center active">
    			<td><img style="width:3em;" src="/hn_farm/images/commonOrange.png" /></td>
		    	<td>100</td>
		    	<td>1.5元</td>
		    	<td><input id="orange" class="form-control"/></td>
		    	
    		</tr>
    		<tr class="text-center active">
    			<td><img style="width:3em;" src="/hn_farm/images/commonApple.png" /></td>
		    	<td>200</td>
		    	<td>3.0元</td>
		    	<td><input id="apple" class="form-control"/></td>
    		</tr>
    		<tr class="text-center active">
    			<td><img style="width:3em;" src="/hn_farm/images/commonBanana.png" /></td>
		    	<td>300</td>
		    	<td>4.5元</td>
		    	<td><input id="banana" class="form-control"/></td>
    		</tr>
	    </table>
	    <div class="text-center" style="margin:15px;">
	    	<button type="button" onclick="buyTree(1)" class="btn btn-primary">余额购买</button>
	    	&nbsp;&nbsp;
	    	<button type="button" onclick="buyTree(2)" class="btn btn-primary">积分购买</button>
	   	</div>
	   	
    	<table class="table table-bordered table-striped">
		    <tr class="text-center active">
		    	<td><strong>商品类型</strong></td>
	            <td><strong>商品价格(元)</strong></td>
	            <td style="width:100px;"><strong>购买数量</strong></td>
    		</tr>
    		<tr class="text-center active">
		    	<td><img style="width:3em;" src="/hn_farm/images/shifei.png" /></td>
		    	<td>2</td>
		    	<td><input id="fertilizer" class="form-control"/></td>
    		</tr>
    		<tr class="text-center active">
		    	<td><img style="width:3em;" src="/hn_farm/images/yesmeat.png" /></td>
		    	<td>20</td>
		    	<td><input id="meat" class="form-control"/></td>
    		</tr>
	    </table>
	    <div class="text-center" style="margin:15px;">
	    	<button type="button" onclick="buyFood(1)" class="btn btn-primary">余额购买</button>
	    	&nbsp;&nbsp;
	    	<button type="button" onclick="buyFood(2)" class="btn btn-primary">积分购买</button>
	   	</div>
	   	
    	<table class="table table-bordered table-striped">
		    <tr class="text-center active">
		    	<td><strong>商品类型</strong></td>
	            <td><strong>商品价格(元)</strong></td>
	            <td><strong>收益(元)</strong></td>
	            <td style="width:100px;"><strong>购买数量</strong></td>
    		</tr>
    		
    		<tr class="text-center active">
		    	<td><img style="width:3em;" src="/hn_farm/images/animal.png" /></td>
		    	<td>1000</td>
		    	<td>15元</td>
		    	<td><input id="buyAnimal" class="form-control"/></td>
    		</tr>
	    </table>
	    <div class="text-center" style="margin:15px;">
	    	<button type="button" onclick="buyAnimal(1)" class="btn btn-primary">余额购买</button>
	    	&nbsp;&nbsp;
	    	<button type="button" onclick="buyAnimal(2)" class="btn btn-primary">积分购买</button>
	   	</div>
	   	
	    
	   	
	   	
    </div>
    <!-- /content -->
  </div>
 
  
  <script type="text/javascript">
    +function ($) {
      $(function(){
        // class
        $(document).on('click', '[data-toggle^="class"]', function(e){
          e && e.preventDefault();
          console.log('abc');
          var $this = $(e.target), $class , $target, $tmp, $classes, $targets;
          !$this.data('toggle') && ($this = $this.closest('[data-toggle^="class"]'));
          $class = $this.data()['toggle'];
          $target = $this.data('target') || $this.attr('href');
          $class && ($tmp = $class.split(':')[1]) && ($classes = $tmp.split(','));
          $target && ($targets = $target.split(','));
          $classes && $classes.length && $.each($targets, function( index, value ) {
            if ( $classes[index].indexOf( '*' ) !== -1 ) {
              var patt = new RegExp( '\\s' + 
                  $classes[index].
                    replace( /\*/g, '[A-Za-z0-9-_]+' ).
                    split( ' ' ).
                    join( '\\s|\\s' ) + 
                  '\\s', 'g' );
              $($this).each( function ( i, it ) {
                var cn = ' ' + it.className + ' ';
                while ( patt.test( cn ) ) {
                  cn = cn.replace( patt, ' ' );
                }
                it.className = $.trim( cn );
              });
            }
            ($targets[index] !='#') && $($targets[index]).toggleClass($classes[index]) || $this.toggleClass($classes[index]);
          });
          $this.toggleClass('active');
        });

        // collapse nav
        $(document).on('click', 'nav a', function (e) {
          var $this = $(e.target), $active;
          $this.is('a') || ($this = $this.closest('a'));
          
          $active = $this.parent().siblings( ".active" );
          $active && $active.toggleClass('active').find('> ul:visible').slideUp(200);
          
          ($this.parent().hasClass('active') && $this.next().slideUp(200)) || $this.next().slideDown(200);
          $this.parent().toggleClass('active');
          
          $this.next().is('ul') && e.preventDefault();

          setTimeout(function(){ $(document).trigger('updateNav'); }, 300);      
        });
      });
    }(jQuery);
  </script>
</body>
</html>
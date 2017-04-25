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
	<style type="text/css">
		/*
		body { 
		background-image: url("/hn_farm/images/bg1.png");
		background-size: 100%;
		}
		*/
	</style>

</head>
<body>
  <div class="app app-header-fixed" id="app">
	<jsp:include page="menu.jsp"></jsp:include>

    <!-- content -->
    <div  class="app-content">
    	<!-- style="width:100%;height:40px;" -->
    	<img src="/hn_farm/images/bg1.png" class="img-responsive img-thumbnail" />
    	
   		<h1 class="page-header text-center"><strong>欢迎您:${farm.realName }</strong></h1>
    	<table class="table table-bordered table-striped">
		    <tr class="text-center active">
	            <td><strong>农场主</strong></td>
		    	<td><strong>微信号</strong></td>
	            <td><strong>农场余额</strong></td>
    		</tr>
    		<tr class="text-center">
    			<!-- 
    			<td>
    				<c:choose>
    					<c:when test="${farm.farmType == 0 }">
    						普通农场
    					</c:when>
    				</c:choose>
    			</td>
    			 -->
    			<td>${farm.realName }</td>
    			<td>${farm.weixinId }</td>
    			<td>￥${farm.userMoney }</td>
    		</tr>
	    </table>
	    <table class="table table-bordered table-striped">
		    <tr class="text-center active">
	            <td><strong>农场积分</strong></td>
	            <td><strong>剩余肥料</strong></td>
	            <td><strong>剩余肉</strong></td>
    		</tr>
    		<tr class="text-center">
    			<td>${farm.farmIntegral }</td>
    			<td>${farm.fertilizer }</td>
    			<td>${farm.remainMeat }</td>
    		</tr>
	    </table>
	    <!-- 
	    <table class="table table-bordered table-striped">
	    	<tr class="text-center active">
		    	<td><strong>是否有守护兽</strong></td>
	            <td><strong>守护兽到期时间</strong></td>
	    		<td><strong>农场余额</strong></td>
            </tr>
            <tr class="text-center">
            	<td>
					<c:choose>
    					<c:when test="${farm.farmAnimal == 0 }">
    						没有
    					</c:when>
    					<c:when test="${farm.farmAnimal == 1 }">
    						有
    					</c:when>
    				</c:choose>
				</td>
    			<td>${dueTime }</td>
    			<td>￥${farm.userMoney }</td>
            </tr>
	    </table>
	     -->
	    <div class="text-center" style="margin:15px;">
	    	<a href="/hn_farm/userpage/shopCenter.jsp"><button class="btn btn-primary">去商城</button></a>
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
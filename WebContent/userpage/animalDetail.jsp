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
 	//喂食
	function setFeed(){
		$.post(ctx + '/mobile/user/setFeed', {}, function(data){
			alert(data.message);
			window.location.reload();
		});
	}
 	
	//收取收益
	function getIncome(){
		$.post(ctx + '/mobile/user/getAnimalIncome', {}, function(data){
			alert(data.message);
			window.location.reload();
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
    	<div class="container-fluid">
    		<h3 class="text-center"><strong>神兽详情</strong></h3>
    		<p class="text-center">备注:神兽要每天喂肉才能产生收益</p>
			<table class="table table-bordered table-striped">
				<tr class="text-center active">
					<td><strong>喂食状态</strong></td>
					<td><strong>当前益数</strong></td>
					<td><strong>总收益数</strong></td>
					<td><strong>喂食时间</strong></td>
				</tr>
				<tr class="text-center active">
					<c:choose>
						<c:when test="${animal.isFeed == 0 }">
							<td><img style="width:3em;" src="/hn_farm/images/nomeat.png" /></td>
						</c:when>
						<c:when test="${animal.isFeed == 1 }">
							<td><img style="width:3em;" src="/hn_farm/images/yesmeat.png" /></td>
						</c:when>
					</c:choose>
					<td><strong>${animal.currCount }</strong></td>
					<td><strong>${animal.incomeCount }</strong></td>
					<td><strong><fmt:formatDate value="${animal.feedTime }" pattern="MM-dd HH:mm:ss "/></strong></td>
				</tr>
			</table>
		    <div class="text-center" style="margin:15px;">
		    	<button type="button" class="btn btn-primary" onclick="setFeed()">神兽喂食</button>
		    	&nbsp;&nbsp;
		    	<button type="button" class="btn btn-primary" onclick="getIncome()">收取收益</button>
	    	</div>
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
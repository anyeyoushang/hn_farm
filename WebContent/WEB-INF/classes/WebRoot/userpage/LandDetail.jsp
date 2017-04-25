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
	//一键施肥
	function keyFertile(){
		$.post(ctx + '/mobile/user/keyFertile', {}, function(data){
			alert(data.message);
			window.location.reload();
		});
	}
	
	// 一键摘取果实
  	function keyPick(){
  		$.post(ctx + '/mobile/user/keyPick', {}, function(data){
  			console.log(data);
  			alert(data.message);
  			window.location.reload();
  		});
  	}
	
	// 土地开耕
	function openLand(){
		$.post(ctx + '/mobile/user/openLand', {}, function(data){
  			alert(data.message);
  			window.location.reload();
  		});
	}
	
	// 激活农场
	function activeFarm(){
		$.post(ctx + '/mobile/user/activeLand', {}, function(data){
  			console.log(data);
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
    	<c:if test="${!empty farmInfo }">
    		<h3 class="text-center"><strong>种植详情</strong></h3>
    		<table class="table table-bordered table-striped">
			    <tr class="text-center active">
		            <!-- <td><strong>土地类型</strong></td> -->
		            <td><strong>是否开耕</strong></td>
		            <td><strong>种植树木</strong></td>
		            <td><strong>总产量</strong></td>
		            <td><strong>果实数</strong></td>
		            <td><strong>施肥状态</strong></td>
		            <td><strong>施肥时间</strong></td>
		        </tr>
			    <c:forEach items="${farmInfo }" var="land">
			        <tr class="text-center active">
			        	<!-- 土地类型
			        	<c:choose>
			        		<c:when test="${land.landType == 0 }">
			        			<td><strong>普通</strong></td>
			        		</c:when>
			        		<c:when test="${land.landType == 1 }">
			        			<td><strong>黑</strong></td>
			        		</c:when>
			        	</c:choose> -->
				        <!-- 是否开耕 -->
				        <c:choose>
			        		<c:when test="${land.isOpen == 0 }">
			        			<td><strong>否</strong></td>
			        		</c:when>
			        		<c:when test="${land.isOpen == 1 }">
			        			<td><strong>是</strong></td>
			        		</c:when>
			        	</c:choose>
				        <!-- 种植树木 -->
				         <c:choose>
			        		<c:when test="${land.treeType == null }">
			        			<td><img style="width:2em;" src="/hn_farm/images/commonLandOpen.png" /></td>
			        			<!-- <td><strong>未种植</strong></td> -->
			        		</c:when>
			        		<c:when test="${land.treeType == 1 }">
			        			<td><img style="width:2em;" src="/hn_farm/images/orange512.png" /></td>
							</c:when>
							<c:when test="${land.treeType == 2 }">
								<td><img style="width:2em;" src="/hn_farm/images/apple512.png" /></td>
							</c:when>
							<c:when test="${land.treeType == 3 }">
								<td><img style="width:2em;" src="/hn_farm/images/banana512.png" /></td>
							</c:when>
			        	</c:choose>
			        	<!-- 总产量 -->
			        	<c:choose>
							<c:when test="${land.fruitsNum == 0 || land.fruitsNum == null }">
								<td><strong>0</strong></td>
							</c:when>
							<c:otherwise>
								<td><strong>${land.fruitsNum }</strong></td>
							</c:otherwise>							
						</c:choose>
						<!-- 果实数量 -->
						<!-- 
						<c:choose>
							<c:when test="${land.currFruitNum == 0 || land.currFruitNum == null }">
								<td><strong>0</strong></td>
							</c:when>
							<c:otherwise>
								<td><strong>${land.currFruitNum }</strong></td>
							</c:otherwise>							
						</c:choose>
						 -->
						<td><strong>${land.currFruitNum }/${land.dayPickFruitNum }</strong></td>
						<!-- 是否需要施肥 -->
						<c:choose>
							<c:when test="${land.isRich == 0 || land.isRich == null }">
							<td><img style="width:2em;" src="/hn_farm/images/weishifei.png" /></td>
							</c:when>
							<c:when test="${land.isRich == 1 }">
								<td><img style="width:2em;" src="/hn_farm/images/shifei.png" /></td>
							</c:when>
						</c:choose>
						<td><fmt:formatDate value="${land.getRichTime }" pattern="MM-dd HH:mm:ss "/></td>
			        </tr>
			    </c:forEach>
		    </table>
			    <div class="text-center" style="margin:15px;">
			    	<button type="button" class="btn btn-primary" onclick="keyPick()">一键摘取</button>
			    	&nbsp;&nbsp;
			    	<button type="button" class="btn btn-primary" onclick="keyFertile()">一键施肥</button>
			    	&nbsp;&nbsp;
			    	<button type="button" class="btn btn-primary" onclick="openLand()">土地开耕</button>
		    	</div>
	    	</c:if>
	    	<c:if test="${empty farmInfo }">
	    		<div class="text-center" style="margin:15px;">
	    		<h4 class="text-center">备注:激活农场会扣除您56元余额</h4>
	    			<button type="button" class="btn btn-primary" onclick="activeFarm()">激活农场</button>
	    		</div>
	    	</c:if>
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
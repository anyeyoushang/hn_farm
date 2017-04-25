<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>获得积分记录</title>
<meta name="description"
	content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/animate.css"
	type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/bootstrap/css/simple-line-icons.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/font.css"
	type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/app.css"
	type="text/css" />
<script src="${pageContext.request.contextPath }/userpage/assets/js/jquery-1.8.2.min.js"></script>
<script src="${pageContext.request.contextPath }/background/selftool/syUtils.js"></script>
</head>
<body>
<div class="app app-header-fixed" id="app">
<jsp:include page="menu.jsp"></jsp:include>

<!-- content -->
<div class="app-content">
	<img src="/hn_farm/images/bg1.png" class="img-responsive img-thumbnail" />
   	<h3 class="text-center"><strong>积分获得记录</strong></h3>
   	<table class="table table-bordered table-striped">
	    <tr class="text-center active">
            <td><strong>果树品种</strong></td>
            <td><strong>果实数量</strong></td>
            <td><strong>获得积分</strong></td>
	    	<td><strong>获得时间</strong></td>
   		</tr>
   		<c:forEach items="${records }" var="record">
    		<tr class="text-center active">
    		<td>
	    		<c:if test="${record.treeType == 1 }">
	    			<img style="width:2em;" src="/hn_farm/images/orange512.png" />
	    		</c:if>
	    		<c:if test="${record.treeType == 2 }">
	    			<img style="width:2em;" src="/hn_farm/images/apple512.png" />
	    		</c:if>
	    		<c:if test="${record.treeType == 3 }">
	    			<img style="width:2em;" src="/hn_farm/images/banana512.png" />
	    		</c:if>
    		</td>
	    	<td>${record.pickFruitNum }</td>
	    	<td>${record.pickIntegral }</td>
	    	<td>${record.pickFruitTime }</td>
    		</tr>
   		</c:forEach>
    </table>
</div>
<script type="text/javascript">
	var ctx = '${pageContext.request.contextPath}';
	$(function(){
		if('${user }' == ''){// 说明没有登陆
			// 去登陆
			location = '/hn_farm/index.jsp';
		}
	});
</script>

	</div>
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/bootstrap/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath }/bootstrap/vendor/jquery/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath }/bootstrap/layer/layer.js"></script>
	<script type="text/javascript">
    +function ($) {
      $(function(){
        // class
        $(document).on('click', '[data-toggle^="class"]', function(e){
          e && e.preventDefault();
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
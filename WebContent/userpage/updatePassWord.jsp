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
<title>申请提现</title>
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
</head>
<body>
	<div class="app app-header-fixed" id="app">
		<jsp:include page="menu.jsp"></jsp:include>

		<!-- content -->
		<div class="app-content">
			<div ui-butterbar></div>
			<div class="app-content-body fade-in-up">
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">申请提现</h3>
					</div>
					<div class="panel-body" id="cbox">
						<form class="bs-example bs-example-form" role="form" method="post"
							onsubmit="return check();" action="${pageContext.request.contextPath }/mobile/user/register">
							<div class="input-group">
								<span class="input-group-addon">提现用户</span> 
								<input type="text" readonly="readonly" class="form-control" value="${user.userPhone }">
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon">提现金额
								</span> <input type="text" name="passWord" class="form-control" placeholder="请输提现金额">
							</div>
							<input type="hidden" name="referee" value="${user.userId }" />
							<br/>
							<button type="submit" class="btn btn-info" style="float:right;">确认提交</button>
						</form>
					</div>
				</div>
			</div>
<script type="text/javascript">
var ctx = '${pageContext.request.contextPath}';
serializeObject = function(form){/*将form表单的值序列化成对象*/
	var o = {};
	$.each(form.serializeArray(), function(index){// 表单序列化为数组然后遍历
		if(o[this['name']]){
			o[this['name']] = o[this['name']] + "," + this['value'];
		}else{
			o[this['name']] = this['value'];
		}
	});
	return o;
};

// 表单验证
function check(){
	
	return true;
}



	
</script>
		</div>
		<!-- /content -->
		<!-- footer -->
		<div class="app-footer wrapper b-t bg-light">
			<span class="pull-right">Top<a href="#app"
				class="m-l-sm text-muted"><i class="fa fa-long-arrow-up"></i></a></span> <a
				href="javascript:void(0);" target="_blank" title="HaoNiuSoft">
				HaoNiu Soft Co.&copy;2016 Copyright.</a>
		</div>
		<!-- / footer -->
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
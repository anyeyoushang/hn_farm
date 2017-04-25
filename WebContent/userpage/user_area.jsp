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
<title>中安占海</title>
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
</head>
<body>
	<div class="app app-header-fixed" id="app">
		<!-- navbar -->
		<div class="app-header navbar">
			<!-- navbar header -->
			<div class="navbar-header bg-dark">
				<button class="pull-right visible-xs" data-toggle="class:off-screen"
					data-target=".app-aside" ui-scroll="app">
					<i class="glyphicon glyphicon-align-justify"></i>
				</button>
				<!-- brand -->
				<a href="#/" class="navbar-brand text-lt"> <!-- <i class="fa fa-btc"></i> -->
					<img src="${pageContext.request.contextPath }/bootstarp/img/logo.png" alt="." class="hide">
					<span class="hidden-folded m-l-xs">中安占海云平台</span>
				</a>
				<!-- / brand -->
			</div>
			<!-- / navbar collapse -->
		</div>
		<!-- / navbar -->

		<!-- menu -->
		<div class="app-aside hidden-xs bg-dark">
			<div class="aside-wrap">
				<div class="navi-wrap">
					<!-- nav -->
					<nav ui-nav class="navi">
						<ul class="nav">
							<li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
								<span translate="aside.nav.HEADER">Navigation</span>
							</li>
							<li ui-sref-active="active"><a href="${pageContext.request.contextPath }/shop/show.html">
									<!-- <i class="glyphicon glyphicon-calendar icon text-info-dker"></i> -->
									<i class="icon-user icon text-success-lter"></i> <span
									class="font-bold" translate="aside.nav.CALENDAR">我的主页</span>
							</a></li>
							<li ui-sref-active="active"><a ui-sref="app.mail.list" href="${pageContext.request.contextPath }/shop/news.html">
									<i class="glyphicon glyphicon-envelope icon text-info-lter"></i>
									<span class="font-bold" translate="aside.nav.EMAIL">新闻消息</span>
							</a></li>
							<li><a href class="auto"> <span
									class="pull-right text-muted"> <i
										class="fa fa-fw fa-angle-right text"></i> <i
										class="fa fa-fw fa-angle-down text-active"></i>
								</span> <i class="glyphicon glyphicon-th-large icon text-success"></i>
									<span class="font-bold" translate="aside.nav.DASHBOARD">账户管理</span>
							</a>
								<ul class="nav nav-sub dk">
									<li class="nav-sub-header"><a href> <span
											translate="aside.nav.DASHBOARD">Dashboard</span>
									</a></li>
									<li ui-sref-active="active"><a
										href="${pageContext.request.contextPath }/shop/changeInfo.html"> <span>修改资料</span>
									</a></li>
									<li ui-sref-active="active"><a
										href="${pageContext.request.contextPath }/shop/changePass.html"> <span>修改密码</span>
									</a>
								</ul></li>
							<li><a href class="auto"> <span
									class="pull-right text-muted"> <i
										class="fa fa-fw fa-angle-right text"></i> <i
										class="fa fa-fw fa-angle-down text-active"></i>
								</span> <i class="glyphicon glyphicon-briefcase icon"></i> <span
									class="font-bold" translate="aside.nav.DASHBOARD">会员中心</span>
							</a>
								<ul class="nav nav-sub dk">
									<li class="nav-sub-header"><a href> <span
											translate="aside.nav.DASHBOARD">Dashboard</span>
									</a></li>
									<li ui-sref-active="active"><a
										href="${pageContext.request.contextPath }/shop/createUser.html"> <span>注册会员</span>
									</a></li>
									<li ui-sref-active="active"><a href="javascript:void(0);">
											<span>区域列表</span>
									</a>
								</ul></li>
							<li><a href class="auto"> <span
									class="pull-right text-muted"> <i
										class="fa fa-fw fa-angle-right text"></i> <i
										class="fa fa-fw fa-angle-down text-active"></i>
								</span> <i class="glyphicon glyphicon-stats icon text-primary-dker"></i>
									<span class="font-bold">财务管理</span>
							</a>
								<ul class="nav nav-sub dk">
									<li class="nav-sub-header"><a href> <span>我的账户</span>
									</a></li>
									<li ui-sref-active="active"><a ui-sref="apps.note" href="${pageContext.request.contextPath }/shop/changeIncome.html"> <span>兑换金币</span>
									</a></li>
									<li ui-sref-active="active"><a ui-sref="apps.contact" href = "${pageContext.request.contextPath }/shop/changePoint.html">
											<span>申请提现</span>
									</a></li>
									
								</ul></li>

							<li class="line dk hidden-folded"></li>

							<li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
								<span translate="aside.nav.your_stuff.YOUR_STUFF">Your
									Stuff</span>
							</li>
							<li><a ui-sref="app.page.profile" href="tel:400000000000"> <i
									class="fa fa-phone"></i> <span
									translate="aside.nav.your_stuff.PROFILE">联系我们</span>
							</a></li>
							<li><a ui-sref="app.docs" href = "javascript:alert('占海集团，想你所想。用心铸就辉煌！')"> <i class="icon-question icon"></i>
									<span translate="aside.nav.your_stuff.DOCUMENTS">关于占海</span>
							</a></li>
							<li><a href="${pageContext.request.contextPath }/shop/loginOut.html"> <i
									class="icon-share icon"></i> <span
									translate="aside.nav.your_stuff.DOCUMENTS">安全退出</span>
							</a></li>
						</ul>
					</nav>
					<!-- nav -->
				</div>
			</div>
		</div>
		<!-- / menu -->

		<!-- content -->
		<div class="app-content">
			<div ui-butterbar></div>
			<div class="app-content-body fade-in-up">
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">用户 区域列表</h3>
					</div>
					<a href="${pageContext.request.contextPath }/shop/show.html" style="margin:15px 0px 5px 15px;"
						class="btn btn-info">返回</a>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-4">
								<div class="table-responsive">
									<table class="table table-bordered table-hover table-striped">
										<thead>
											<tr>
												<th>左区</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${left}" var="left">
												<tr>
													<td>${left.userName }<small><br>登录名:${left.loginName }</small></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="table-responsive">
									<table class="table table-bordered table-hover table-striped">
										<thead>
											<tr>
												<th>右区</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${right}" var="right">
												<tr>
													<td>${right.userName }<small><br>登录名:${right.loginName }</small></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-lg-8">
								<div id="morris-bar-chart"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /content -->
		<!-- footer -->
		<div class="app-footer wrapper b-t bg-light">
			<span class="pull-right">Top<a href="#app"
				class="m-l-sm text-muted"><i class="fa fa-long-arrow-up"></i></a></span> <a
				href="http://www.cssmoban.com/" target="_blank" title="HaoNiuSoft">
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
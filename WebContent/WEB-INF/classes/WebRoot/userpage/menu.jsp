<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
			<span class="hidden-folded m-l-xs">欢乐农场云平台</span>
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
          <li ui-sref-active="active">
            <a ui-sref="app.mail.list" href="${pageContext.request.contextPath }/mobile/user/getFarmDetail">
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.EMAIL">我的农场</span>
            </a>
          </li>
          <li ui-sref-active="active">
            <a href="${pageContext.request.contextPath }/userpage/shopCenter.jsp">
              <!-- <i class="glyphicon glyphicon-calendar icon text-info-dker"></i> -->
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.CALENDAR">商城中心</span>
            </a>
          </li>
          <li data-ui-sref-active="active">
            <a href="${pageContext.request.contextPath }/userpage/rechargeCenter.jsp">
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.CALENDAR">充值中心</span>
            </a>
          </li>
          <li data-ui-sref-active="active">
            <a href="${pageContext.request.contextPath }/mobile/user/getLandDetail">
              <!-- <i class="glyphicon glyphicon-calendar icon text-info-dker"></i> -->
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.CALENDAR">种植详情</span>
            </a>
          </li>
          <li data-ui-sref-active="active">
            <a href="${pageContext.request.contextPath }/mobile/user/checkAnimalDetail">
              <!-- <i class="glyphicon glyphicon-calendar icon text-info-dker"></i> -->
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.CALENDAR">神兽详情</span>
            </a>
          </li>
          <li data-ui-sref-active="active">
            <a href="${pageContext.request.contextPath }/mobile/user/findGetIntegralRecord">
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.CALENDAR">获得积分记录</span>
            </a>
          </li>
          <li data-ui-sref-active="active">
            <a href="${pageContext.request.contextPath }/mobile/user/findAskCashRecord">
              <!-- <i class="glyphicon glyphicon-calendar icon text-info-dker"></i> -->
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.CALENDAR">积分提现记录</span>
            </a>
          </li>
          <li data-ui-sref-active="active">
            <a href="${pageContext.request.contextPath }/mobile/user/downQuery">
              <!-- <i class="glyphicon glyphicon-calendar icon text-info-dker"></i> -->
              <i class="icon-user icon text-success-lter"></i>
              <span class="font-bold" translate="aside.nav.CALENDAR">果实互偷</span>
            </a>
          </li>
          <!-- 
          <li>
            <a href class="auto">      
              <span class="pull-right text-muted">
                <i class="fa fa-fw fa-angle-right text"></i>
                <i class="fa fa-fw fa-angle-down text-active"></i>
              </span>
              <i class="glyphicon glyphicon-th-large icon text-success"></i>
              <span class="font-bold" translate="aside.nav.DASHBOARD">账户管理</span>
            </a>
            <ul class="nav nav-sub dk">
              <li class="nav-sub-header">
                <a href>
                  <span data-translate="aside.nav.DASHBOARD">Dashboard</span>
                </a>
              </li>
              <li data-ui-sref-active="active">
              	<a href = "${pageContext.request.contextPath }/mobile/user/downQuery">
                	<span>果实互偷</span>
              	</a>
              </li>
                <li data-ui-sref-active="active">
                <a href="${pageContext.request.contextPath }/shop/updatePassWord.jsp">
                  <span>修改密码</span>
                </a>
                </li>
                
            </ul>
          </li>
            -->
          <li>
            <a href class="auto">      
              <span class="pull-right text-muted">
                <i class="fa fa-fw fa-angle-right text"></i>
                <i class="fa fa-fw fa-angle-down text-active"></i>
              </span>
              <i class="glyphicon glyphicon-briefcase icon"></i>
              <span class="font-bold" translate="aside.nav.DASHBOARD">会员中心</span>
            </a>
            <ul class="nav nav-sub dk">
              <li class="nav-sub-header">
                <a href>
                  <span data-translate="aside.nav.DASHBOARD">Dashboard</span>
                </a>
              </li>
              <li ui-sref-active="active">
                <a href="${pageContext.request.contextPath }/mobile/user/createRegisterLink">
                  <span>推荐注册</span>
                </a>
              </li>
              <li ui-sref-active="active">
                <a href="${pageContext.request.contextPath }/userpage/askCash.jsp">
                  <span>积分提现</span>
                </a>
              </li>
            </ul>
          </li>
          <li class="line dk hidden-folded"></li>
          <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">          
            <span translate="aside.nav.your_stuff.YOUR_STUFF">Your Stuff</span>
          </li>  
          <li>
            <a ui-sref="app.docs" href = "javascript:alert('小赢靠智、大赢靠德: 欢乐农场火爆来袭！')">
              <i class="icon-question icon"></i>
              <span translate="aside.nav.your_stuff.DOCUMENTS">关于农场</span>
            </a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath }/mobile/user/userQuit">
              <i class="icon-share icon"></i>
              <span translate="aside.nav.your_stuff.DOCUMENTS">安全退出</span>
            </a>
          </li>
        </ul>
      </nav>
      <!-- nav -->
    </div>
  </div>
</div>
<!-- / menu -->


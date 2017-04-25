<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%--<jsp:forward page="background/index.jsp"></jsp:forward>--%>
<%
String str = request.getContextPath();
response.sendRedirect(str + "/background/backLogin.jsp");	
%>
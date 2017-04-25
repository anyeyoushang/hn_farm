/*
 * @(#) FrontRoutes.java 2016-8-27
 *
 * Copyright (c) 2015, HaoniuSoft Technology. All Rights Reserved.
 * HaoniuSoft  Technology. CONFIDENTIAL
 */
package controller;


import com.jfinal.config.Routes;

import controller.mobile.UserController;
import controller.sys.SysUserController;

/**
 * 前端路由
 * @Description 
 * 
 * @author wh
 * @version 1.0
 * @since 2016-8-27
 */
public class FrontRoutes extends Routes {

	@Override
	public void config() {
		add("/", DefaultController.class);
		add("/mobile/user", UserController.class);
		add("/sys/user", SysUserController.class);
	}
	
}

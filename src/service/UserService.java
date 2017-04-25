package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;


import model.dao.User;

public class UserService implements SysService {

	@Override
	public boolean addData(HashMap<String, Object> paramMap) {
		return false;
	}

	@Override
	public boolean deleteData(HashMap<String, Object> paramMap) {
		return false;
	}

	@Override
	public void updateData(HashMap<String, Object> paramMap) {
		
	}

	@Override@SuppressWarnings("rawtypes")
	public Map<String, Object> getDataList(HashMap<String, String> paramMap) {
		// {startTime=2016-11-15, sort=addTime, order=asc, 
		// page=1, userPhone=123, realName=王军, endTime=2016-11-16, rows=15}
		String sql = "select * from t_user where 1=1";
		String realName = paramMap.get("realName");
		String userPhone = paramMap.get("userPhone");
		String startTime = paramMap.get("startTime");
		String endTime = paramMap.get("endTime");
		if(realName != null && realName != ""){
			sql += " and realName like '%"+ realName +"%'";
		}
		if(userPhone != null && userPhone != ""){
			sql += " and userPhone like '%"+ userPhone +"%'";
		} 
		if(startTime != null && startTime != ""){
			sql += " and addTime >= '"+ startTime + "'";
		} 
		if(endTime != null && endTime != ""){
			sql += " and addTime <= '"+ endTime + "'";
		}
		sql += " order by " + paramMap.get("sort") + " " + paramMap.get("order");
		
		Integer pageNumber = Integer.valueOf(paramMap.get("page"));
		Integer pageSize = Integer.valueOf(paramMap.get("rows"));
		Page pageList = User.dao.getDataList(pageNumber, pageSize, sql);
		int total = pageList.getTotalRow();
		List rows = pageList.getList();
		Map<String, Object> pageData = new HashMap<String, Object>();
		pageData.put("total", total);
		pageData.put("rows", rows);
		return pageData;
	}

	/**
	 * 用户登陆
	 * 
	 * @author wh
	 * @since 2016-11-7
	 * @param paramsMap
	 * @return
	 */
	public User login(Map<String, String> paramsMap) {
		String userPhoneAndUserName = paramsMap.get("userPhoneAndUserName");
		String passWord = paramsMap.get("passWord");
		// 0后台登陆,1前台登陆
		String userRole = paramsMap.get("userRole");
		return User.dao.login(userPhoneAndUserName, passWord, userRole);
	}

	
	


	
	
	

}

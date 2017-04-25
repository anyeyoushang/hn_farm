package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Page;


import model.dao.AskCash;

public class AskCashService implements SysService {

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
		String sql = "SELECT * FROM t_ask_cash AS tac LEFT JOIN t_user AS tu ON tac.cashUserId = tu.userId";
		Integer pageNumber = Integer.valueOf(paramMap.get("page"));
		Integer pageSize = Integer.valueOf(paramMap.get("rows"));
		Page pageList = AskCash.dao.getDataList(pageNumber, pageSize, sql);
		int total = pageList.getTotalRow();
		List rows = pageList.getList();
		Map<String, Object> pageData = new HashMap<String, Object>();
		pageData.put("total", total);
		pageData.put("rows", rows);
		return pageData;
	}


	

	
	
	


	
	
	

}

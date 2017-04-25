package service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;

import model.dao.Animal;
import model.dao.AnimalIncome;

public class AnimalService implements SysService {

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
		String sql = "SELECT * FROM t_animal_income AS tai LEFT JOIN t_animal AS ta ON tai.incomeAnimalId = ta.animalId LEFT JOIN t_user AS tu ON ta.aniFarmId = tu.userId";
		Integer pageNumber = Integer.valueOf(paramMap.get("page"));
		Integer pageSize = Integer.valueOf(paramMap.get("rows"));
		Page pageList = AnimalIncome.dao.getDataList(pageNumber, pageSize, sql);
		int total = pageList.getTotalRow();
		List rows = pageList.getList();
		Map<String, Object> pageData = new HashMap<String, Object>();
		pageData.put("total", total);
		pageData.put("rows", rows);
		return pageData;
	}

	public Integer addAnimal(){
		try {
			Animal animal = new Animal();
			animal.setAniFarmId(1);
			animal.setIncomeCount(2);
			animal.save();
			System.out.println(1/0);
			return animal.getAnimalId();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				DbKit.getConfig().getThreadLocalConnection().rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return null;
		}
	}
	

	
	
	


	
	
	

}

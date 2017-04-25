package model.dao;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import model.basemodel.BaseTempPick;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class TempPick extends BaseTempPick<TempPick> {
	public static final TempPick dao = new TempPick();
	
	/**
	 * 查询今天摘取的果实总数 
	 * @author wh
	 * @param treeId 
	 * @return 
	 * @since 2016-11-11
	 */
	public Record findPickCount(Object treeId) {
		String sql = "SELECT SUM(pickFruitNum) AS pickCount FROM t_temp_pick WHERE treeId = ? AND pickFruitTime >= CURRENT_DATE()";
		return Db.findFirst(sql, treeId);
	}

	@SuppressWarnings("rawtypes")
	public Page getDataList(Integer pageNumber, Integer pageSize, String sql) {
		return paginate(pageNumber, pageSize, sql);
	}
}

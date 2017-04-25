package model.basemodel;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * model的基类
 * @author Janesen
 * @param <M>
 */
@SuppressWarnings({  "rawtypes" })
public abstract class BaseModel<M extends Model> extends Model<M> {
	public static final long serialVersionUID = 2910152181043514607L;
	public abstract String getTableName();
	
	private Map<String, Object> map=new HashMap<String, Object>();
	
	/**
	 * 构建查询的sql语句
	 * @param where 查询条件
	 * @return
	 */
	public abstract Page getDataList(Map<String, Object> where);
	
	/**
	 * 构建非列表查询的sql语句
	 * @param where
	 * @return
	 */
	public Object getDataListNotPage(Map<String, Object> where){
		return null;
	}
	
	/**
	 * 自定义保存
	 * @return
	 */
	public Map<String, Object> saveData(Map<String, Object> map,BaseModel<?> model){
		model.put(map);
		model.save();
		map.put("RequestNormal", 0);
		map.put("content", "保存成功");
		return map;
	}
	
	/**
	 * 获得属性默认值的record的映射
	 * @return
	 */
	public Record getDefaultValueRecord(){
		return new Record();
	}
	
	@Override
	public boolean save() {
		Record defaultRecord=getDefaultValueRecord();
		if(defaultRecord!=null){
			String[] names=defaultRecord.getColumnNames();
			for (String string : names) {
				if(isEmpty(string)){
					set(string, defaultRecord.get(string));
				}
			}
		}
		return super.save();
	}
	

	
	public boolean update(String sql,Object...params){
		return Db.update(sql, params)>0;
	}
	
	
	public boolean IUpdateData(String data){
		return true;
	}
	
	
	public boolean deleteData(Object id){
		return this.deleteById(id);
	}
	
	/**
	 * 格式化时间
	 * @param object
	 * @param attr
	 * @param pattern
	 */
	public void formatDateTime(String attr,String pattern){
		if(super.get(attr)!=null&&!StringUtils.isEmpty(super.get(attr).toString())){
			SimpleDateFormat dateFormat=new SimpleDateFormat(pattern);
			try {
				
				set(attr, dateFormat.format(super.getTimestamp(attr)));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 判断属性是否为空
	 * @param attr
	 * @return
	 */
	public boolean isEmpty(String attr){
		if(get(attr) instanceof Number){
			return false;
		}
		if(get(attr)==null||StringUtils.isEmpty(get(attr).toString())){
			return true;
		}
		return false;
	}

	public Object getData(Integer id){
		return null;
	}
	
	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	
}

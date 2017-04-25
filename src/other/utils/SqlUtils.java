package other.utils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

/**
 * 操作sql的工具类
 * @author Janesen
 * 
 */
public class SqlUtils {

	/**
	 * 匹配操作符的正则表达式
	 */
	private static String operateReg = "(.*)(\\&{1}|\\|{2})([\\=,\\+,\\-,\\*,\\/,\\<,\\>,\\!,%,\\.,i,n,o,t,_,^, ,l,k,e]+)";
	
	public static void main(String[] args) {
//		Map<String, Object> where = new HashMap<String, Object>();
//		where.put("age||notin", new String[] { "1", "2", "3" });
//		// System.out.println(JsonKit.toJson(buildWhereSql(where)));
//		String sqlStr = "select * from teest group by dd";
//		System.out.println(appendWhere(sqlStr, where).getSqlStr());
		Map<String, Object> where = new HashMap<String, Object>();
		where.put("age||notin", new String[] { "1", "2", "3" });
		buildWhereSql(where);
	}
	
	// 构建sql语句
	public static SqlEntity buildWhereSql(Map<String, Object> where) {
		return buildWhereSql(where, null);
	}
	
	/**
	 * 构建where sql语句
	 * 
	 * @param where
	 *            map
	 * @param Map特殊规则介绍
	 *            ：
	 * @param key规则如下
	 *            ：
	 * @param 【列名+条件符+操作符】
	 * 
	 * @param 列名
	 *            ：表格的列名称
	 * @param 条件符
	 *            ：& 和 || ，翻译成sql语句就是 and 和 or
	 * @param 操作符
	 *            ：就是普通的sql比较符，>=、<=、>、<、= 、in、not in、lk 其中lk表示like
	 * 
	 * @param 例如：
	 * 			key: number&>= value:2 生成后的where语句为 and number >= 2
	 * 			key: name&lk% value:a 生成后的where语句为 and name like 'a%'
	 * @return
	 */
	public static SqlEntity buildWhereSql(Map<String, Object> where,String alias) {
		SqlEntity sqlEntity = new SqlEntity();

		String sqlStr = " where 1=1 ";

		Set<String> keys = where.keySet();
		for (String string : keys) {
			if(StringUtils.isNotBlank(string)&&!string.startsWith("@")&&!string.equals("null")){
				Object value = where.get(string);
				if (StringUtils.isEmpty(value.toString()))
					continue;

				Matcher matcher = Pattern.compile(operateReg).matcher(string);
				if (matcher.find()) {
					String columnName = matcher.group(1);
					if(StringUtils.isNotBlank(alias)){
						columnName=alias+"."+columnName;
					}
					if (matcher.group(2).equals("&")) {
						sqlStr += " and " + columnName;
					} else if (matcher.group(2).equals("||")) {
						sqlStr += " or " + columnName;
					}
					String operate = matcher.group(3);
					if (operate.contains("lk")) {
						sqlStr += " like ? ";
						sqlEntity.getListParams().add(
								operate.replaceAll("lk", value.toString())
										.replaceAll(" ", ""));
					} else if (operate.equals("in")) {
						sqlStr += " in ("
								+ convertInPlaceholder(where.get(string),
										sqlEntity.getListParams()) + ") ";
					} else if (operate.contains("not") && operate.contains("in")) {
						sqlStr += " not in ("
								+ convertInPlaceholder(where.get(string),
										sqlEntity.getListParams()) + ") ";
					} else {
						sqlStr += " " + operate + " ? ";
						sqlEntity.getListParams().add(value);
					}
				} else {
					sqlStr += " and " + string + " = ?";
					sqlEntity.getListParams().add(value);
				}
			}
		}
		sqlEntity.setSqlStr(sqlStr);
		return sqlEntity;
	}

	private static String convertInPlaceholder(Object value, List<Object> values) {
		List<String> pStr = new ArrayList<String>();
		if (value instanceof Object[]) {
			Object[] ps = (Object[]) value;
			for (int i = 0; i < ps.length; i++) {
				values.add(ps[i]);
				pStr.add("?");
			}
		} else if (value instanceof Collection<?>) {
			List<?> list = (List<?>) value;
			for (int i = 0; i < list.size(); i++) {
				values.add(list.get(i));
				pStr.add("?");
			}
		}else if(value.toString().contains(",")){
			String[] arrays=value.toString().split(",");
			for (String string : arrays) {
				values.add(string);
				pStr.add("?");
			}
		}else {
			values.add(value);
			pStr.add("?");
		}
		return StringUtils.join(pStr, ",");
	}

	public static class WhereModel {
		private String sqlStr;
		private List<Object> values;

		public String getSqlStr() {
			return sqlStr;
		}

		public void setSqlStr(String sqlStr) {
			this.sqlStr = sqlStr;
		}

		public List<Object> getValues() {
			if (values == null) {
				values = new ArrayList<Object>();
			}
			return values;
		}

		public void setValues(List<Object> values) {
			this.values = values;
		}
	}

	/**
	 * 追加where判断语句
	 * 
	 * @param sqlStr
	 *            原sql语句
	 * @param where
	 *            判断条件
	 * @return
	 */
	public static SqlEntity appendWhere(String sqlStr, Map<String, Object> where) {
		return appendWhere(sqlStr, where, null);
	}
	/**
	 * 追加where判断语句
	 * 
	 * @param sqlStr
	 *            原sql语句
	 * @param where
	 *            判断条件
	 * @return
	 */
	public static SqlEntity appendWhere(String sqlStr, Map<String, Object> where,String alias) {
		SqlEntity sqlEntity = new SqlEntity();
		if(where!=null){
			SqlEntity whereEntity = buildWhereSql(where,alias);
			String sql= sqlStr.toLowerCase();
			String[] arraySql = sql.split("where");

			String whereSql="";
			if (arraySql.length > 1) {
				whereSql=whereEntity.getSqlStr() + " and "+ arraySql[1];
			} else {
				whereSql=whereEntity.getSqlStr();
			}
			sql=arraySql[0];
			
			
			if(!sql.contains("group by")){
				sql=SelfStrUtils.insertStr(sql, " order by ", whereSql);
			}else{
				sql=SelfStrUtils.insertStr(sql, " group by ", whereSql);
			}
			
			
			sqlEntity.setSqlStr(sql);
			sqlEntity.getListParams().addAll(whereEntity.getListParams());
		}else{
			sqlEntity.setSqlStr(sqlStr);
		}
		return sqlEntity;
	}


}

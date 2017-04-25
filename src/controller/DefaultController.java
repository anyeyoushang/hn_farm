package controller;

import java.sql.SQLException;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import other.utils.ToolUtils;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.DbKit;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.jfinal.upload.UploadFile;

/**
 * 后台的controller,封装了后台的增删改查
 * @Description 
 * @author wh
 * @version 1.0
 * @since 2016-10-10
 */
public class DefaultController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(DefaultController.class);
	
	public static void main(String[] args) {
		String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
		System.out.println(uuid);
		System.out.println("getDataList".equals(backExecuteEnum.getDataList));
	}
	
	private String pack = "service.";
	
	public enum backExecuteEnum{
		addData,
		deleteData,
		updateData,
		getDataList
	}
	
	/**
	 * 添加数据(添加和修改有可能含有上传)
	 * @author wh
	 * @throws SQLException 
	 * @since 2016-10-9
	 */
	@Before(Tx.class)
	public void addData() throws SQLException{
		UploadFile file = null;
		try {
			file = getFile();// 上传表单
		} catch (Exception e) {// 普通表单
			try {
			addInfo(file);// 普通表单执行上传
			} catch (Exception e1) {// 普通表单报错
				 e.printStackTrace();
				 DbKit.getConfig().getConnection().rollback();
				 renderJsonError(RequestError, "添加失败!");
			}
		}
		// ----------------
		try {
			addInfo(file);// 上传表单执行上传
		} catch (Exception e) {
			e.printStackTrace();
			 DbKit.getConfig().getConnection().rollback();
			 renderJsonError(RequestError, "添加失败!");
		}
		
	}

	public void addInfo(UploadFile file) throws Exception {
		if(checkPara("name", "age", "type")){
			// 获得参数map
			Map<String, Object> paramMap = ToolUtils.chageParaMap(getParaMap());
			// 获得className
			String className = pack + (String) paramMap.get("className");
			paramMap.remove("className");
			
			// 文件不为空就上传
			if(file != null){
				String saveName = ToolUtils.upload(file);
				paramMap.put("markPic", saveName);
			}
			// 调用该service中的getDataList方法
			ToolUtils.executeMethod(className, 
					backExecuteEnum.addData.toString(), paramMap);
			renderJsonError(RequestNormal, "添加成功!");
		}else{
			throw new RuntimeException();
		}
	}
	
	/**
	 * 后台管理系统删除数据
	 * @author wh
	 * @since 2016-10-24
	 */
	@Before(Tx.class)
	public void deleteData(){
		try {
			// 获得参数map
			Map<String, Object> paramMap = ToolUtils.chageParaMap(getParaMap());
			// 获得className
			String className = pack + (String) paramMap.get("className");
			paramMap.remove("className");

			Boolean flag = (Boolean) ToolUtils.executeMethod(className, 
					backExecuteEnum.deleteData.toString(), paramMap);
			if(flag){
				renderJsonError(RequestNormal, "删除成功!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			 try {
				DbKit.getConfig().getConnection().rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			renderJsonError(RequestError, "删除失败!");
		}
	}
	
	/**
	 * 后台修改数据
	 * 
	 * @author wh
	 * @since 2016-10-25
	 */
	@Before(Tx.class)
	public void updateData(){
		
	}
	
	/**
	 * 查询填充datagrid的数据 
	 * @author wh
	 * @since 2016-10-7
	 */
	public void showDataList(){
		try {
			if(checkPara("page", "rows")){
				// 获得参数map
				Map<String, Object> paramMap = ToolUtils.chageParaMap(getParaMap());
				// 获得className
				String className = pack + (String) paramMap.get("className");
				logger.debug(className + "进入showDataList方法");
				paramMap.remove("className");
				// 调用该service中的getDataList方法(后两个参数一致)
				renderJson(ToolUtils.executeMethod(className, 
						backExecuteEnum.getDataList.toString(), paramMap));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

	
	
	
	

	
	
	
	
}

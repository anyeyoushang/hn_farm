package controller.sys;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import other.utils.ToolUtils;
import model.dao.AskCash;
import model.dao.User;
import com.jfinal.aop.Clear;
import controller.BaseController;

public class SysUserController extends BaseController{
	
//	@Clear@ActionKey("/sys")
//	public void index(){
//		if (isAjax(getRequest())) {
//			String sql = "select * from t_user";
//			List<User> userList = User.dao.find(sql);
//			List<String> dataArray = new ArrayList<String>();
//			for (int i = 0; i < userList.size(); i++) {
//				User user = userList.get(i);
//				dataArray.add(user.toJson());
//			}
//			Map<String,Object> map = new HashMap<String,Object>();
//			map.put("rows", dataArray);
//			map.put("current", 1);
//			map.put("totalJson", 222);
//			//List<Map<String,Object>> list = User.dao.*/
//			JSONObject jo = JSONObject.fromObject(map);
//			System.out.println(jo.toString());
//			
//			renderJson(jo.toString());
//		}else{
//			renderJsp("/userpage/sys/index.jsp");
//		}
//	}
	
	public boolean isAjax(HttpServletRequest request){
		String requestType = request.getHeader("X-Requested-With"); 
		if (requestType == null) {
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 后台充值余额
	 * @author wh
	 * @since 2016-11-12
	 */
	public void addUserMoney(){
		if (checkPara("userId")) {
			String userId = getPara("userId");
			String userMoney = getPara("userMoney");
			User user = User.dao.findById(userId);
			System.out.println(user.toString());
			user.set("userMoney", user.getDouble("userMoney")+Double.valueOf(userMoney));
			user.update();
			renderJsonError(RequestNormal, "充值成功!");
		}
	}
	
	
	
	/**
	 * 删除用户
	 * @author wh
	 * @since 2016-11-10
	 */
	public void deleteUser(){
		Map<String, String> parasMap = ToolUtils.chageParaMapToString(getParaMap());
		for(String userId : parasMap.keySet()){
			if(userId.contains("userId")){
				User.dao.deleteById(parasMap.get(userId));
			}
		}
		renderJsonError(RequestNormal, "删除成功!");
	}
	
	/**
	 * 确认用户的提现 
	 * @author wh
	 * @since 2016-11-12
	 */
	public void confirmCash(){
		Map<String, String> paramsMap = ToolUtils.chageParaMapToString(getParaMap());
		String askCashId = paramsMap.get("askCashId");
		String cashState = paramsMap.get("cashState");
		AskCash.dao.findById(askCashId).set("cashState", cashState).update();
		renderJsonError(RequestNormal, "打款成功!");
	}
	
	/**
	 * 修改用户的数据 
	 * @author wh
	 * @since 2016-11-16
	 */
	public void updateUser(){
		try {
			Map<String, Object> paramsMap = ToolUtils.chageParaMap(getParaMap());
			//{animalDueTime=, refereeId=, farmIntegral=266, userRole=0, 
			//fertilizer=127, passWord=admin, farmAnimal=1, farmType=0, userMoney=7400, 
			//		bankId=, weixinId=heihei, remainMeat=0, userId=1, userPhone=admin, 
			//		realName=admin, addTime=2016-11-03 09:31:01}
			User user = User.dao.findById(paramsMap.get("userId"));
			user.set("userMoney", paramsMap.get("userMoney"));
			user.set("farmIntegral", paramsMap.get("farmIntegral"));
			user.update();
			renderJsonError(RequestNormal, "修改数据成功!");
		} catch (Exception e) {
			e.printStackTrace();
			renderJsonError(RequestError, "修改数据失败!");
		}
	}
	
	/**
	 * 后台登陆 
	 * @author wh
	 * @since 2016-11-17
	 */
	@Clear
	public void backLogin(){
		Map<String, String> paramsMap = ToolUtils.chageParaMapToString(getParaMap());
		String userName = paramsMap.get("userName");
		String passWord = paramsMap.get("passWord");
		if(userName.equals("admin") && passWord.equals("admin")){
			setSessionAttr("adminUser", "loginSuccess");
			renderJsonError(RequestNormal, "");
		}else{
			renderJsonError(RequestError, "");
		}
	}
	
	/**
	 * 后台用户退出登录 
	 * @author wh
	 * @since 2016-11-18
	 */
	public void quitLogin(){
		getSession().removeAttribute("adminUser");
		redirect("/bindex.jsp");
	}
	
	/**
	 * 
	 * @author wh
	 * @since 2016-11-17
	 */
	public void jumpBack(){
		redirect("/background/index.jsp");
	}
	
}

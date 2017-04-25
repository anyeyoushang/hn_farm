package controller.mobile;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import model.dao.Animal;
import model.dao.AnimalIncome;
import model.dao.AskCash;
import model.dao.Land;
import model.dao.LandTree;
import model.dao.LandTree.TreeFatEnum;
import model.dao.OpenLand;
import model.dao.Steal;
import model.dao.TempPick;
import model.dao.User;
import model.dao.User.FarmAnimalEnum;
import other.utils.ToolUtils;
import service.UserService;

import com.jfinal.aop.Clear;
import com.jfinal.core.ActionKey;
import com.jfinal.plugin.activerecord.Record;

import controller.BaseController;

public class UserController extends BaseController {
	private static final Logger log = LoggerFactory.getLogger(UserController.class);
	/**
	 * 用户的登陆
	 * @author wh
	 * @since 2016-11-7
	 */
	@Clear@ActionKey("/login")
	public void login(){
		if(checkPara("userPhoneAndUserName", "passWord", "userRole")){
			Map<String, String> paramsMap = ToolUtils.chageParaMapToString(getParaMap());
			User user = new UserService().login(paramsMap);
			if(user != null){
				if(getPara("userRole").equals("0")){
					setSessionAttr("adminUser", new User());
				}else{
					setSessionAttr("user", user);
				}
				renderJsonError(RequestNormal, "登陆成功!");
			}else{
				renderJsonError(RequestError, "您的用户名活密码不正确!");
			}
		}
	}
	
	
	@Clear@ActionKey("/backgroundLogin")
	public void backgroundLogin(){
		Map<String, String> loginMap = ToolUtils.chageParaMapToString(getParaMap());
		if(loginMap.get("userPhoneAndUserName").equals("admin") && loginMap.get("passWord").equals("admin")){
			renderJsonError(RequestNormal, "");
		}else{
			renderJsonError(RequestError, "");
		}
	}
	
	/**
	 * 创建分享注册的链接
	 * @author wh
	 * @since 2016-11-11
	 */
	public void createRegisterLink(){
		User loginUser = (User) getSession().getAttribute("user");
		String userId = loginUser.get("userId").toString();
		String userPhone = loginUser.get("userPhone");
		String registerLink = "/mobile/user/registerLink?userId=" + userId + "&userPhone=" + userPhone;
		redirect(registerLink);
	}
	
	/**
	 * 注册链接 
	 * @author wh
	 * @since 2016-11-11
	 */
	@Clear
	public void registerLink(){
		renderJsp("/userpage/create_user.jsp");
	}
	
	/**
	 * 推荐注册(添加新农场)
	 * @author wh
	 * @since 2016-11-3
	 */
	@Clear
	public void register() throws Exception{
		Map<String, Object> paramMap = ToolUtils.chageParaMap(getParaMap());
		// 新用户奖励
		Long count = User.dao.findCount();
		if(count <= 1000){
			// 赠送5包肥料
			paramMap.put("fertilizer", 5);
		}
		// 添加农场记录
		User user = User.dao.addFarm(paramMap);
		
		if(user != null){
			setSessionAttr("user", user);
			redirect("/mobile/user/getFarmDetail");
		}
	}
	
	/**
	 * 查询三代关系
	 * @author wh
	 * @return 
	 * @since 2016-11-10
	 */
	public Map<String, String> findThree(User farm){
		Map<String, String> map = User.dao.findThree(farm.get("userId"));
		return map;
	}
	
	/**
	 * 查看农场详情
	 * @author wh
	 * @since 2016-11-9
	 */
	public void getFarmDetail(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
//		Long animalDueTime = farm.get("animalDueTime");
//		String dueTime = ToolUtils.MsecToDateString(animalDueTime);
		// 可能用户在登陆之后购买了东西,所以要重新查询数据
		setAttr("farm", farm);
		renderJsp("/userpage/farmDetail.jsp");
	}
	
	/**
	 * 查看土地详情
	 * @author wh
	 * @since 2016-11-9
	 */
	public void getLandDetail(){
		User loginUser = (User) getSession().getAttribute("user");
		String userId = loginUser.get("userId").toString();
		updateFruit(userId);
		List<Record> landInfo = Land.dao.getPlantDetail(userId);
		// 本课果树的今天的总果实产量
		setAttr("farmInfo", landInfo);
		renderJsp("/userpage/LandDetail.jsp");
	}
	
	/**
	 * 一键摘取果实 
	 * @author wh
	 * @since 2016-11-10
	 */
	public void keyPick(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		String farmId = farm.get("userId").toString();
		// 更新该农场的果树
		updateFruit(farmId);
		// 得到该农场的所有的已施肥并且有果实的果树
		List<LandTree> landTrees = LandTree.dao.findIncomeTree(farmId);
		
		// 没有收益
		if(landTrees.size() == 0){
			renderJsonError(RequestError, "您还没有可收取的果实!");
			return;
		}
		
		// 摘取的果实的收益
		double income = 0;
		
		for(LandTree landTree : landTrees){
			// 在摘取表中添加记录
			TempPick tempPick = new TempPick();
			tempPick.set("tempPickId", null);
			tempPick.set("treeId", landTree.get("landTreeId"));
			
			// 该课果树的当前果实产量
			Integer currFruitNum = landTree.getInt("currFruitNum");
			// 给该课果树添加总果实产量
			landTree.set("fruitsNum", landTree.getInt("fruitsNum") + currFruitNum).update();
			
			if(landTree.getInt("treeType") == 1){
				income += currFruitNum * 1.5;
				tempPick.set("pickIntegral", currFruitNum * 1.5);
			}else if(landTree.getInt("treeType") == 2){
				income += currFruitNum * 3;
				tempPick.set("pickIntegral", currFruitNum * 3);
			}else if(landTree.getInt("treeType") == 3){
				income += currFruitNum * 4.5;
				tempPick.set("pickIntegral", currFruitNum * 4.5);
			}
			
			// 在摘取表中记录
			tempPick.set("pickFruitNum", currFruitNum);
			tempPick.set("pickFruitTime", new Date());
			tempPick.save();
		}
		
		// 把收益添加到用户的积分
		double farmIntegral = farm.getDouble("farmIntegral");
		farm.set("farmIntegral", (farmIntegral + income)).update();
		renderJsonError(RequestNormal, "摘取果实收获" + income + "积分成功,请刷新本页面!");
	}

	/**
	 * 更新用户农场的果实
	 * @author wh
	 * @since 2016-11-14
	 * @param user
	 */
	public void updateFruit(String userId) {
		//查询该农场的土地信息,种植信息,和每棵树的最后摘取时间
		List<Record> landMiddle = LandTree.dao.findFarmTree(userId);
		
		// 得到该农场今天被偷得记录(一天一个用户只能有一棵树被偷)
		Steal stealTree = Steal.dao.findSteal(userId);
		int strealTreeId = 0;
		int stealFruitNum = 0;
		if(stealTree != null){
			strealTreeId = stealTree.getInt("strealTreeId");
			stealFruitNum = stealTree.getInt("stealFruitNum");
		}
		
		// 计算每一个种植的施肥时间或摘取时间
		for(Record record : landMiddle){
			Date oldTime = null;
			Date getRichTime = record.getDate("getRichTime");
			Date pickFruitTime = record.getDate("pickFruitTime");
			Integer isRich = record.getInt("isRich");
			//如果该土地没有种植或者种植了没有施肥
			if(isRich == null || isRich == 0){
				record.set("fruitsNum", 0);
				continue;
			}else if(pickFruitTime == null && getRichTime != null){
				oldTime = getRichTime;
			}else{
				oldTime = getRichTime.getTime() > pickFruitTime.getTime() ? getRichTime : pickFruitTime;
			}
			Date currentTime = new Date();
			// 时间差
			Long timeInterval = (currentTime.getTime() - oldTime.getTime());
			// 所结的果实数量
			double fruitsNum = (timeInterval / (long) 3600000) * 2;
			
			// 查询今天所摘取该课果树的果实总数量
			String daytempPickNum = String.valueOf(TempPick.dao.findPickCount(record.get("landTreeId")).get("pickCount"));
			Double daytempPickCount = null;
			if(daytempPickNum.equals("null")){// 说明今天没有摘取果实
				daytempPickCount = 0.0;
			}else{
				daytempPickCount = Double.valueOf(daytempPickNum);
			}
			
			// 每天最多可产12个果实
			if(fruitsNum >= (12 - daytempPickCount)){
				fruitsNum = (12 - daytempPickCount);
			}
			LandTree landTree = LandTree.dao.findById(record.get("landTreeId"));
			// 判断该果树产生的收益是否满足120份
			Integer fruitsCount = landTree.getInt("fruitsNum");
			if(fruitsNum >= (120 - fruitsCount)){
				fruitsNum = (120 - fruitsCount);
			}
			
			// 如果该课果树是今天被偷的果树
			if(landTree.getInt("landTreeId") == strealTreeId){
				fruitsNum -= stealFruitNum;
				if(fruitsNum < 0){
					fruitsNum = 0;
				}
			}
			// 保存当前的果实数量
			landTree.set("currFruitNum", fruitsNum).update();
		}
	}
	
	/**
	 * 用户退出登录
	 * @author wh
	 * @since 2016-11-9
	 */
	public void userQuit(){
		getSession().removeAttribute("user");
		redirect("/userpage/login.jsp");
	}
	
	/**
	 * 查询该用户和直推人的详情
	 * @author wh
	 * @since 2016-11-9
	 */
	public void getRelative(){
		// 查询该用户和其推荐人的信息
		User user = (User) getSession().getAttribute("user");
		Map<String, String> map = findThree(user);
		if(map.get("one") != null){
			setAttr("one", User.dao.findById(map.get("one")));
		}
		if(map.get("two") != null){
			setAttr("two", User.dao.findById(map.get("two")));
		}
		if(map.get("three") != null){
			setAttr("three", User.dao.findById(map.get("three")));
		}
		
		renderJsp("/userpage/aboutMe.jsp");
	}
	
	/**
	 * 商店买树(自动充值)
	 * @author wh
	 * @since 2016-11-9
	 */
	public void buyTree(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		Map<String, String> paramMap = ToolUtils.chageParaMapToString(getParaMap());
		if(paramMap.size() <= 1){
			renderJsonError(RequestError, "请选择购买数量!");
			return;
		}
		
		// 查询该农场可以种植的土地(已经开耕的土地)
		List<Land> lands = Land.dao.findPlantLand(farm.get("userId"));
		int treeCount = 0;
		int orangeTreeNum = 0;
		int appleTreeNum = 0;
		int bananaTreeNum = 0;
		double priceCount = 0;// 总价格
		if(paramMap.containsKey("orange")){
			// 橘子树的课数
			orangeTreeNum += Integer.valueOf(paramMap.get("orange"));
			priceCount += orangeTreeNum * 100;
		}
		
		if(paramMap.containsKey("apple")){
			// 苹果树的课数
			appleTreeNum += Integer.valueOf(paramMap.get("apple"));
			priceCount += appleTreeNum * 200;
		}
		
		if(paramMap.containsKey("banana")){
			// 香蕉树的课数
			bananaTreeNum += Integer.valueOf(paramMap.get("banana"));
			priceCount += bananaTreeNum * 300;
		}
		
		// 所购买的树木的总数
		treeCount += orangeTreeNum + appleTreeNum + bananaTreeNum;
		
		// 如果所剩的土地数小于购买的数的数量
		if(lands.size() < treeCount){
			renderJsonError(RequestError, "您所剩余的土地不足!");
			return;
		}
		
		if(Integer.valueOf(paramMap.get("buyType")) == 1){// 余额购买
			// 判断用户余额够不够
			double farmMoney = farm.get("userMoney");
			if(farmMoney < priceCount){
				renderJsonError(RequestError, "您的余额不足!");
				return;
			}
			farm.set("userMoney", farmMoney - priceCount).update();
		}else{// 积分购买
			// 判断用户的积分够不够
			double farmIntegral = farm.getDouble("farmIntegral");
			if(farmIntegral < (priceCount * 0.95)){
				renderJsonError(RequestError, "您的积分不足!");
				return;
			}
			farm.set("farmIntegral", farmIntegral - (priceCount * 0.95)).update();
		}
		
		// 土地种植树木
		// {banana=3, orange=1, apple=2}
		for(int i = 0; i < lands.size(); i++){
			String landId = lands.get(i).get("landId").toString();
			LandTree landTree = new LandTree();
			landTree.set("landTreeId", null);
			landTree.set("landId", landId);
			landTree.set("treeFarmId", farm.get("userId"));
			landTree.set("isRich", TreeFatEnum.未施肥.ordinal());
			if(i < orangeTreeNum){// id=1
				landTree.set("treeType", 1);
			}else if(orangeTreeNum <= i && i < orangeTreeNum + appleTreeNum){// id=2
				landTree.set("treeType", 2);
			}else if(orangeTreeNum + appleTreeNum <= i && i < treeCount){// id=3
				landTree.set("treeType", 3);
			}else{
				break;
			}
			landTree.save();
		}
		
		// 三代添加积分
		Map<String, String> threeMap = findThree(farm);
		for(String str : threeMap.keySet()){
			User user = null;
			if(str.equals("one") && threeMap.get("one") != null){//5%
				user = User.dao.findById(threeMap.get("one"));
				Double farmIntegral =  user.getDouble("farmIntegral") + (priceCount * 0.05);
				user.set("farmIntegral", farmIntegral).update();
			}else if(str.equals("two") && threeMap.get("two") != null){//2%
				user = User.dao.findById(threeMap.get("two"));
				Double farmIntegral =  user.getDouble("farmIntegral") + (priceCount * 0.02);
				user.set("farmIntegral", farmIntegral).update();
			}else if(str.equals("three") && threeMap.get("three") != null){//1%
				user = User.dao.findById(threeMap.get("three"));
				Double farmIntegral =  user.getDouble("farmIntegral") + (priceCount * 0.01);
				user.set("farmIntegral", farmIntegral).update();
			}
		}
		
		renderJsonError(RequestNormal, "购买并种植成功!");
	}
	
	/**
	 * 购买神兽
	 * @author wh
	 * @since 2016-11-14
	 */
	public void buyAnimal(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		Map<String, String> paramsMap = ToolUtils.chageParaMapToString(getParaMap());
		// 查询该用户是否有神兽
		if(Animal.dao.findAnimalByFarmId(farm.get("userId")) != null){
			renderJsonError(RequestError, "您已购买了神兽!");
			return;
		}
		
		if(Integer.valueOf(paramsMap.get("buyType")) == 1){// 余额购买
			// 判断该用户的余额是否够买神兽
			Double oldMoney = farm.getDouble("userMoney");
			if(oldMoney < 1000){
				renderJsonError(RequestError, "您的余额不足!");
				return;
			}
			farm.set("userMoney", (oldMoney - 1000));
		}else{
			Double farmIntegral = farm.getDouble("farmIntegral");
			if(farmIntegral < (1000 * 0.95)){
				renderJsonError(RequestError, "您的积分不足!");
				return;
			}
			farm.set("farmIntegral", (farmIntegral - (1000 * 0.95)));
		}
		farm.update();
		// 添加神兽数据
		Animal animal = new Animal();
		animal.set("animalId", null);
		animal.set("aniFarmId", farm.get("userId"));
		animal.save();
		renderJsonError(RequestNormal, "购买神兽成功!");
	}
	
	/**
	 * 购买肥料和肉
	 * @author wh
	 * @since 2016-11-11
	 */
	public void buyFood(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		Map<String, String> paramMap = ToolUtils.chageParaMapToString(getParaMap());
		// {meat=2, fertilizer=1}
		if(paramMap.size() == 1){
			renderJsonError(RequestError, "请选择要购买的商品!");
			return;
		}
		int fertilizerNum = 0;
		double fertilizerPriceCount = 0.0;
		int meatNum = 0;
		double meatPriceCount = 0.0;
		
		if(paramMap.containsKey("fertilizer")){
			// 肥料的数量
			fertilizerNum += Integer.valueOf(paramMap.get("fertilizer"));
			// 肥料的总价
			fertilizerPriceCount += fertilizerNum * 2;
		}
		
		if(paramMap.containsKey("meat")){
			// 肉的数量
			meatNum += Integer.valueOf(paramMap.get("meat"));
			// 肉的总价
			meatPriceCount += meatNum * 20;
		}
		
		// 给该用户扣钱或积分
		if(Integer.valueOf(paramMap.get("buyType")) == 1){// 余额购买
			double userMoney = farm.getDouble("userMoney");
			if(userMoney < (fertilizerPriceCount + meatPriceCount)){
				renderJsonError(RequestError, "您的余额不足!");
				return;
			}
			farm.set("userMoney", (userMoney - fertilizerPriceCount - meatPriceCount));
		}else{// 积分购买
			// 判断用户的积分够不够
			double farmIntegral = farm.getDouble("farmIntegral");
			if(farmIntegral < (fertilizerPriceCount + meatPriceCount) * 0.95){
				renderJsonError(RequestError, "您的积分不足!");
				return;
			}
			farm.set("farmIntegral", farmIntegral - ((fertilizerPriceCount + meatPriceCount) * 0.95));
		}
		
		
		Long fertilizer = farm.get("fertilizer");
		Integer remainMeat = farm.getInt("remainMeat");
		farm.set("fertilizer", (fertilizer + fertilizerNum));
		farm.set("remainMeat", (remainMeat + meatNum));
		farm.update();
		renderJsonError(RequestNormal, "购买成功");
	}
	
	/**
	 * 一键施肥
	 * @author wh
	 * @since 2016-11-10
	 */
	public void keyFertile(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		
		int needFertileCount = 0;// 农场树木所需肥料的总数量
		
		// 查询该农场需要施肥的果树
		List<LandTree> landTrees = LandTree.dao.findRichTree(farm.get("userId"));
		
		if(landTrees.size() == 0){
			renderJsonError(RequestError, "没有需要施肥的果树!");
			return;
		}
		
		// 计算这些果树需要的肥料的总数量
		for(LandTree landTree : landTrees){
			int treeType = Integer.valueOf(landTree.get("treeType").toString());
			if(treeType == 1){
				needFertileCount += 1;
			}else if(treeType == 2){
				needFertileCount += 2;
			}else if(treeType == 3){
				needFertileCount += 3;
			}
		}
		
		// 判断用户的所剩肥料够不够本次施肥
		Long fertilizer = farm.get("fertilizer");
		if(fertilizer < needFertileCount){
			renderJsonError(RequestError, "您所剩的肥料不足,请到商店购买!");
			return;
		}
		
		// 施肥
		for(LandTree landTree : landTrees){
			landTree.set("isRich", 1);
			landTree.set("getRichTime", new Date());
			landTree.update();
		}
		
		// 给用户扣除肥料
		farm.set("fertilizer", fertilizer - needFertileCount);
		farm.update();
		
		renderJsonError(RequestNormal, "一键施肥成功,请刷新本页面!");
	}
	
	
	
	/**
	 * 购买租的守护兽
	 * @author wh
	 * @since 2016-11-10
	 */
	public void buyRentAnimal(){
		// 租用守护兽1天使用权
		Long animalDueTime = ToolUtils.getMsecNum(1);
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		farm.set("farmAnimal", FarmAnimalEnum.有守护兽.ordinal());
		farm.set("animalDueTime", animalDueTime);
		farm.update();
		renderJsonError(RequestNormal, "守护兽租用成功!");
	}
	
	/**
	 * 土地开耕 
	 * @author wh
	 * @since 2016-11-11
	 */
	public void openLand(){
		User loginUser = (User) getSession().getAttribute("user");
		// 判断该用户今天是否已经开耕过
		if(OpenLand.dao.dayOpen(loginUser.get("userId"))){
			renderJsonError(RequestError, "您今天已经开耕过土地了!");
			return;
		}
		// 开耕土地
		Land.dao.openLand(loginUser.get("userId"));
		renderJsonError(RequestNormal, "开耕土地成功!");
		return;
	}
	
	/**
	 * 查询该用户的下级
	 * @author wh
	 * @since 2016-11-11
	 */
	public void downQuery(){
		User loginUser = (User) getSession().getAttribute("user");
		List<User> downUser = User.dao.downQuery(loginUser.get("userId"));
		User upUser = User.dao.findUp(loginUser.get("userId"));
		setAttr("upUser", upUser);
		setAttr("downUser", downUser);
		renderJsp("/userpage/aboutMe.jsp");
	}
	
	
	/**
	 * 激活土地
	 * @author wh
	 * @since 2016-11-10
	 */
	public void activeLand(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		String userId = farm.get("userId").toString();
		if(User.dao.isActive(userId).size() > 0){
			renderJsonError(RequestError, "该用户已激活!");
			return;
		}else{
			// 判断该用户是否有余额激活土地
			double userMoney = farm.getDouble("userMoney");
			if(userMoney < 56){
				renderJsonError(RequestError, "您的余额不足,无法激活!");
				return;
			}
			// 给该用户扣除56元
			farm.set("userMoney", (userMoney - 56)).update();
			// 给该农场添加土地
			Land.dao.addLand(userId);
			// 给该用户的推荐人加积分
			User.dao.addReinte(farm.get("refereeId"));
			renderJsonError(RequestNormal, "激活成功!");
		}
		
	}
	
	/**
	 * 用户申请积分提现
	 * @author wh
	 * @since 2016-11-12
	 */
	public void ashCash(){
		Map<String, Object> parasMap = ToolUtils.chageParaMap(getParaMap());
		// 先判断该用户的积分是否够提现
		String cashUserId = parasMap.get("cashUserId").toString();
		// 这次提现的积分
		Double cashIntegral = Double.valueOf(parasMap.get("cashIntegral").toString());
		// 该用户有的积分
		double farmIntegral = User.dao.findById(cashUserId).getDouble("farmIntegral");
		if(farmIntegral < cashIntegral){
			renderJsonError(RequestError, "您的积分不足!");
			return;
		}
		// 给该用户扣除积分
		User.dao.findById(cashUserId).set("farmIntegral", (farmIntegral - cashIntegral)).update();
		// 添加几天记录
		AskCash askCash = new AskCash();
		askCash.set("askCashId", null);
		askCash.put(parasMap);
		askCash.save();
		
		renderJsonError(RequestNormal, "提现申请成功,请等待管理员打款!");
	}
	
	/**
	 * 用户查询自己的提现记录
	 * @author wh
	 * @since 2016-11-12
	 */
	public void findAskCashRecord(){
		User loginUser = (User) getSession().getAttribute("user");
		List<AskCash> askCashs = AskCash.dao.findAskCashRecord(loginUser.get("userId"));
		setAttr("askCashs", askCashs);
		renderJsp("/userpage/askCashRecord.jsp");
	}
	
	/**
	 * 用户查询自己的获得积分记录 
	 * @author wh
	 * @since 2016-11-12
	 */
	public void findGetIntegralRecord(){
		User loginUser = (User) getSession().getAttribute("user");
		List<Record> records = User.dao.findGetIntegralRecord(loginUser.get("userId"));
		setAttr("records", records);
		renderJsp("/userpage/getIntegerRecord.jsp");
	}
	
	/**
	 * 查询用户的神兽详情
	 * @author wh
	 * @since 2016-11-14
	 */
	public void checkAnimalDetail(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		// 更新收益
		updateAnimal(farm.get("userId").toString());
		Animal animal = Animal.dao.findAnimalByFarmId(farm.get("userId"));
		
		setAttr("animal", animal);
		renderJsp("/userpage/animalDetail.jsp");
	}
	
	/**
	 * 收取收益
	 * @author wh
	 * @since 2016-11-14
	 */
	public void getAnimalIncome(){
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		// 更新收益
		Animal animal = updateAnimal(farm.get("userId").toString());
		
		// 把当前的收益添加到总收益
		double currCount = animal.getDouble("currCount");
		if(currCount == 0){
			renderJsonError(RequestError, "您还没有收益可领取!");
			return;
		}
		Integer incomeCount = animal.getInt("incomeCount");
		// 添加积分
		double farmIntegral = farm.getDouble("farmIntegral");
		farm.set("farmIntegral", farmIntegral + (currCount * 20)).update();
		// 修改数据
		animal.set("incomeCount", (incomeCount + currCount));
		animal.set("currCount", 0);
		animal.update();
		
		// 添加一条收益记录
		AnimalIncome animalIncome = new AnimalIncome();
		animalIncome.set("incomeId", null);
		animalIncome.set("incomeAnimalId", animal.get("animalId"));
		animalIncome.set("animalIncomeNum", currCount);
		animalIncome.set("animalIncomeCount", (currCount * 20));
		animalIncome.set("animalIncomeTime", new Date());
		animalIncome.save();
		
		renderJsonError(RequestNormal, "领取" + (currCount * 20) + "积分成功!");
	}
	
	/**
	 * 更新神兽的收益
	 * @author wh
	 * @since 2016-11-15
	 * @param userId
	 * @return 
	 */
	public Animal updateAnimal(String farmId) {
		//查询该农场的已经喂食过的神兽(只有一只)
		Record record = Animal.dao.findAnimalIncomeDetail(farmId);
		// 如果该用户没有神兽或者神兽没有喂食
		if(record == null){
			return null;
		}
		
		Date oldTime = null;
		Date feedTime = record.getDate("feedTime");
		Date animalIncomeTime = record.getDate("animalIncomeTime");
		//如果该神兽今天没有收取过收益
		if(animalIncomeTime == null && feedTime != null){
			oldTime = feedTime;
		}else{
			oldTime = feedTime.getTime() > animalIncomeTime.getTime() ? feedTime : animalIncomeTime;
		}
		Date currentTime = new Date();
		// 时间差
		Long timeInterval = (currentTime.getTime() - oldTime.getTime());
		// 所得的收益份数
		double incomeNum = (timeInterval / (long) 3600000) * 2;
		
		// 查询今天所摘取该课果树的果实总数量
		String dayIncomeNum = Animal.dao.findIncomeCount(record.get("animalId"));
		Double dayIncomeCount = null;
		if(dayIncomeNum.equals("null")){
			dayIncomeCount = 0.0;
		}else{
			dayIncomeCount = Double.valueOf(dayIncomeNum);
		}
		
		// 每天最多可产12份收益
		if(incomeNum >= (12 - dayIncomeCount)){
			incomeNum = (12 - dayIncomeCount);
		}
		Animal animal = Animal.dao.findById(record.get("animalId"));
		// 判断该神兽产生的收益是否满足120份
		Integer incomeCount = animal.getInt("incomeCount");
		if(incomeNum >= (120 - incomeCount)){
			incomeNum = (12 - incomeCount);
		}
		
		// 保存当前的收益数量
		animal.set("currCount", incomeNum).update();
		return animal;
	}
	
	
	
	/**
	 * 喂食
	 * @author wh
	 * @since 2016-11-14
	 */
	public void setFeed(){
		// 给该用户的神兽喂食
		User loginUser = (User) getSession().getAttribute("user");
		User farm = User.dao.findById(loginUser.get("userId"));
		Animal animal = Animal.dao.findAnimalByFarmId(farm.get("userId"));
		// 判断该神兽是否已喂食
		if(animal.getInt("isFeed") == 1){// 已喂食
			renderJsonError(RequestError, "该神兽今天已喂食,请明天再来!");
			return;
		}
		// 扣除用户的肉
		Integer remainMeat = farm.getInt("remainMeat");
		if(remainMeat < 1){
			renderJsonError(RequestError, "您剩余的肉不足,请去商城购买!");
			return;
		}
		farm.set("remainMeat", (remainMeat - 1)).update();
		
		animal.set("isFeed", 1);
		animal.set("feedTime", new Date());
		animal.update();
		renderJsonError(RequestNormal, "神兽喂食成功!");
	}
	
	/**
	 * 偷取果实
	 * @author wh
	 * @since 2016-11-14
	 */
	public void steal(){
		User loginUser = (User) getSession().getAttribute("user");
		String userId = loginUser.get("userId").toString();
		Map<String, String> paramsMap = ToolUtils.chageParaMapToString(getParaMap());
		String steal = paramsMap.get("steal");
		// 查询该用户今天是否被偷取过果实
		Steal stealTree = Steal.dao.findSteal(steal);
		if(stealTree != null){//已被偷取过
			renderJsonError(RequestError, "该用户已被偷取过!");
			return;
		}
		
		// 更新被偷人的果实
		updateFruit(steal);
		// 判断本次偷取成功还是失败
		// 判断是否有守护兽
		// 查询被偷人的所有果树(100%成功)
		List<LandTree> landTrees = LandTree.dao.findFruitTree(steal);
		Integer currFruitCount = 0;
		Integer stealNum = 0;
		double IntegralNum = 0;
		
		// 如果有结果实的果树
		if(landTrees.size() > 0){
			for(LandTree landTree : landTrees){
				currFruitCount += landTree.getInt("currFruitNum");
			}
			if(currFruitCount < 12){
				stealNum = 1;
			}else{
				stealNum = 2;
			}
			
			LandTree landTree = landTrees.get(0);
			landTree.set("currFruitNum", (landTree.getInt("currFruitNum") - stealNum)).update();
			// 查询获得了多少积分
			if(landTree.getInt("treeType") == 1){
				IntegralNum = stealNum * 1.5;
			}else if(landTree.getInt("treeType") == 2){
				IntegralNum = stealNum * 3;
			}else{
				IntegralNum = stealNum * 4.5;
			}
			
			// 偷取记录表添加记录
			Steal stealRecord = new Steal();
			stealRecord.set("stealId", null);
			stealRecord.set("farmId", steal);
			stealRecord.set("strealTreeId", landTree.get("landTreeId"));
			stealRecord.set("stealFruitNum", stealNum);
			stealRecord.save();
			
			// 给该用户添加积分
			User farm = User.dao.findById(userId);
			double farmIntegral = farm.getDouble("farmIntegral");
			farm.set("farmIntegral", farmIntegral + IntegralNum).update();
			
			renderJsonError(RequestNormal, "偷取果实成功,获得" + IntegralNum + "积分!");
			return;
		}
		renderJsonError(RequestError, "该用户没有可被偷的果树,过会再来吧!");
		return;
	}
	
	@Clear
	public void txTest(){
		// 添加一个animal
		/*Animal animal = new Animal();
		animal.setAniFarmId(1);
		animal.setIncomeCount(2);
		animal.save();
		
		System.out.println(animal.getAnimalId() - 1);
		
		// 删除一个animal
		Animal.dao.deleteById(animal.getAnimalId() - 1);
		
		System.out.println(1/0);*/
		
		log.info("test log ...");
		
		renderText("saveAnimalSuccess...");
	}
	
	public static void main(String[] args) {
		Integer currFruitNum = 12;
		System.out.println(currFruitNum * 0.05);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

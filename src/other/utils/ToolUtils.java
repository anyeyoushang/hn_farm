package other.utils;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import net.coobird.thumbnailator.Thumbnails;

import com.jfinal.kit.PathKit;
import com.jfinal.upload.UploadFile;

public class ToolUtils {

	/**
	 * 通过反射获得该类的指定方法
	 * 
	 * @author wh
	 * @since 2016-10-25
	 * @param className 类名
	 * @param methodName 方法名
	 * @param paraType 参数类型实例
	 * @param param 参数
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Object executeMethod(String className, String methodName, Object param) throws Exception{
			Class c = Class.forName(className);
			Object obj = c.getConstructor().newInstance();
			Method m1 = c.getMethod(methodName, param.getClass());
			Object o =  m1.invoke(obj, param);
			return o;
	}
	
	/**
	 * 上传文件
	 * @author wh
	 * @since 2016-10-25
	 * @return
	 */
	public static String upload(UploadFile file) throws IOException {
		String saveName;
		String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
		// 获得上传文件的名称
		String fileName = file.getFileName();
		
		// 处理文件名的局对路径问题
		int index = fileName.lastIndexOf("\\");
		if(index != -1){
			fileName = fileName.substring(index + 1);
		}
		// 处理文件名
		saveName = uuid + "_" + new Date().getTime() + fileName.substring(fileName.lastIndexOf("."));
		
		String root = PathKit.getWebRootPath().replaceFirst("jfinal", "jfinalHeadImg");
		// 生成文件存放的文件夹
		File dirFile = new File(root);
		if(!dirFile.exists()){
			dirFile.mkdir();
		}
		// 数据库中保存图片的访问路径
		// 创建目录文件
		File destFile = new File(dirFile, saveName);
		//File aa = file.getFile();
		Thumbnails.of(file.getFile()).size(200, 200).toFile(destFile);
		return saveName;
	}
	
	
	/**
	 * 获得新的参数map
	 * @author wh
	 * @since 2016-10-25
	 * @param map
	 * @return
	 */
	public static Map<String, Object> chageParaMap(Map<String, String[]> map) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		for(String str : map.keySet()){
			// 如果值的数组长度大于1
			if(map.get(str).length > 1){
				// 直接put该数组
				paramMap.put(str, map.get(str));
			}else{
				paramMap.put(str, map.get(str)[0]);
			}
		}
		return paramMap;
	}
	
	/**
	 * 获得新的参数map
	 * @author wh
	 * @since 2016-10-25
	 * @param map
	 * @return
	 */
	public static Map<String, String> chageParaMapToString(Map<String, String[]> map) {
		Map<String, String> paramMap = new HashMap<String, String>();
		for(String str : map.keySet()){
			paramMap.put(str, map.get(str)[0]);
		}
		return paramMap;
	}
	
	/**
	 * 判断是不是ajax请求
	 * @author wh
	 * @since 2016-11-8
	 * @param request
	 * @return true是,false不是
	 */
	public static boolean isAjax(HttpServletRequest request){
		String str = request.getHeader("X-Requested-With");
		return (str != null) ? true : false;
	}
	
	/**
	 * 得到天数后的毫秒数
	 * @author wh
	 * @since 2016-11-8
	 * @param dayNum
	 * @return
	 */
	public static Long getMsecNum(int dayNum){
		return new Date().getTime() + 86400000 * dayNum;
	}
	
	/**
	 * 把毫秒数转为date字符串
	 * @author wh
	 * @since 2016-11-9
	 * @param Msec
	 */
	public static String MsecToDateString(Long Msec){
		Date date = new Date(Msec);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(date);
	}
	
	public static void main(String[] args) {
		System.out.println(new Date().getTime());
		System.out.println(getMsecNum(1));
	}
}











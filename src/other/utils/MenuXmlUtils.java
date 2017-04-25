package other.utils;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.jfinal.kit.PathKit;
import com.jfinal.kit.StrKit;

/**
 * menus.xml文件操作类
 * @author Janesen
 *
 */
public class MenuXmlUtils {

	
	/**
	 * 将menus.xml转换成java对象，
	 * @param xmlFile 文件名，默认为menus.xml,必须在src目录下
	 * @return
	 */
	public static List<TreeEntity> getMenus(){
		// dom4j解析xml文件
		SAXReader saxReader = new SAXReader();
		try {
			List<TreeEntity> list = new ArrayList<TreeEntity>();
			File[] databaseXmlFiles = new File(PathKit.getRootClassPath()).listFiles(new FilenameFilter() {
				@Override
				public boolean accept(File dir, String name) {
					return name.startsWith("menus")&&name.endsWith(".xml");
				}
			});
			for (File file : databaseXmlFiles) {
				Document document = saxReader.read(file);
				Element rootE = document.getRootElement();
				if(file.getName().equals("menus.xml")){
					list.addAll(0,getMenus(rootE));
				}else{
					list.addAll(getMenus(rootE));
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 解析menu.xml的数据
	 * @param element
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private static List<TreeEntity> getMenus(Element element){
		try {
			List<TreeEntity> list=new ArrayList<TreeEntity>();
			List<Element> childs=element.elements();
			if(childs!=null&&childs.size()!=0){
				for (Element e : childs) {
					TreeEntity treeEntity=new TreeEntity();
					List<Attribute> tableAttr = e.attributes();
					for (Attribute attribute : tableAttr) {
						String attrName = attribute.getName();
						MethodUtils.invokeMethod(treeEntity,
								"set" + StrKit.firstCharToUpperCase(attrName),
								attribute.getValue());
					}
					if(StringUtils.isEmpty(treeEntity.getText())){
						throw new NullPointerException("text属性不可为空！");
					}
					
					if(StringUtils.isEmpty(treeEntity.getId())){
						treeEntity.setId(MD5Encrypt.MD5(treeEntity.getText()+System.currentTimeMillis()));
					}
					
					list.add(treeEntity);
					List<TreeEntity> nextChild=getMenus(e);
					treeEntity.setChildren(nextChild);
					if(nextChild==null){
						treeEntity.setLeaf(true);
					}
				}
			}else{
				return null;
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}
	
}

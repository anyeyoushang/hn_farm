package other.utils;

import java.util.List;


/**
 * extjs 框架下的treeview控件实体类
 * @author Janesen
 *
 */
public class TreeEntity {
	private String id;
	private String text;//显示的文本
	private Boolean leaf;//是否是最后一级
	private String parentId;//上级id
	private Boolean checked;//是否选中
	private Integer depth;//层级
	private String tag;
	private String roles="";
	private String icon;
	private String href="";
	private List<TreeEntity> children;
	
	public String getId() {
		if(id==null&&text!=null){
			id=MD5Encrypt.MD5(text);
		}
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Boolean getLeaf() {
		return leaf;
	}
	public void setLeaf(Boolean leaf) {
		this.leaf = leaf;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	public Integer getDepth() {
		return depth;
	}
	public void setDepth(Integer depth) {
		this.depth = depth;
	}
	public List<TreeEntity> getChildren() {
		return children;
	}
	public void setChildren(List<TreeEntity> children) {
		this.children = children;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getRoles() {
		return roles;
	}
	public void setRoles(String roles) {
		this.roles = roles;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	
	
	
}

package model.basemodel;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseTempPick<M extends BaseTempPick<M>> extends Model<M> implements IBean {

	public void setTempPickId(java.lang.Integer tempPickId) {
		set("tempPickId", tempPickId);
	}

	public java.lang.Integer getTempPickId() {
		return get("tempPickId");
	}

	public void setTreeId(java.lang.Integer treeId) {
		set("treeId", treeId);
	}

	public java.lang.Integer getTreeId() {
		return get("treeId");
	}

	public void setPickFruitNum(java.lang.Integer pickFruitNum) {
		set("pickFruitNum", pickFruitNum);
	}

	public java.lang.Integer getPickFruitNum() {
		return get("pickFruitNum");
	}

	public void setPickIntegral(java.lang.Integer pickIntegral) {
		set("pickIntegral", pickIntegral);
	}

	public java.lang.Integer getPickIntegral() {
		return get("pickIntegral");
	}

	public void setPickFruitTime(java.util.Date pickFruitTime) {
		set("pickFruitTime", pickFruitTime);
	}

	public java.util.Date getPickFruitTime() {
		return get("pickFruitTime");
	}

}

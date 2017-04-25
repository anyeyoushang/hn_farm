package service;

import java.util.HashMap;
import java.util.Map;

public interface SysService {
	boolean addData(HashMap<String, Object> paramMap);
	boolean deleteData(HashMap<String, Object> paramMap);
	void updateData(HashMap<String, Object> paramMap);
	Map<String, Object> getDataList(HashMap<String, String> paramMap);
}

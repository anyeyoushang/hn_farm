package other.plugin;

import com.jfinal.plugin.IPlugin;

public class TestPlugin implements IPlugin {

	@Override
	public boolean start() {
		System.out.println("测试插件start...");
		return true;
	}

	@Override
	public boolean stop() {
		System.out.println("测试插件stop...");
		return true;
	}

}

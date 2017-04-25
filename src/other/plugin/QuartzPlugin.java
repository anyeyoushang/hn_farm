package other.plugin;

import com.jfinal.plugin.IPlugin;

import java.util.*;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.apache.commons.lang3.StringUtils;

public class QuartzPlugin implements IPlugin {
	private Scheduler sched;
	private Properties properties;

	public QuartzPlugin(Properties properties){
		try{
			this.properties = properties;
			sched = StdSchedulerFactory.getDefaultScheduler();
		}catch (SchedulerException e){
			e.printStackTrace();
		}
	}

	public boolean start() {
		for (Enumeration enums = properties.keys(); enums.hasMoreElements();){
			String key = (new StringBuilder()).append(enums.nextElement()).toString();
			if (!StringUtils.equals("job", key) && key.endsWith("job") && isEnableJob(enable(key)))
			{
				String jobClassName = (new StringBuilder()).append(properties.get(key)).toString();
				String jobCronExp = (new StringBuilder(String.valueOf(properties.getProperty(cronKey(key))))).toString();
				JobDetail job = null;
				try {
					job = JobBuilder.newJob((Class)Class.forName(jobClassName))
							.withIdentity(jobClassName).build();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				Trigger trigger = TriggerBuilder.newTrigger().withIdentity(jobClassName).withSchedule(CronScheduleBuilder.cronSchedule(jobCronExp)).startNow().build();
				try
				{
					sched.scheduleJob(job, trigger);
					sched.start();
				}
				catch (SchedulerException e)
				{
					e.printStackTrace();
				}
			}
		}
		return true;
	}

	private String enable(String key){
		return (new StringBuilder(String.valueOf(key.substring(0, key.lastIndexOf("job"))))).append("enable").toString();
	}

	private String cronKey(String key){
		return (new StringBuilder(String.valueOf(key.substring(0, key.lastIndexOf("job"))))).append("cron").toString();
	}

	private boolean isEnableJob(String enableKey){
		Object enable = properties.get(enableKey);
		return enable == null || !"false".equalsIgnoreCase((new StringBuilder()).append(enable).toString().trim());
	}

	public boolean stop(){
		try{
			sched.shutdown();
		}
		catch (SchedulerException e){
			e.printStackTrace();
		}
		return true;
	}

}

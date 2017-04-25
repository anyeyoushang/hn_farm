/*
 * @(#) ClearRich.java 2016-11-11
 *
 * Copyright (c) 2015, HaoniuSoft Technology. All Rights Reserved.
 * HaoniuSoft  Technology. CONFIDENTIAL
 */
package other.job;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import model.dao.Animal;
import model.dao.LandTree;


public class ClearRich implements Job {

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("每天0点的时候清除施肥的树木!");
		// 清楚神兽的喂食
		/*Animal.dao.clearFeed();
		// 清楚果树的施肥
		if(LandTree.dao.clearFert()){
			System.out.println("清除施肥成功!");
		}else{
			System.out.println("清除施肥失败!");
		}*/
	}

}
